const express = require("express");
const router = express.Router();
const jwt = require("./jwtConfig");
const contract = require("./contract");
const mongooseModels = require("./mongooseModels");

router.post("/validateAcademicRecord", async (req, res) => {
  const payload = jwt.jwtVerify(req.body.token);
  const address = payload.address;

  const userAddress = req.body.address;
  const recordCount = parseInt(req.body.requestRecordCount) - 1;
  const isApproved = req.body.isApproved;
  const index = parseInt(req.body.index);
  console.log(index);
  mongooseModels.instution.findOne(
    { address: payload.address },
    async (e, institute) => {
      if (isApproved.toLowerCase() === "true") {
        console.log(true);
        await contract.validateAcademicRecord(
          userAddress,
          recordCount,
          payload.address
        );
      } else {
        console.log(false);
      }
      institute.pendingRequests.splice(index, 1);
      institute.save();

      console.log(institute.pendingRequests);
    }
  );
});

module.exports = router;
