// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.9.0;

import "@openzeppelin/contracts/token/ERC1155/ERC1155Holder.sol";
import {
    Ownable as cOwnable
} from "@chainlink/contracts/src/v0.6/vendor/Ownable.sol";
import "./Token.sol";

contract TokenHolder is ERC1155Holder, cOwnable {
    uint256 public roundId; // This is for ensuring that a claimant gets only 1 NFT per token per distribution round

    // Symbol of token => collectibleId
    mapping(string => uint256) public tokenSymbolToCollectibleId;
    // Address of claimant => Symbol of token => roundId (or collectible id ?)
    mapping(address => mapping(string => uint256)) public claims;

    address public node;
    address public tokenAddr;

    constructor(address _node, address _tokenAddr) public {
        node = _node;
        tokenAddr = _tokenAddr;
    }


    /// @notice Token minting can only be done by admins
    function mintTokens(string calldata _tokenSymbol) external onlyOwner {
        Token(tokenAddr).mint(address(this), 5);
        tokenSymbolToCollectibleId[_tokenSymbol] =
            Token(tokenAddr).collectibleId()-1;
    }

    /// @notice Oracle node is supposed to fullfill this transaction
    function rewardNFT(string calldata _tokenSymbol, address _claimant)
        external
    {
        require(msg.sender == node);
        require(
            claims[_claimant][_tokenSymbol] !=
                tokenSymbolToCollectibleId[_tokenSymbol], // collectibleId of the token,
            "NFT already claimed for the token symbol !"
        );
        // TODO: Send the NFT of the corresponding token symbol to the claimant
        claims[_claimant][_tokenSymbol] = tokenSymbolToCollectibleId[
            _tokenSymbol
        ]; // collectibleId of the token

        Token(tokenAddr).safeTransferFrom(
            address(this),
            _claimant,
            tokenSymbolToCollectibleId[_tokenSymbol],
            1,
            ""
        );
    }
}
