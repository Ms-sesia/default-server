import net from "net";
// import crypto from "crypto";
import axios from "axios";
import iconv from "iconv-lite";

export default {
  Mutation: {
    nPayTest: async (_, args, { request, isAuthenticated }) => {
      try {
        // 카드 구분자 : C0 : 신한, C1 : 비씨, C3 : KB국민, C4 : NH농협, C5 : 롯데, C7 : 삼성, C9 : 씨티, CF : 하나, CH : 현대 (없을경우 전체)
        const npayParams = {
          storeid: "2999199999", //	string	10	required	상점아이디
          email: "angra2p@nate.com", //	string	50	option	고객 이메일
          phoneno: "", //	string	12	option	고객 연락처
          ordernumber: "ttd-200406140251-456", //	string	50	required	주문번호
          ordername: "텔레토비", //	string	50	required	주문자명
          goodname: "당근12kg", //	string	64	required	상품명
          amount: "100", //	string	9	required	승인금액
          returnUrl: "http://localhost:4300/api/ksnet/nPayReturn", //	string	3000	required	인증 후 결과값을 받을 가맹점 returnUrl
          // returnUrl: "http://localhost:8080/ksnetTest/pc/npay_return.jsp", //	string	3000	required	인증 후 결과값을 받을 가맹점 returnUrl
          productcount: "1", //	int	undefined	option	상품개수
          availcard: "C0,C1,C3,C4,C5,C7,C9,CF,CH", //	string	2	required	카드 구분자	샘플참조
          processtype: "1", //	string	1	required	플랫폼 구분자	PC : 1, MB : 2
          storename: "KSNET", //	string	50	required	상점명	네이버페이 결제창에 노출 될 상점명
          installment: "00:01:02:03:04:05:06:07:08:09:10:11:12", //	int	2	required	할부개월수	샘플참조
          charset: "utf-8", //	string	0~6	option	가맹점 인코딩	Default EUC-KR
        };

        const nPayReqUrl = "https://kspay.ksnet.to/store/PAY_PROXY/npay/naver_rs_o1.jsp";

        const reqResult = await axios.post(nPayReqUrl, npayParams, {
          responseType: "arraybuffer", // 바이트 배열로 응답 받기
          headers: { "Content-Type": "application/x-www-form-urlencoded" },
        });

        const decodedData = iconv.decode(reqResult.data, "euc-kr");

        return { success: true, message: "결제 요청 성공", data: decodedData };
      } catch (e) {
        const decodedError = e.response ? iconv.decode(e.response.data, "euc-kr") : e.message;

        console.log("결제 요청 실패. error:", decodedError);

        return { success: false, message: "서버와 통신 실패", data: decodedError };
      }
    },
  },
};
