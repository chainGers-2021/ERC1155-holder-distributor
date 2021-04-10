const Token = artifacts.require("Token");
const TokenHolder = artifacts.require("TokenHolder");
const assert = require("assert");

contract("Token & TokenHolder", async (addresses) => {
  const admin = addresses[0];
  const winners = addresses.slice(1, 6);
  const n = 5;
  const amountToEach = 1;
  const totalTokens = n * amountToEach;
  let h;

  before(async () => {
    h = await TokenHolder.new(n, amountToEach);
  });

  it("mints and distributes tokens correctly.", async () => {
    await h.mintTokens("LINK");
    assert.strictEqual(
      parseInt(await h.tokenSymbolToCollectibleId("LINK")),
      0
    );
    
    await h.mintTokens("LINK");
    assert.strictEqual(
      parseInt(await h.tokenSymbolToCollectibleId("LINK")),
      1
    );
    
    await h.rewardNFT("LINK", admin);

    await h.rewardNFT("LINK", admin).catch(()=>{console.log("Not giving NFT twice.")});
  });
});
