// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.9.0;

import "@openzeppelin/contracts/token/ERC1155/ERC1155Holder.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "./Token.sol";

contract TokenHolder is ERC1155Holder, Ownable {
    uint256 public n; // Needs to be 5 (if top 5)
    uint256 public amountForEach; // Needs to be 1.
    uint256 public roundId; // This is for ensuring that a claimant gets only 1 NFT per token per distribution round

    // Symbol of token => collectibleId
    mapping(string => uint256) tokenRewardPair;

    // Address of claimant => Symbol of token => roundId (or collectible id ?)
    mapping(address => mapping(string => uint256)) public claims;

    constructor(uint256 _n, uint256 _amountForEach) public {
        n = _n;
        amountForEach = _amountForEach;
    }


    function sendToWinner(
        string calldata _tokenSymbol,
        address _claimant
    ) external
    {
        require(
            claims[_claimant][_tokenSymbol] != tokenRewardPair[_tokenSymbol], // collectibleId of the token,
            "NFT already claimed for the token symbol !"
        );

        // TODO: Send the NFT of the corresponding token symbol to the claimant
        claims[_claimant][_tokenSymbol] = tokenRewardPair[_tokenSymbol];// collectibleId of the token

    }


    // This function is useful for distributing NFTs to addresses in an array
    // function sendToWinners(
    //     address tokenAddr,
    //     address[] memory winners,
    //     uint256 id
    // ) public onlyOwner {
    //     require(
    //         Token(tokenAddr).balanceOf(address(this), id) == n * amountForEach,
    //         "Not enough amount to distribute to winners"
    //     );

    //     for (uint256 i = 0; i < n; i++) {
    //         Token(tokenAddr).safeTransferFrom(
    //             address(this),
    //             winners[i],
    //             id,
    //             amountForEach,
    //             "0x0"
    //         );
    //     }
    // }
}
