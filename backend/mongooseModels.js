const mongoose = require("mongoose");

const requestSchema = mongoose.Schema({
  userAddress: String,
  title: String,
  type: String,
  gpa: String,
  ipfsHash: String,
  requestRecordCount: String,
});

const pendingCertificatesSchema = mongoose.Schema({
  title: String,
  type: String,
  gpa: String,
  ipfsHash: String,
  sendersAddress: String,
});

module.exports = {
  student: mongoose.model(
    "Student",
    mongoose.Schema({
      uid: String,
      name: String,
      address: String,
      password: String,
      pendingCertificates: [
        {
          type: pendingCertificatesSchema,
        },
      ],
      accessGivenTo: [String],
      requestingPermission: [String],
    })
  ),

  instution: mongoose.model(
    "Institute",
    mongoose.Schema({
      uid: String,
      name: String,
      address: String,
      password: String,
      type: String,
      pendingRequests: [
        {
          type: requestSchema,
        },
      ],
    })
  ),
};
