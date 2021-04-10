const TokenHolder = artifacts.require("TokenHolder");
const assert = require("assert");
const truffleAssert = require("truffle-assertions");

contract("Token & TokenHolder", async (addresses) => {
  const admin = addresses[0];
  const n = 5;
  const amountToEach = 1;
  const totalTokens = n * amountToEach;
  let h;

  before(async () => {
    h = await TokenHolder.new(n, amountToEach);
  });

  it("mints and distributes tokens correctly.", async () => {
    await h.mintTokens("LINK");
    assert.strictEqual(parseInt(await h.tokenSymbolToCollectibleId("LINK")), 0);
    await h.mintTokens("LINK");
    assert.strictEqual(parseInt(await h.tokenSymbolToCollectibleId("LINK")), 1);

    await h.rewardNFT("LINK", admin);
    await truffleAssert.reverts(
      h.rewardNFT("LINK", admin),
      "NFT already claimed for the token symbol !"
    );
  });
});
