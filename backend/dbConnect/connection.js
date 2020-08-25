const mongoose = require("mongoose"),
  config = require("./config");

const db = mongoose.createConnection(config.master, config.options); // Create the database connection

// STARTS :: CONNECTION EVENTS

// When successfully connected
db.on("connected", function () {
  console.log("Mongoose connection open to master DB");
});

// If the connection throws an error
db.on("error", function (err) {
  console.log("Mongoose connection error for master DB: " + err);
});

// When the connection is disconnected
db.on("disconnected", function () {
  console.log("Mongoose connection disconnected for master DB");
});

//When connection is reconnected
db.on("reconnected", function () {
  console.log("Mongoose connection reconnected for master DB");
});
// If the Node process ends, close the Mongoose connection
process.on("SIGINT", function () {
  db.close(function () {
    console.log(
      "Mongoose connection disconnected for master DB through app termination"
    );
    process.exit(0);
  });
});

// ENDS :: CONNECTION EVENTS

module.exports = db;
