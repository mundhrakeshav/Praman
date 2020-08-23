const express = require("express");
const router = express.Router();
const actions = require("./helperFunction");
const models = require("./mongooseModels");
const jwt = require("./jwtConfig");
const contract = require("./contract");
const faker = require("faker");
const axios = require("axios");
const mongooseModels = require("./mongooseModels");

router.post("/loginStudent", (req, res) => {
  const uid = req.body.uid;
  const password = req.body.password;
  console.log(uid, password);
  models.student.findOne({ uid }, (e, student) => {
    if (e) {
      console.log(e);
      return res
        .status(400)
        .json({ success: false, message: "Some Error occured" });
    } else if (student) {
      console.log(student);

      if (student.password === password) {
        const token = jwt.jwtSign({
          uid: student.uid,
          address: student.address,
        });
        return res.json({
          success: true,
          message: "LoggedIn Successfully",
          token,
          uid: student.uid,
          address: student.address,
          name: student.name,
        });
      } else {
        return res.json({ success: false, message: "Incorrect Password" });
      }
    } else {
      return res
        .status(400)
        .json({ success: false, message: "Not registered" });
    }
  });
});

router.post("/registerStudent", (req, res) => {
  const address = actions.generateRandomAddress();
  const uid = req.body.uid;
  const password = req.body.password;
  const name = req.body.name;
  models.student.findOne({ uid }, async (e, student) => {
    if (e) {
      console.log(e);
      return res
        .status(400)
        .json({ success: false, message: "Some Error occured" });
    } else if (student) {
      console.log(student);
      return res.json({
        success: false,
        message: "Already Registered",
      });
    } else {
      try {
        const response = await contract.addNewStudent(address);

        console.log(response["data"][0]["txHash"]);
        const newStudent = new models.student({ uid, address, password, name });
        newStudent.save().then((err, newStudent) => {
          if (err) {
            console.log(err);
          } else {
            console.log(newStudent);
          }
        });
        return res.json({
          success: response["success"],
          txHash: response["data"][0]["txHash"],
          message: "Registered Successfully",
          address: newStudent.address,
          uid: newStudent.uid,
          name: newStudent.name,
        });
      } catch (error) {
        console.log(error);
      }
    }
  });
});

router.post("/loginOrganization", (req, res) => {
  const uid = req.body.uid;
  const password = req.body.password;

  models.instution.findOne({ uid }, (e, institute) => {
    if (e) {
      console.log(e);
      return res
        .status(400)
        .json({ success: false, message: "Some Error occured" });
    } else if (institute) {
      console.log(institute);

      if (institute.password === password) {
        const token = jwt.jwtSign({
          uid: institute.uid,
          address: institute.address,
        });
        return res.json({
          success: true,
          message: "LoggedIn Successfully",
          token,
          uid: institute.uid,
          address: institute.address,
          name: institute.name,
        });
      } else {
        return res.json({ success: false, message: "Incorrect Password" });
      }
    } else {
      return res
        .status(400)
        .json({ success: false, message: "Not registered" });
    }
  });
  // res.send(JSON.stringify({ keshav: "KEhsav" }));
});

router.post("/registerOrganization", (req, res) => {
  console.log("REGISTERINST");
  console.log(req.body);
  const address = actions.generateRandomAddress();
  const uid = req.body.uid;
  const password = req.body.password;
  const type = req.body.type;
  const name = req.body.name;

  mongooseModels.instution.findOne({ uid }, async (e, institute) => {
    if (e) {
      console.log(e);
      return res.json({ success: false, message: "Some Error occured" });
    } else if (institute) {
      console.log(institute);
      return res.json({
        success: false,
        message: "Already Registered",
      });
    } else {
      try {
        const response = await contract.addNewInstitute(name, type, address);
        const txHash = response["data"][0]["txHash"];
        console.log(txHash);
        const newInstitute = new models.instution({
          uid,
          type,
          address,
          password,
          name,
        });
        newInstitute.save().then((err, newInstitution) => {
          if (err) {
            console.log(err);
          } else {
            console.log(newInstitution);
          }
        });

        return res.json({
          success: response["success"],
          txHash: txHash,
          message: "Registered Successfully",
          address: newInstitute.address,
          uid: newInstitute.uid,
          name: newInstitute.name,
        });
      } catch (error) {
        console.log(error);
      }
    }
  });
});

module.exports = router;
