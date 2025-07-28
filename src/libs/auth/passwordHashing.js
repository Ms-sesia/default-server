import crypto from "crypto";

// 비밀번호 생성(단방향 - sha256)
export const makeHashPassword = async (password) => {
  try {
    const salt = crypto.randomBytes(16).toString("base64");
    const hashed = crypto.pbkdf2Sync(password, salt, 100, 32, "sha256");

    return {
      salt,
      password: hashed.toString("base64"),
      error: "",
    };
  } catch (e) {
    console.log("makeHashPassword error:", e);
    return {
      salt: "",
      password: "",
      error: `비밀번호 암호화 실패. error: ${e}`,
    };
  }
};

// 비밀번호 검사
export const checkHashPassword = async (salt, password) => {
  try {
    const hashed = crypto.pbkdf2Sync(password, salt, 100, 32, "sha256");

    return {
      salt,
      password: hashed.toString("base64"),
      error: "",
    };
  } catch (e) {
    console.log("비밀번호 검사 실패. checkHashPassword error:", e);
    return {
      salt: "",
      password: "",
      error: `비밀번호 암호화 검사 실패. error: ${e}`,
    };
  }
};
