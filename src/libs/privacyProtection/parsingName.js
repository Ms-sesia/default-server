import crypto from "crypto";

// 한글이름, 영문이름 분리
export const splitNames = (name) => {
  // 한글 이름과 영문 이름을 추출하기 위한 정규 표현식
  const krNamePattern = /[\uAC00-\uD7A3]+/;
  const engNamePattern = /^[a-zA-Z\s]+/;

  let engName = "";
  let krName = "";

  if (name.includes("（") && name.includes("）")) {
    // 이름이 괄호를 포함하는 경우
    const parts = name.split("（");
    engName = parts[0].trim();
    krName = parts[1].split("-")[0].replace(/[）]/g, "").trim();
  } else if (krNamePattern.test(name)) {
    // 이름이 한글로만 구성된 경우
    krName = name.trim();
  } else if (engNamePattern.test(name)) {
    // 이름이 영문으로만 구성된 경우
    engName = name.trim();
  }

  return { engName, krName };
};

// 괄호 분리 및 공백 제거
export const splitJoinName = (join) => {
  const parsBracket = join.split("(")[0].trim();

  return parsBracket;
};

// 검색을 위한 데이터 해싱
export const hashTerm = async (term) => {
  return crypto.createHash("sha256").update(term).digest("hex");
};
