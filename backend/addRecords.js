const express = require("express");
const router = express.Router();
const jwt = require("./jwtConfig");
const contract = require("./contract");
const mongooseModels = require("./mongooseModels");
const helperFunctions = require("./helperFunction");

router.post("/addAcademicRecord", async (req, res) => {
  try {
    const payload = jwt.jwtVerify(req.body.token);

    if (payload != null) {
      const body = req.body;

      console.log(body, payload);
      const title = body.title;
      const details = body.details;
      const orgID = body.orgainzationID;
      const gpa = body.gpa;
      const image = body.image;
      const address = payload.address;
      const resp = await helperFunctions.addDataToIpfs({ details, image });
      const ipfsHash = resp[0]["hash"];
      console.log(ipfsHash);

      const studentData = await contract.getStudent(address);

      const academicRecordLength =
        studentData["data"][0]["academicRecord"].length;

      mongooseModels.instution.findOne({ uid: orgID }, async (e, doc) => {
        if (e) {
          console.log(e);
        } else {
          doc.pendingRequests.push({
            userAddress: address,
            title: title,
            type: "Academic",
            gpa: gpa,
            ipfsHash: ipfsHash,
            requestRecordCount: academicRecordLength + 1,
          });

          const response = await contract.addAcademicRecord(
            title,
            gpa,
            ipfsHash,
            orgID,
            payload["address"]
          );

          doc.save();
          res.json({ success: response["success"], data: response["data"] });
        }
      });
    }
  } catch (e) {
    return res.status(400).json({ success: "false", error: e });
  }
});

module.exports = router;
