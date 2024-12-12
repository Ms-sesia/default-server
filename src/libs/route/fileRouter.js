import express from "express";
import path from "path";

const router = express.Router();

// 파일 경로 추가
router.use("/excel/magazine", express.static(path.join(__dirname, "../../../", "files", "excel/magazine")));
router.use("/excel/subsEnd", express.static(path.join(__dirname, "../../../", "files", "excel/subsEnd")));
router.use("/excel/crm", express.static(path.join(__dirname, "../../../", "files", "excel/crm")));

export default router;
