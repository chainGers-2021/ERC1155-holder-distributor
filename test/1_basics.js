const Token = artifacts.require("Token");
const TokenHolder = artifacts.require("TokenHolder");
const assert = require("assert");

contract("Token & TokenHolder", async (addresses) => {
  const [admin, buyer1, buyer2, _] = addresses;

  it("are working.", async () => {
    const token = await Token.new("");
    const tokenHolder = await TokenHolder.new();
    const amount = 100;

    // Minting tokens and checking if tokenHolder receives it
    await token.mint(tokenHolder.address, amount);
    assert.strictEqual(parseInt(await token.balanceOf(tokenHolder.address, 0)), amount);

    // Sending the token to winners
    await tokenHolder.sendToWinners(token.address, buyer1, 0, amount / 2);
    await tokenHolder.sendToWinners(token.address, buyer2, 0, amount / 2);
    assert.strictEqual(parseInt(await token.balanceOf(buyer1, 0)), amount / 2);
    assert.strictEqual(parseInt(await token.balanceOf(buyer2, 0)), amount / 2);
  });
});
