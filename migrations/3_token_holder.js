const TokenHolder = artifacts.require("TokenHolder");

module.exports = async function (deployer) {
  deployer.deploy(TokenHolder, (await web3.eth.getAccounts())[0]);

};
