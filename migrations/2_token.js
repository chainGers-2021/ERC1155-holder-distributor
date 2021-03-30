const Token = artifacts.require("Token");

module.exports = function (deployer) {
  const tokenURI = `https://somewebsite.com/{id}.json`;
  deployer.deploy(Token, tokenURI);
};
