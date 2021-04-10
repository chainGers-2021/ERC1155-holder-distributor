const TokenHolder = artifacts.require("TokenHolder");

module.exports = async (callback)=> {
  const h = await TokenHolder.deployed();
  await h.mintTokens("LINK");

  callback("Minted.");
};
