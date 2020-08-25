const axios = require("axios").default;
const config = require("./config");

const contractInstance = axios.create({
  baseURL: config.baseUrl + config.contractAddress,
  timeout: 5000,
  headers: { "X-API-KEY": config.apiKey },
});

module.exports = {
  addNewStudent: async (_userAddress) => {
    const response = await contractInstance.post("/addStudent", {
      _userAddress,
    });
    return response["data"];
  },
  getStudent: async (address) => {
    const response = await contractInstance.get("/getStudent/" + address);
    return response["data"];
  },

  addNewInstitute: async (_name, _type, orgAddress, orgUID) => {
    console.log("In addNewInstitue");

    const response = await contractInstance.post("/addOrganization", {
      _name,
      _type,
      orgAddress,
      orgUID,
    });
    return response["data"];
  },

  addAcademicRecord: async (
    _academicTitle,
    _gpa,
    _ipfsHash,
    _orgID,
    _studentAddress
  ) => {
    const response = await contractInstance.post("/addAcademicRecord", {
      _academicTitle,
      _gpa,
      _ipfsHash,
      _orgID,
      _studentAddress,
    });

    console.log(response["data"]);
    return response["data"];
  },
};
