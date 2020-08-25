const jwt = require("jsonwebtoken");
const e = require("express");

const secretKey = "SomeDamnRandomKey";

module.exports = {
  jwtSign: (payload) => {
    var token = jwt.sign(payload, secretKey, {
      algorithm: "HS256",
      expiresIn: "15d",
    });

    return token;
  },
  jwtVerify: (token) => {
    const x = jwt.verify(token, secretKey, { algorithm: "HS256" });

    return x;
  },
};
