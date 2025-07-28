export const maskName = (name) => {
  if (name.length < 3) return name.replace(/./g, "*"); // 이름이 2자 이하인 경우 모두 마스킹
  return name.slice(0, 1) + "*".repeat(name.length - 2) + name.slice(-1); // 이름 첫 글자와 마지막 글자 제외 마스킹
};

// export const maskCellphone = (cellphone) => cellphone.replace(/(\d{3})-\d{4}-(\d{4})/, "$1-****-$2");
export const maskCellphone = (cellphone) => cellphone.replace(/(\d{3})\d{4}(\d{4})/, "$1****$2");
export const createSocialNumber = (birthday, gender) => {
  const [year, month, day] = birthday.split("-").map((v) => v.slice(-2)); // 뒤의 2자리만 추출
  const genderCode = gender ? "2" : "1"; // 여자면 2, 남자면 1
  return `${year}${month}${day}-${genderCode}`;
};

export const maskSocialNumber = (socialNumber) => "******-" + socialNumber.slice(-1);
export const maskOther = (value) => "*".repeat(value.length);

export const maskEmail = (email) => {
  const [localPart, domainPart] = email.split("@");

  // localPart의 마스킹 (첫 글자와 마지막 글자를 제외하고 모두 *로 대체)
  const maskedLocalPart =
    localPart.length > 2
      ? localPart[0] + "*".repeat(localPart.length - 2) + localPart[localPart.length - 1]
      : localPart;

  // domainPart의 마스킹 (첫 글자와 마지막 글자를 제외하고 모두 *로 대체)
  const maskedDomainPart =
    domainPart.length > 2
      ? domainPart[0] + "*".repeat(domainPart.length - 2) + domainPart[domainPart.length - 1]
      : domainPart;

  return `${maskedLocalPart}@${maskedDomainPart}`;
};

export const maskAccountId = (accountId) => {
  if (accountId.length < 5) return accountId; // 계정명이 5자 미만인 경우 모두 마스킹
  return accountId.slice(0, 2) + "*".repeat(accountId.length - 4) + accountId.slice(-2); // 첫 글자와 마지막 글자 제외 마스킹
};

export const maskCardNum = (cardNum) => {
  const start = cardNum.slice(0, 6);
  const maskStarts = "XXXXXX";
  const end = cardNum.slice(12);

  // 마스킹된 문자열을 결합
  return start + maskStarts + end;
};
