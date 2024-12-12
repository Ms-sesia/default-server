import { PrismaClient } from "@prisma/client";

const prisma = new PrismaClient();

export default async (loginInfo) => {
  const { id, ip, os, location, browser, successable, status } = loginInfo;

  try {
    await prisma.adminLoginHistory.create({
      data: {
        ip: ip,
        os: os,
        browser: browser,
        status: status,
        admin: { connect: { admin_id: id } },
      },
    });
  } catch (e) {
    console.log("관리자 로그인 기록 실패. createLoginHistroy error:", e);
    throw new Error(15); // 관리자 로그인 기록 실패
  }
};
