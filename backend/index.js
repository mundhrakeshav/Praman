const express = require("express");
const bodyParser = require("body-parser");
const mongoose = require("mongoose");
const cors = require("cors");
const auth = require("./auth");
const morgan = require("morgan");

mongoose.connect(
  "mongodb://127.0.0.1:27017/PathShala",
  {
    useNewUrlParser: true,
    useUnifiedTopology: true,
  },
  () => {
    console.log("Connected to mongoDB ");
  }
);
//Mongo DB for applying for validation
//all Jobs and Hacks on MongoDB
//you can control who can view you profile
//whatsapp texts handling
var app = express();

app.use(morgan("tiny"));
app.use(cors());
app.use(bodyParser.urlencoded({ extended: true }));
app.use(bodyParser.json());
app.use(auth);

const port = process.env.PORT || 5000;

app.listen(port, () => console.log(`Server running on port ${port} 🔥`));
