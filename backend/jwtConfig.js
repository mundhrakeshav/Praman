const jwt = require("jsonwebtoken");

const secretKey = "SomeDamnRandomKey";

module.exports = {
  jwtSign: (payload) => {
    var token = jwt.sign(payload, secretKey, {
      algorithm: "HS256",
      expiresIn: "15d",
    });

    return token;
  },
  jwtVerify: () => {},
};
