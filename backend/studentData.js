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

router.get("/searchUser", (req, res) => {
  const uid = req.headers.searcheduseruid;
  const searchingUserUID = req.headers.searchingUserUID;
  console.log(typeof uid);

  mongooseModels.student.findOne({ uid }, (e, student) => {
    console.log(student);

    if (student) {
      if (student.accessGivenTo.includes(searchingUserUID)) {
        return res.json({
          name: student.name,
          address: student.address,
          success: false,
        });
      } else {
        return res.json({
          success: false,
          errorCode: 0,
          message: "Access Denied",
        });
      }
    } else
      return res.json({
        errorCode: 1,
        success: false,
        message: "User not found",
      });
  });
});

module.exports = router;
