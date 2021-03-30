const Token = artifacts.require("Token");

module.exports = function (deployer) {
  const tokenURI = `https://raw.githubusercontent.com/akcgjc007/erc1155-Mushroom/main/meta/{id}.json`;
  deployer.deploy(Token, tokenURI);
};
