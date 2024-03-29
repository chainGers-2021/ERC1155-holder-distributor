// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.9.0;

import "@openzeppelin/contracts/token/ERC1155/ERC1155.sol";
import {
    Ownable as cOwnable
} from "@chainlink/contracts/src/v0.6/vendor/Ownable.sol";

contract Token is ERC1155, cOwnable {
    uint256 public collectibleId;

    constructor(string memory _tokenURI) public ERC1155(_tokenURI) {
        collectibleId = 1;
    }

    function mint(address _receiver, uint256 amount) public onlyOwner {
        _mint(_receiver, collectibleId, amount, "");
        collectibleId++;
    }
}
