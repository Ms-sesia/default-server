import net from "net";
import iconv from "iconv-lite";
import crypto from "crypto";

// 서버 정보
const SERVER_IP = "210.181.28.134"; // KSNET 서버 IP, T: 210.181.28.134, R: 210.181.28.137
const SERVER_PORT = 21001; // KSNET 서버 포트
const CONNECT_TIMEOUT = 20000; // 연결 타임아웃 (ms)
const READ_TIMEOUT = 60000; // 읽기 타임아웃 (ms)

// ECDH 및 AES 설정
const ECDH_CURVE = "prime256v1"; // ECDH 커브
const ENCODING = "ms949";

// 소켓 데이터 송수신 함수
async function sendSocketData(data) {
  return new Promise((resolve, reject) => {
    const client = new net.Socket();
    let responseBuffer = Buffer.alloc(0);

    // 연결 타임아웃 설정
    client.setTimeout(CONNECT_TIMEOUT);

    client.connect(SERVER_PORT, SERVER_IP, async () => {
      console.log("Connected to KSNET server.");

      try {
        const dataString = JSON.stringify(data);
        // 데이터 암호화 처리 (ECDH-AES)
        const encryptedData = await encryptData(dataString);
        console.log("Sending data to KSNET:", encryptedData.toString("hex"));

        // 데이터 전송
        client.write(encryptedData);
      } catch (err) {
        console.log("encryption error:", err.message);
        client.destroy();
        reject(err);
      }
    });

    // 데이터 수신 처리
    client.on("data", (chunk) => {
      console.log("data 수신. chunk:", chunk.toString("hex"));
      responseBuffer = Buffer.concat([responseBuffer, chunk]);
    });

    // const decodedResponse = iconv.decode(responseBuffer, ENCODING);
    // console.log("decodedResponse:", decodedResponse);
    // 데이터 수신 완료 시 처리
    client.on("end", () => {
      try {
        const decodedResponse = iconv.decode(responseBuffer, ENCODING);
        console.log("Received data from KSNET server:", decodedResponse);
        resolve(decodedResponse);
      } catch (err) {
        console.error("Response decoding error:", err.message);
        reject(err);
      } finally {
        client.destroy();
      }
    });

    // 오류 처리
    client.on("error", (err) => {
      console.error("Socket error:", err.message);
      reject(err);
    });

    // 읽기 타임아웃 설정
    client.setTimeout(READ_TIMEOUT, () => {
      console.error("Socket timeout");
      client.destroy();
      reject(new Error("Socket timeout"));
    });
  });
}

// 데이터 암호화 (ECDH + AES)
async function encryptData(data) {
  const ecdh = crypto.createECDH(ECDH_CURVE);
  const clientPublicKey = ecdh.generateKeys();

  // 서버의 공개 키 (하드코딩된 값)
  const serverPublicKeyX = Buffer.from("df522cc65d3927e883e64aca2a5aa14f981070f75c0c6f10a9b89f5014abbb11", "hex");
  const serverPublicKeyY = Buffer.from("2ad5b2661537628618e63655d85e94241553d2f29790b5c25973d2d8593109c3", "hex");
  const serverPublicKey = Buffer.concat([Buffer.from([0x04]), serverPublicKeyX, serverPublicKeyY]);

  // 공유 비밀 키 생성
  const sharedSecret = ecdh.computeSecret(serverPublicKey);

  // AES 키 생성 (SHA-256 해시)
  const aesKey = crypto.createHash("sha256").update(sharedSecret).digest().slice(0, 16);

  // AES 암호화
  const iv = Buffer.alloc(16, 0); // IV: 0으로 채움
  const cipher = crypto.createCipheriv("aes-128-cbc", aesKey, iv);
  let encryptedData = cipher.update(data, "utf-8", "binary");
  encryptedData += cipher.final("binary");

  // 최종 메시지 조합 (KSNET 요구사항에 맞게)
  const header = Buffer.alloc(4);
  header.writeInt32BE(encryptedData.length + 4);
  const finalMessage = Buffer.concat([header, Buffer.from(encryptedData, "binary")]);

  return finalMessage;
}

export default sendSocketData;
// // 테스트 실행
// (async () => {
//   const testData = "Test message to KSNET server";

//   try {
//     const response = await sendSocketData(testData);
//     console.log("Final response:", response);
//   } catch (error) {
//     console.error("Error occurred:", error.message);
//   }
// })();
