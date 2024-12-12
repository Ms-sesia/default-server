// import path from "path";
import XLSX from "xlsx";

const getExcelData = (excelPath, fileName) => {
  // const cwd = path.join(__dirname, "../../../", "userInfoDataExcel");
  const workbook = XLSX.readFile(`${excelPath}/${fileName}`);

  return XLSX.utils.sheet_to_json(workbook.Sheets[workbook.SheetNames[0]]);
};

export default getExcelData;
