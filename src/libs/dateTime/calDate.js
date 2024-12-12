// 한국시간 계산
export const calKst = (date) => {
  return new Date(new Date(date).setHours(new Date(date).getHours() + 9));
};

// 현재 시간 kst 계산
export const today9 = () => new Date(new Date().setHours(new Date().getHours() + 9));

// 오늘 kst 계산F
export const todayZero = () => {
  // const today = new Date(new Date().setHours(new Date().getHours() + 9));
  const today = new Date();
  const today0 = new Date(today.getFullYear(), today.getMonth(), today.getDate(), 9);

  return today0;
};

export const weekdays_eng = ["sun", "mon", "tue", "wed", "thu", "fri", "sat"]; // 요일
