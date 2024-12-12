// ms 입력으로 시분초 나누기
export const msTimeToHMS = (msTime) => {
  const hour = Math.floor(msTime / (1000 * 60 * 60)); // 시간으로 나누기
  const min = Math.floor((msTime % (1000 * 60 * 60)) / (1000 * 60)); // 분으로 나누기
  const sec = Math.floor((msTime % (1000 * 60)) / 1000); // 분으로 나누기

  return { hour, min, sec };
};
