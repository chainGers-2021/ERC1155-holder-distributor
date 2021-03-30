// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.9.0;

import "@openzeppelin/contracts/token/ERC1155/utils/ERC1155Holder.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "./Token.sol";

contract TokenHolder is ERC1155Holder, Ownable {
    uint256 public n;
    uint256 public amount;

    constructor(uint256 _n, uint256 _amount) {
        n = _n;
        amount = _amount;
    }

    function sendToWinners(
        address tokenAddr,
        address[] memory winners,
        uint256 id
    ) public onlyOwner {
        require(
            Token(tokenAddr).balanceOf(address(this), id) == n * amount,
            "Not enough amount to distribute to winners"
        );

        for (uint256 i = 0; i < n; i++) {
            Token(tokenAddr).safeTransferFrom(
                address(this),
                winners[i],
                id,
                amount,
                "0x0"
            );
        }
    }
}
