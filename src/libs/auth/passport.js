import passport from "passport";
import { Strategy, ExtractJwt } from "passport-jwt";

const jwtOptions = {
  jwtFromRequest: ExtractJwt.fromAuthHeaderAsBearerToken(),

  secretOrKey: process.env.JWT_SECRET,
};

const verifyUser = async (payload, done) => {
  try {
    let user = payload;
    if (user !== null) return done(null, user);
    else done(null, false);
  } catch (e) {
    console.log("passport e =>", e);
    return done(e, false);
  }
};

export const authenticateJwt = (req, res, next) => {
  passport.authenticate("jwt", { sessions: false }, (error, user, info) => {
    if (user) req.user = user;

    if (error) {
      console.error(error);
      return res.status(401).json({ error: "Unauthorized" });
    }

    // if (!user) {
    //   // JWT 만료
    //   if (info.name === "TokenExpiredError") {
    //     return res.status(401).json({ error: "Expired", errorCode: "err_02" });
    //   } else {
    //     return res.status(401).json({ error: info.message, errorCode: "err_01" });
    //   }
    // }

    next();
  })(req, res, next);
};

passport.use(new Strategy(jwtOptions, verifyUser));
passport.initialize();
