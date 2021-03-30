const Token = artifacts.require("Token");
const TokenHolder = artifacts.require("TokenHolder");
const assert = require("assert");

contract("Token & TokenHolder", async (addresses) => {
  const admin = addresses[0];
  const winners = addresses.slice(1, 6);
  const n = 5;
  const amountToEach = 1;
  const totalTokens = n * amountToEach;
  let token, tokenHolder;

  beforeEach(async () => {
    token = await Token.new("");
    tokenHolder = await TokenHolder.new(n, amountToEach);
  });

  it("mints and distributes tokens correctly.", async () => {
    // Minting tokens and checking if tokenHolder receives it
    await token.mint(tokenHolder.address, totalTokens);
    assert.strictEqual(
      parseInt(await token.balanceOf(tokenHolder.address, 0)),
      totalTokens
    );

    // Sending the token to winners
    await tokenHolder.sendToWinners(token.address, winners, 0);

    // Checking winners balances
    winners.forEach(async (winner) => {
      assert.strictEqual(
        parseInt(await token.balanceOf(winner, 0)),
        amountToEach
      );
    });
  });

  it("allows only owner.", async () => {
    // Minting tokens and checking if tokenHolder receives it
    await token.mint(tokenHolder.address, totalTokens);
    assert.strictEqual(
      parseInt(await token.balanceOf(tokenHolder.address, 0)),
      totalTokens
    );

    // Sending the token to winners
    await tokenHolder
      .sendToWinners(token.address, winners, 0, {
        from: addresses[1],
      })
      .then(() => assert(false))
      .catch(() => assert(true));
  });
});
