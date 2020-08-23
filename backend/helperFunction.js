const ethers = require("ethers");

module.exports = {
  generateRandomAddress: () => {
    const wallet = ethers.Wallet.createRandom();
    return wallet.address;
  },
};
