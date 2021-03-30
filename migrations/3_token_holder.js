const TokenHolder = artifacts.require("TokenHolder");

module.exports = async function (deployer) {
  const amountToEach = 1;
  const n = 5;
  deployer.deploy(TokenHolder, amountToEach, n);
};
