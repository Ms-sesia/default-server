import { format } from "date-fns";
import sendSocketData from "./socket";

const nPayReturn = async (req, res, next) => {
  const data = req.body;

  // proceed: 'true', // required	인증성공여부	성공: true, 실패 : false
  // cardnumber: '9100250017874208', // required	카드번호
  // expdt: '2803', // required	유효기간
  // cardcode: 'C1', //   required	고객이 선택한 카드사코드	카드사 포인트 승인을 위해 required 카드사코드는 샘플 및 부록 참조
  // paymentId: '20241217NP2010508153', // required	네이버페이 결제번호
  // installment: '0', // required	할부개월수	00 : 일시불, 02~12
  // cavv: '', // required	인증 데이터
  // xid: '', // required	인증 데이터
  // eci: '', // required	인증 데이터
  // trid: 'T42000000007', // required	비씨카드 인증에서 사용되는 ID 값
  // resultMessage: '', // 가변	option	메시지
  // resultCode: 'Success', //
  // amount: '1004',
  // availcard: 'C0,C1,C3,C4,C5,C7,C9,CF,CH',
  // email: 'angra2p@nate.com',
  // goodname: '?�근12kg',
  // ordername: '??????�?',
  // ordernumber: 'ttd-200406140251-456',
  // phoneno: '',
  // processtype: '1',
  // productcount: '1',
  // returnUrl: 'http://localhost:4300/api/ksnet/nPayReturn',
  // storeid: '2999199999',
  // storename: 'KSNET'

  if (data.proceed === "true") {
    console.log("결제됨.");
    const trDate = format(new Date(), "yyyyMMddHHmmss");

    const testMid = "2999199999";

    const mHash = {
      orderNumb: "ttd-200406140251-456",
      interestType: "1",
      taxData: "",
      totalAmount: "100",
      tradeDatetime: "20241223135056",
      track2: "9100250017874208",
      userName: "텔레토비",
      p206: "T42000000007", // 206p:T42000000007,
      payCode: "1000",
      installMonth: "",
      productName: "당근12kg",
      userEmail: "angra2p@nate.com",
      currencyType: "0",
      userIp: "0:0:0:0:0:0:0:1",
    };

    const ksnetSocketReqData = {
      tradeDatetime: trDate, //	required	요청 일시	YYYYMMDDHHMMSS
      mid: testMid, // data.mid, //	required	상점 아이디
      orderNumb: data.ordernumber, //	required	주문번호
      userName: data.ordername, //	required	주문자명
      userInfo: "", // 주민번호
      userEmail: data.email, //	option	이메일
      productType: "2", //	required	상품 아이디	1: 실물, 2: 디지털
      productName: data.goodname, //	required	상품명
      userPhoneNumb: data.phoneno, //	option	휴대폰번호
      cardCode: data.cardcode,
      paymentId: data.paymentId,
      trId: data.trid,
      // ---------------- 이 아래는 신용카드 승인 요청 파라미터
      payCode: "1000", // 승인구분
      interestType: "1", // 무이자구분
      track2: "9100250017874208", // track2
      installMonth: data.installment, // 할부개월수
      totalAmount: data.amount, // 승인요청금액
      password2: "", // 비밀번호
      userInfo: "", // 사업자번호
      currencyType: "0", // 통화코드
      domain: "", // 도메인
      userIp: "0:0:0:0:0:0:0:1", // 업체서버IP
      bizNumb: "", // 사업자번호
      vanTid: "", // VAN거래번호
      subPayCode: "", // memb_card_code
      taxData: "", // 과세정보
      certCode: "", // 인증구분(1) +  MPI Module 위치(1) + Cavv 재사용 YN(1)
      certReq: "", // 인증데이터
    };

    const socketResult = await sendSocketData(ksnetSocketReqData);
    console.log("socketResult:", socketResult);
  } else {
    console.log("네이버 페이 결제 실패. error:", data.resultMessage);
  }

  next();
};

export default nPayReturn;

// payCode: "", //	string	4   	required	승인구분
// interestType: "", //	string	1   	required	일반/무이자구분
// track2: "", //	string	40  	required	track2
// installMonth: "", //	string	2   	required	할부개월수
// totalAmount: "", //	string	9   	required	승인요청금액
// password2: "", //	string	2   	option	비밀번호
// userInfo: "", //	string	10  	option	생년월일/사업자번호
// currencyType: "", //	string	1   	required	통화코드
// domain: "", //	string	40  	option	도메인
// userIp: "", //	string	20  	option	업체서버IP
// bizNumb: "", //	string	10  	option	사업자번호
// vanTid: "", // string	12  	option	VAN거래번호
// subPayCode: "", //	string	5   	option	memb_card_code
// taxData: "", //	string	23  	option	과세정보
// certCode: "", //	string	3   	option	인증구분
// certReq: "", //	string	7168	option	인증데이터
