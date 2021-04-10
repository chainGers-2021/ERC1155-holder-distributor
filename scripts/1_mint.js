const Token = artifacts.require("Token");
const TokenHolder = artifacts.require("TokenHolder");

module.exports = async (callback) => {
  [admin, user1, user2, _] = await web3.eth.getAccounts();
  h = await TokenHolder.deployed();

  await h.mintTokens("not-ownable-nft");
  console.log("not-ownable-nft minted.");
  
  await h.mintTokens("LINK");
  await h.rewardNFT("LINK", user1);
  console.log("Token give to user1.");
  
  
  await h.mintTokens("LINK");
  await h.rewardNFT("LINK", user2);
  console.log("Token give to user2.");

  token = await Token.at(await h.tokenERC1155());
  console.log(parseInt(await token.balanceOf(user1, 1)));
  console.log(parseInt(await token.balanceOf(user2, 2)));

  callback("Minted.");
};
