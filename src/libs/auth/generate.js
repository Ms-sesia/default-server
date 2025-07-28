import jwt from "jsonwebtoken";

// 임시 6자리 숫자 번호 생성(이메일 및 핸드폰 인증용)
export const generateSecretCode = () => {
  return Math.floor(100000 + Math.random() * 900000).toString();
};

// 토큰 정보 생성
export const generateToken = (user) => {
  let accessTokenExpires, refreshTokenExpires;

  // 현재 시간 기준으로 토큰 만료 시간 설정
  // 사용자
  if (user.userAdmin === "user") {
    accessTokenExpires = new Date().setHours(new Date().getHours() + 2); // 어세스 토큰 2시간
    refreshTokenExpires = new Date().setHours(new Date().getHours() + 8); // 리프레시 토큰 8시간
    // accessTokenExpires = new Date().setSeconds(new Date().getSeconds() + 10); // 어세스 토큰 테스트 15초
    // refreshTokenExpires = new Date().setSeconds(new Date().getSeconds() + 10); // 리프레시 토큰 테스트 15초

    // 관리자
  } else {
    accessTokenExpires = new Date().setHours(new Date().getHours() + 2); // 어세스 토큰 2시간
    refreshTokenExpires = new Date().setHours(new Date().getHours() + 24); // 리프레시 토큰 24시간
    // accessTokenExpires = new Date().setSeconds(new Date().getSeconds() + 15); // 어세스 토큰 테스트 15초
    // refreshTokenExpires = new Date().setSeconds(new Date().getSeconds() + 15); // 리프레시 토큰 테스트 15초
  }

  const accessToken = jwt.sign({ ...user, expired: accessTokenExpires }, process.env.JWT_SECRET);
  const refreshToken = jwt.sign({ ...user, expired: refreshTokenExpires }, process.env.JWT_SECRET);

  return {
    accessToken,
    refreshToken,
  };
};

// 영문, 숫자 섞은 랜덤코드 생성
export const genRandomCode = (stringLength) => {
  const chars = "0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXTZ";

  let randomstring = "";
  for (let i = 0; i < stringLength; i++) {
    const rnum = Math.floor(Math.random() * chars.length);
    randomstring += chars.substring(rnum, rnum + 1);
  }
  return randomstring;
};
