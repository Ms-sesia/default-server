export const reqParsing = (req, res, next) => {
  // 로그인 접속시 파싱
  // 관리자 요청은 토큰이 헤더. 사용자는 쿠키
  if (!req.headers.authorization && req.cookies.ezDeskURT) {
    try {
      const accessToken = req.cookies.ezDeskURT;
      req.headers.authorization = `bearer ${accessToken}`;
    } catch (e) {
      console.error("사용자 토큰이 존재하지 않습니다. reqParsing error:", e);
      return res.redirect(process.env.HOME_REDIRECT);
    }
  }

  next();
};
