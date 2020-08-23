const mongoose = require("mongoose");

module.exports = {
  student: mongoose.model(
    "Student",
    mongoose.Schema({
      uid: String,
      name: String,
      address: String,
      password: String,
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
    })
  ),
};
