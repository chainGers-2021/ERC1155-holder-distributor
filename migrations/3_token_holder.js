const TokenHolder = artifacts.require("TokenHolder");
const Token = artifacts.require("Token");

module.exports = async function (deployer) {
  deployer.deploy(
    TokenHolder,
    (await web3.eth.getAccounts())[0],
    (await Token.deployed()).address
  );
};
