import "./config";
import express from "express";
import http from "http";
import cors from "cors";
import cookieParser from "cookie-parser";
import dotenv from "dotenv";
dotenv.config();
import { corsOptions } from "./libs/corsOptions";
import createApiRouter from "./libs/route/api";

const PORT = process.env.SERVER_PORT;

(async () => {
  const app = express();

  const httpServer = http.createServer(app);

  app.use(cookieParser());
  app.use(cors(corsOptions));

  // API 라우터 (httpServer를 전달)
  const apiRouter = await createApiRouter(httpServer);
  // 모든 API 라우팅 처리 (REST + GraphQL)
  app.use("/api", apiRouter);

  // 이외 경로로 접속할 경우 404페이지 리다이렉트
  app.use("*", (req, res, next) => {
    return res.redirect(process.env.PORJECT_ENV === "production" ? process.env.PROJECT_URL : process.env.DEV_URL); // get으로 요청시 에러
  });

  app.use((err, req, res, next) => {
    console.error("/api/graphql access err stack:", err.stack); // 서버 로그에 에러 스택 트레이스를 기록
    res.status(500).send("잘못된 접근입니다. 관리자에게 문의 부탁드립니다."); // 사용자에게 일반적인 에러 메시지만 보냄
  });

  await new Promise((resolve) => httpServer.listen({ port: PORT }, resolve));
  console.log(`Server ready at http://localhost:${PORT}`);
})();
