const setCookieOptions = (maxAge) => {
  const cookieOptions = {
    httpOnly: true,
    secure: true,
    sameSite: "none",
    maxAge,
  };

  cookieOptions.domain =
    process.env.PORJECT_ENV === "production" ? process.env.PRO_COOKIE_DOMAIN : process.env.DEV_COOKIE_DOMAIN;

  return cookieOptions;
};

export default setCookieOptions;
