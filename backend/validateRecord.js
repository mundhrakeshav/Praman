const express = require("express");
const router = express.Router();
const jwt = require("./jwtConfig");
const contract = require("./contract");
const mongooseModels = require("./mongooseModels");

router.post("/addAcademicRecord", async (req, res) => {
  try {
    const payload = jwt.jwtVerify(req.body.token);
    if (payload != null) {
      const uid = req.body.uid;
      mongooseModels.student.findOne({ uid: uid }, async (e, student) => {
        if (e) {
        } else {
        }
      });
    }
  } catch (e) {
    return res.status(400).json({ success: "false", error: e });
  }
});

module.exports = router;
