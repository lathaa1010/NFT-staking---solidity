// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/access/Ownable.sol";



contract LathaStakeNFT is ERC721, Ownable {
    uint256 public totalSupply;
    constructor() ERC721("LathaStakeNFT", "LSN") {}

    function safeMint(address to) public {
        _safeMint(to, totalSupply);
    }
}
