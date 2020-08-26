const express = require("express");
const router = express.Router();
const mongooseModels = require("./mongooseModels");

router.get("/getStudentDetails", (req, res) => {
  const address = req.headers.address;
  console.log(address);

  mongooseModels.student.findOne({ address }, (e, student) => {
    return res.json({ name: student.name, uid: student.uid });
  });
});

module.exports = router;
