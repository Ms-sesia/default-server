import { PrismaClient } from "@prisma/client";

const prisma = new PrismaClient();

// 로그 기록
export default async (logInfo) => {
  const {
    //
    type,
    tabName,
    text,
    name,
    rank,
    email,
  } = logInfo;
  try {
    await prisma.adminLog.create({
      data: {
        type,
        tabName,
        text,
        name,
        rank,
        email,
      },
    });

    return true;
  } catch (e) {
    console.log(`관리자 로그 기록에 실패하였습니다. tabName: ${tabName}, event: ${text}. error:`, e);
    throw new Error("관리자 로그 기록 실패.");
  }
};
