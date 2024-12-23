import net from "net";
import crypto from "crypto";

export default {
  Mutation: {
    test: async (_, args, { request, isAuthenticated }) => {
      try {
        // 소켓에 전송할 메시지 생성
        const message = Buffer.from("테스트 메시지"); // args에서 메시지를 가져올 경우 args로 대체
        const response = await sendEncryptedMessage("210.181.28.137", 21001, message);
        console.log("서버 응답:", response);
        return { success: true, message: "서버와 통신 성공" };
      } catch (e) {
        console.log("test 진행 실패. ₩error:", e.message);
        return { success: false, message: "서버와 통신 실패" };
      }
    },
  },
};

const sendEncryptedMessage = (ip, port, message) => {
  // Step 1: 서버의 공개키 설정 (Java의 SVR_ECDH_PUBLIC_KEY_X, SVR_ECDH_PUBLIC_KEY_Y)
  const serverPublicKeyX = Buffer.from([
    0xdf, 0x52, 0x2c, 0xc6, 0x5d, 0x39, 0x27, 0xe8, 0x83, 0xe6, 0x4a, 0xca, 0x2a, 0x5a, 0xa1, 0x4f, 0x98, 0x10, 0x70,
    0xf7, 0x5c, 0x0c, 0x6f, 0x10, 0xa9, 0xb8, 0x9f, 0x50, 0x14, 0xab, 0xbb, 0x11,
  ]);
  const serverPublicKeyY = Buffer.from([
    0x2a, 0xd5, 0xb2, 0x66, 0x15, 0x37, 0x62, 0x86, 0x18, 0xe6, 0x36, 0x55, 0xd8, 0x5e, 0x94, 0x24, 0x15, 0x53, 0xd2,
    0xf2, 0x97, 0x90, 0xb5, 0xc2, 0x59, 0x73, 0xd2, 0xd8, 0x59, 0x31, 0x09, 0xc3,
  ]);

  // 서버의 공개키는 x와 y 좌표가 연결된 압축되지 않은 형식으로 만듭니다.
  const serverPublicKey = Buffer.concat([Buffer.from([0x04]), serverPublicKeyX, serverPublicKeyY]);

  // Step 2: 클라이언트 ECDH 키 생성
  const clientECDH = crypto.createECDH("prime256v1");
  clientECDH.generateKeys();

  // Step 3: 공유 비밀키 생성
  const sharedSecret = clientECDH.computeSecret(serverPublicKey);

  // Step 4: SHA-256 해시를 통해 AES-128 대칭 키 생성
  const hashSecretKey = crypto.createHash("sha256").update(sharedSecret).digest();
  const aesKey = hashSecretKey.slice(0, 16); // 상위 16바이트 사용

  // Step 5: AES-CBC 모드로 메시지 암호화
  const iv = Buffer.alloc(16, 0); // IV는 16바이트 0으로 초기화
  const cipher = crypto.createCipheriv("aes-128-cbc", aesKey, iv);
  let encryptedMessage = cipher.update(message);
  encryptedMessage = Buffer.concat([encryptedMessage, cipher.final()]);

  // 전송할 데이터 패키지 생성 (암호화 구분 값, 클라이언트 공개키, 암호화된 메시지)
  const payload = Buffer.concat([
    Buffer.from([0x38]), // 암호화 구분 값
    clientECDH.getPublicKey(), // 클라이언트의 공개 키
    encryptedMessage, // 암호화된 메시지
  ]);

  // Step 6: 소켓을 통해 서버로 데이터 전송
  return new Promise((resolve, reject) => {
    const client = net.createConnection({ host: ip, port: port }, () => {
      client.write(payload);
    });

    client.on("data", (data) => {
      // 서버로부터 응답 수신 후 복호화
      const decipher = crypto.createDecipheriv("aes-128-cbc", aesKey, iv);
      let decryptedMessage = decipher.update(data.slice(4)); // 앞 4바이트 제외하고 복호화
      decryptedMessage = Buffer.concat([decryptedMessage, decipher.final()]);
      resolve(decryptedMessage.toString());
      client.end();
    });

    client.on("error", (error) => {
      reject(error);
    });
  });
};
