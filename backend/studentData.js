const express = require("express");
const router = express.Router();
const mongooseModels = require("./mongooseModels");
const contract = require("./contract");
const { instution } = require("./mongooseModels");
router.get("/getStudentDetails", (req, res) => {
  const address = req.headers.address;
  console.log(address);

  mongooseModels.student.findOne({ address }, (e, student) => {
    return res.json({ name: student.name, uid: student.uid });
  });
});

router.post("/requestAccess", (req, res) => {
  const uid = req.headers.searcheduseruid; //uid of requestedUser
  const searchingUserUID = req.headers.searchinguseruid; //uid of requestingUser

  console.log(req.headers);
  mongooseModels.student.findOne({ uid }, (e, student) => {
    console.log(student);
    student.requestingPermission.push(searchingUserUID);
    student.save();
    return res.json({ success: "true", message: "Request Added" });
  });
});

router.post("/acceptCertificate", (req, res) => {
  const body = req.body;

  console.log(body);

  const uid = body.uid;
  const index = parseInt(body.index);
  const isAccepted = body.isAccepted;
  const address = body.sendersaddress;
  const userAddress = body.useraddress;
  mongooseModels.student.findOne({ uid }, (e, student) => {
    const certificate = student.pendingCertificates[index];

    //   // _academicTitle,
    //   // _gpa,
    //   // _ipfsHash,
    //   // _orgID,
    //   // _studentAddress

    mongooseModels.instution.findOne({ address }, async (e, instution) => {
      console.log(instution);

      const response = await contract.addAcademicRecord(
        certificate.title,
        certificate.gpa,
        certificate.ipfsHash,
        instution.uid,
        userAddress
      );

      student.pendingCertificates.splice(index, 1);
      student.save();
      console.log(response);
    });
  });
});

router.get("/getPendingRequests", async (req, res) => {
  var listToBeReturned = [];
  const uid = req.headers.uid;

  const student = await mongooseModels.student.findOne({ uid });
  const studentUids = student.requestingPermission;

  for (let i = 0; i < studentUids.length; i++) {
    console.log(studentUids[i]);

    let newStudent = await mongooseModels.student.findOne({
      uid: studentUids[i],
    });

    listToBeReturned.push({
      name: newStudent.name,
      address: newStudent.address,
      uid: newStudent.uid,
    });
  }
  console.log(listToBeReturned);

  return res.json({ pendingRequests: listToBeReturned });
});

router.post("/handleAccessRequests", async (req, res) => {
  console.log(req.body);
  const body = req.body;
  const reqid = parseInt(body.reqid);
  const uid = body.approvinguid;
  const isApproved = body.toBeApproved;
  const tobeapproveduid = body.tobeapproveduid;

  mongooseModels.student.findOne({ uid }, (e, student) => {
    student.requestingPermission.splice(reqid, 1);
    if (isApproved === "true") {
      student.accessGivenTo.push(tobeapproveduid);
      console.log(student);

      student.save();
      return res.json({ message: "Approved" });
    }
    console.log(reqid);

    console.log(student.requestingPermission[reqid]);
    student.save();
    return res.json({ message: "Rejected" });
  });
});

router.get("/getPendingRequest", async (req, res) => {
  console.log(req.headers);
  const uid = req.headers.uid;

  mongooseModels.student.findOne({ uid }, (e, student) => {
    return res.json({ pendingCertificates: student.pendingCertificates });
  });
});

router.get("/searchUser", (req, res) => {
  const uid = req.headers.searcheduseruid;
  const searchinguseruid = req.headers.searchinguseruid;
  console.log(req.headers, uid, searchinguseruid);

  mongooseModels.student.findOne({ uid }, (e, student) => {
    if (student) {
      if (student.accessGivenTo.includes(searchinguseruid)) {
        return res.json({
          name: student.name,
          address: student.address,
          success: true,
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
