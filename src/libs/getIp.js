export const getIp = (req) => {
  if (req.headers["x-forwarded-for"]) return req.headers["x-forwarded-for"].split(",")[0].trim();
  else return "localhost";
};
