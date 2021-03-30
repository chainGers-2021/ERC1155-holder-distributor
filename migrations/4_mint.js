const Token = artifacts.require("Token");
const TokenHolder = artifacts.require("TokenHolder");

module.exports = async (deployer)=> {
  const token = await Token.deployed();
  const totalTokens = 100;
  await token.mint((await TokenHolder.deployed()).address, totalTokens);
};
