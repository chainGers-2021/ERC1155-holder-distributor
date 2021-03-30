// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.9.0;

import "@openzeppelin/contracts/token/ERC1155/utils/ERC1155Holder.sol";
import "./Token.sol";

contract TokenHolder is ERC1155Holder {
    function sendToWinners(
        address tokenAddr,
        address winner,
        uint256 id,
        uint256 amount
    ) public {
        Token(tokenAddr).safeTransferFrom(
            address(this),
            winner,
            id,
            amount,
            "0x0"
        );
    }
}
