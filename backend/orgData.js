const express = require("express");
const router = express.Router();
const mongooseModels = require("./mongooseModels");

router.get("/getPendingReqs", (req, res) => {
  const address = req.headers.address;
  console.log(address);

  mongooseModels.instution.findOne({ address }, (e, institute) => {
    console.log(institute.pendingRequests);

    return res.json(institute.pendingRequests);
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
