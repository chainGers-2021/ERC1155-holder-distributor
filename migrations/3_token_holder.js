const TokenHolder = artifacts.require("TokenHolder");

module.exports = async function (deployer) {
  deployer.deploy(TokenHolder);
};
