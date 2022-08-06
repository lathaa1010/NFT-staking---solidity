// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/token/ERC721/utils/ERC721Holder.sol";
import "@openzeppelin/contracts/token/ERC721/IERC721.sol";

contract Apple is ERC20, ERC721Holder, Ownable {
     IERC721 public nft;
     uint256 public emission_rate = (50 * 10 ** decimals()) / 1 days;//24*60*60
     mapping(uint256 => address) public tokenOwnerOf;
     mapping(uint256 => uint256) public StakedAt;
     


    constructor(address _nft) ERC20("Latha", "LTA") {
        nft = IERC721(_nft);
    }  

    //function mint(address to, uint256 amount) public onlyOwner {
        //_mint(to, amount);
    //}

    function stake(uint256 tokenId) external{
        nft.safeTransferFrom(msg.sender, address(this), tokenId);
        tokenOwnerOf[tokenId]=msg.sender;
        StakedAt[tokenId]=block.timestamp;

    }

    function calculateToken(uint256 tokenId) public view returns(uint256){
        uint256 timeElapsed = block.timestamp - StakedAt[tokenId];
        return timeElapsed * emission_rate;

    }

    function unstake(uint256 tokenId) external {
        require(tokenOwnerOf[tokenId]==msg.sender, "you cant unstake");
        _mint(msg.sender, calculateToken(tokenId));
        nft.transferFrom(address(this), msg.sender, tokenId);
        delete tokenOwnerOf[tokenId];
        delete StakedAt[tokenId];

    }
}
