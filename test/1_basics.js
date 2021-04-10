const TokenHolder = artifacts.require("TokenHolder");
const Token = artifacts.require("Token");
const assert = require("assert");
const truffleAssert = require("truffle-assertions");

contract("TokenHolder", async (addresses) => {
  const admin = addresses[0];
  let h;

  before(async () => {
    h = await TokenHolder.new(admin);
  });

  it("mints tokens.", async () => {
    await h.mintTokens("LINK");
    assert.strictEqual(parseInt(await h.tokenSymbolToCollectibleId("LINK")), 1);
  });

  it("distributes tokens.", async () => {
    await h.rewardNFT("LINK", admin);
    token = await Token.at(await h.tokenERC1155());
    assert.strictEqual(parseInt(await token.balanceOf(admin, 1)), 1);
  });

  it("does not allow same NFT claim twice.", async () => {
    await truffleAssert.reverts(
      h.rewardNFT("LINK", admin),
      "NFT already claimed for the token symbol !"
    );
  });
});
