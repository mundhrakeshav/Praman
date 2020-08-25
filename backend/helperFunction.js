const ethers = require("ethers");
const ipfs = require("./ipfs");

module.exports = {
  generateRandomAddress: () => {
    const wallet = ethers.Wallet.createRandom();
    return wallet.address;
  },

  addDataToIpfs: async ({ details, image }) => {
    return await ipfs.files.add(
      Buffer.from(JSON.stringify({ details, image }))
    );
  },
};
