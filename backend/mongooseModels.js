const mongoose = require("mongoose"),
  db = require("../backend/dbConnect/connection");

const requestSchema = mongoose.Schema({
  userAddress: String,
  title: String,
  type: String,
  gpa: String,
  ipfsHash: String,
  requestRecordCount: String,
});

module.exports = {
  student: db.model(
    "Student",
    mongoose.Schema({
      uid: String,
      name: String,
      address: String,
      password: String,
      accessGivenTo: [String],
      requestingPermission: [String],
    })
  ),

  instution: db.model(
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
