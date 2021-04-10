// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.9.0;

import "@openzeppelin/contracts/token/ERC1155/ERC1155Holder.sol";
import {
    Ownable as cOwnable
} from "@chainlink/contracts/src/v0.6/vendor/Ownable.sol";
import "./Token.sol";

contract TokenHolder is ERC1155Holder, cOwnable {
    uint256 public n; // Needs to be 5 (if top 5)
    uint256 public amountForEach; // Needs to be 1.
    uint256 public roundId; // This is for ensuring that a claimant gets only 1 NFT per token per distribution round

    // Symbol of token => collectibleId
    mapping(string => uint256) public tokenSymbolToCollectibleId;

    Token public tokenERC1155;

    // Address of claimant => Symbol of token => roundId (or collectible id ?)
    mapping(address => mapping(string => uint256)) public claims;

    constructor(uint256 _n, uint256 _amountForEach) public {
        n = _n;
        amountForEach = _amountForEach;
        tokenERC1155 = new Token(
            "https://storageapi.fleek.co/chaingers2021-team-bucket/meta/{id}.json"
        );
    }

    /// @notice Token minting can only be done by admins
    function mintTokens(string memory _tokenSymbol) external onlyOwner {
        tokenERC1155.mint(address(this), 5);
        tokenSymbolToCollectibleId[_tokenSymbol] =
            tokenERC1155.collectibleId() -
            1;
    }

    /// @notice Oracle node is supposed to fullfill this transaction
    function rewardNFT(string calldata _tokenSymbol, address _claimant)
        external
    {
        require(
            claims[_claimant][_tokenSymbol] !=
                tokenSymbolToCollectibleId[_tokenSymbol], // collectibleId of the token,
            "NFT already claimed for the token symbol !"
        );

        // TODO: Send the NFT of the corresponding token symbol to the claimant
        claims[_claimant][_tokenSymbol] = tokenSymbolToCollectibleId[
            _tokenSymbol
        ]; // collectibleId of the token
    }
}
