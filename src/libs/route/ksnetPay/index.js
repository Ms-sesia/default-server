import bodyParser from "body-parser";
import express from "express";
import nPayReturn from "./nPayReturn";
import iconv from "iconv-lite";

const router = express.Router();

router.use("/nPayReturn", bodyParser.urlencoded({ extended: false }), nPayReturn);
// router.use("/kakaoPayReturn", bodyParser.urlencoded({ extended: false }), nPayReturn());
// router.use("/paycoReturn", bodyParser.urlencoded({ extended: false }), nPayReturn());

export default router;
