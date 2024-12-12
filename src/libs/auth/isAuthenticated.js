import { PrismaClient } from "@prisma/client";
import jwt from "jsonwebtoken";

const prisma = new PrismaClient();

const userCookieName = process.env.USER_COOKIE_NAME;
const adminCookieName = process.env.ADMIN_COOKIE_NAME;

export const isAuthenticated = async (request) => {
  let checkResult = "";
  const user = request.user;

  const userRefToken = request.cookies.fbz_RT; // 사용자 ref토큰
  const adminRefToken = request.cookies.fbz_ART; // 관리자 ref토큰

  // 사용자 정보나 토큰이 없는 경우 로그인 필요
  if (!user || (!userRefToken && !adminRefToken)) return (checkResult = "err_00");

  const now = new Date();

  // 토큰 탈취 당한 후 만료기간이 지났음에도 요청이 들어오게 될 경우
  if (user?.expired < now) return (checkResult = "err_02"); // 유효하지 않은 토큰입니다.

  switch (user?.userAdmin) {
    case "user":
      const loginUser = await prisma.user.findUnique({ where: { user_id: user.user_id } });
      if (!userRefToken) {
        checkResult = "err_00"; // 사용자 리프레시 토큰이 없는 경우
        break;
      }
      // 로그인한 사용자 ref토큰과 쿠키에서 받은 ref토큰이 다를 때 = 중복로그인
      if (loginUser.user_refreshToken !== userRefToken) {
        request.res.clearCookie(userCookieName); // 관리자 리프레시 토큰(쿠키) 제거
        checkResult = "err_04"; // 중복 로그인
        break;
      }
      // 사용자 리프레시 토큰 만료일 체크
      const checkUserExp = jwt.verify(userRefToken, process.env.JWT_SECRET);
      // 리프레시 토큰 만료시 삭제
      if (checkUserExp.expired < now) {
        request.res.clearCookie(userCookieName); // 관리자 리프레시 토큰(쿠키) 제거
        await prisma.user.update({
          where: { user_id: user.user_id },
          data: { user_refreshToken: "" },
        });
        return (checkResult = "err_03");
      }
      break;
    case "admin":
      // 사용자 리프레시 토큰 만료일 체크
      const checkAdminExp = jwt.verify(adminRefToken, process.env.JWT_SECRET);

      if (checkAdminExp.expired < now) {
        // 리프레시 토큰 만료시 삭제
        await prisma.adminRefreshToken.updateMany({
          where: { admin_id: user.admin_id, art_refreshToken: adminRefToken },
          data: { art_refreshToken: "" },
        });

        request.res.clearCookie(adminCookieName); // 리프레시 토큰이 없는데 쿠키가 있는 경우 삭제
        return (checkResult = "err_03");
      }

      const checkRef = await prisma.adminRefreshToken.findMany({
        where: { art_refreshToken: { equals: adminRefToken } },
      });

      if (!checkRef.length) {
        return (checkResult = "err_03");
      }
      break;
  }

  return checkResult;
};
