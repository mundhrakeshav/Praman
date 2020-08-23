const axios = require("axios");
const config = {
  baseUrl: "https://beta-api.ethvigil.com/v0.1/contract/",
  contractAddress: "0xcb61453a786c89f2cc737459ada92a09af650f54",
  apiKey: "01af1523-877c-42fd-85dc-e5ad225425e6",
};

const contractInstance = axios.create({
  baseURL: config.baseUrl + config.contractAddress,
  timeout: 5000,
  headers: {
    "X-API-KEY": config.apiKey,
  },
});

const addNewStudent = async () => {
  try {
    const response = await contractInstance.post("/addStudent", {
      _name: "name",
      _userAddress: "0x3f305335f2E2F3BFF5dA4D1BD635229327DaB5Ab",
      // curl -X POST "https://beta-api.ethvigil.com/v1.0/contract/0xcb61453a786c89f2cc737459ada92a09af650f54/addStudent" -H "accept: application/json" -H "X-API-KEY: 01af1523-877c-42fd-85dc-e5ad225425e6" -H "Content-Type: application/x-www-form-urlencoded" -d "_name=&_userAddress="
    });
    console.log(response);
  } catch (e) {
    console.log(e);
  }
};

addNewStudent();
// const response = await contract.addNewStudent(name, address);
// print(response);
// curl -X POST "https://beta-api.ethvigil.com/v1.0/contract/0xcb61453a786c89f2cc737459ada92a09af650f54/addStudent" -H "accept: application/json" -H "X-API-KEY: 01af1523-877c-42fd-85dc-e5ad225425e6" -H "Content-Type: application/x-www-form-urlencoded" -d "_name=&_userAddress="

//   const response = axios
//     .post(
//       config.baseUrl + config.contractAddress + "/addStudent",

//       {
//         _name: "name",
//         _userAddress: "0x3f305335f2E2F3BFF5dA4D1BD635229327DaB5Ab",
//       },
//       {
//         headers: {
//           "X-API-KEY": "01af1523-877c-42fd-85dc-e5ad225425e6",
//         },
//       }
//     )
//     .then((res) => {
//       console.log(res["data"]);
//     })
//     .catch((err) => console.error(err));
//   console.log(response);
