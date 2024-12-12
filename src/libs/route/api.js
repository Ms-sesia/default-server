import express from "express";
import graphqlUploadExpress from "../graphql_fileUpload/graphqlUploadExpress";
import { ApolloServerPluginDrainHttpServer } from "@apollo/server/plugin/drainHttpServer";
import { expressMiddleware } from "@apollo/server/express4";
import { json } from "body-parser";
import helmet from "helmet";
import cors from "cors";
import { isAuthenticated } from "../auth/isAuthenticated";
import { corsOptions } from "../corsOptions";
import fileRouter from "./fileRouter";
import { ApolloServer } from "@apollo/server";
import schema from "../schema";

const createApiRouter = async (httpServer) => {
  const router = express.Router();

  const server = new ApolloServer({
    schema,
    plugins: [ApolloServerPluginDrainHttpServer({ httpServer })], // httpServer 플러그인 사용
    introspection: process.env.PORJECT_ENV !== "production",
    formatError:
      process.env.PORJECT_ENV === "production"
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
    helmet({ contentSecurityPolicy: process.env.PORJECT_ENV === "production" }),
    json({ limit: "10mb" }),
    graphqlUploadExpress(), // 파일 업로드
    expressMiddleware(server, { context: async ({ req }) => ({ request: req, isAuthenticated }) })
  );

  return router;
};

export default createApiRouter;
