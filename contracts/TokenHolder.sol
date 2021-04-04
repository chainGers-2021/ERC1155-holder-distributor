// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.9.0;

import "@openzeppelin/contracts/token/ERC1155/ERC1155Holder.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "./Token.sol";

contract TokenHolder is ERC1155Holder, Ownable {
    uint256 public n;
    uint256 public amountForEach;

    constructor(uint256 _n, uint256 _amountForEach) public {
        n = _n;
        amountForEach = _amountForEach;
    }

    function sendToWinners(
        address tokenAddr,
        address[] memory winners,
        uint256 id
    ) public onlyOwner {
        require(
            Token(tokenAddr).balanceOf(address(this), id) == n * amountForEach,
            "Not enough amount to distribute to winners"
        );

        for (uint256 i = 0; i < n; i++) {
            Token(tokenAddr).safeTransferFrom(
                address(this),
                winners[i],
                id,
                amountForEach,
                "0x0"
            );
        }
    }
}
