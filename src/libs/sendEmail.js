import nodemailer from "nodemailer";
import { today9 } from "./dateTime/calDate";

export default async ({ to, subject, html }) => {
  const transporter = nodemailer.createTransport({
    service: "works mobile",
    host: "smtp.worksmobile.com",
    port: 465,
    auth: {
      user: process.env.MAIL_ID,
      pass: process.env.MAIL_PW,
    },
    secure: true,
  });

  const option = {
    from: `이지데스크 ${process.env.MAIL_ID}`,
    to: to,
    // bcc, // 숨은참조
    subject: subject,
    html: html,
  };

  const now = today9();

  try {
    const info = await transporter.sendMail(option);
    return info;
  } catch (e) {
    console.error(`Failed to send email: ${e.message}. time: ${now.toISOString()}`);
    throw e; // 에러를 호출한 곳에서 처리할 수 있도록 다시 던짐
  }
};
