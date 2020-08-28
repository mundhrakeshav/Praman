const express = require("express");
const router = express.Router();
const helperFunctions = require("./helperFunction");
const mongooseModels = require("./mongooseModels");

router.get("/getPendingReqs", (req, res) => {
  const address = req.headers.address;
  console.log(address);

  mongooseModels.instution.findOne({ address }, (e, institute) => {
    console.log(institute.pendingRequests);

    return res.json(institute.pendingRequests);
  });
});

router.post("/sendCertificate", async (req, res) => {
  // console.log(req.body);
  const body = req.body;
  const sendersaddress = body.sendersaddress;
  const title = body.title;
  const details = body.details;
  const uid = body.recieveruid;
  const image = body.image;
  const gpa = body.gpa;

  // console.log(sendersaddress);

  const resp = await helperFunctions.addDataToIpfs({ details, image });
  const ipfsHash = resp[0]["hash"];
  console.log(ipfsHash);

  mongooseModels.student.findOne({ uid }, (e, student) => {
    console.log(student);
    student.pendingCertificates.push({
      title: title,
      type: "Academic",
      gpa: gpa,
      ipfsHash: ipfsHash,
      sendersAddress: sendersaddress,
    });
    res.send(student);
    student.save();
  });
});

router.get("/getOrganizationDetails", (req, res) => {
  const uid = req.headers.uid;
  console.log(uid);

  mongooseModels.instution.findOne({ uid }, (e, institute) => {
    return res.json({ name: institute.name, address: institute.address });
  });
});

module.exports = router;
