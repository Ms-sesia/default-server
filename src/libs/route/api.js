import graphqlUploadExpress from "../graphql_fileUpload/graphqlUploadExpress";
import { ApolloServerPluginDrainHttpServer } from "@apollo/server/plugin/drainHttpServer";
import { expressMiddleware } from "@as-integrations/express5";
import { json } from "body-parser";
import { isAuthenticated } from "../auth/isAuthenticated";
import { corsOptions } from "../corsOptions";
import fileRouter from "./fileRouter";
import { ApolloServer } from "@apollo/server";
import express from "express";
import helmet from "helmet";
import cors from "cors";
import schema from "../schema";
import { PrismaClient } from "@prisma/client";

const prisma = new PrismaClient();

const createApiRouter = async (httpServer) => {
  const router = express.Router();

  const server = new ApolloServer({
    schema,
    plugins: [ApolloServerPluginDrainHttpServer({ httpServer })], // httpServer 플러그인 사용
    introspection: process.env.PROJECT_ENV !== "production",
    formatError:
      process.env.PROJECT_ENV === "production"
        ? (err) => {
            if (err.extensions) {
              delete err.extensions;
              delete err.path;
              delete err.locations;
            }
            return err;
          }
        : undefined,
  });

  await server.start();

  // REST API 라우터
  router.use("/files", fileRouter);

  // GraphQL 라우터
  router.use(
    "/graphql",
    cors(corsOptions),
    helmet({ contentSecurityPolicy: process.env.PROJECT_ENV === "production" }),
    // json({ limit: "10mb" }),
    express.json(),
    graphqlUploadExpress(), // 파일 업로드
    expressMiddleware(server, { context: async ({ req }) => ({ request: req, isAuthenticated, prisma }) })
  );

  return router;
};

export default createApiRouter;
