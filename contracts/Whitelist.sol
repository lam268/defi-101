// SPDX-License-Identifier: MIT
pragma solidity ^0.8.11;

import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Enumerable.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/cryptography/ECDSA.sol";
import "@openzeppelin/contracts/utils/cryptography/MerkleProof.sol";

contract WhiteList is ERC721Enumerable, Ownable {
  
  using ECDSA for bytes32;
  
  uint256 public constant MINT_PRICE = 0.1 ether;
  bytes32 private _whitelistMerkleRoot;
  
  constructor() ERC721("Merkle Tree Whitelist", "MTW") {}
  
  function whitelistSale(bytes32[] memory proof, uint256 amount) external payable {
        // merkle tree list related
        require(_whitelistMerkleRoot != "", "Free Claim merkle tree not set");
        require(
            MerkleProof.verify(
                proof,
                _whitelistMerkleRoot,
                keccak256(abi.encodePacked(msg.sender, amount))
            ),
            "Free Claim validation failed"
        );

        // start minting
        uint256 currentSupply = totalSupply();

        for (uint256 i = 1; i <= amount; i++) {
            _safeMint(msg.sender, currentSupply + i);
        }
    }
  
    function setWhitelistMerkleRoot(bytes32 newMerkleRoot_) external onlyOwner {
        _whitelistMerkleRoot = newMerkleRoot_;
    }

}