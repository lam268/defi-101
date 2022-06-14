// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/token/ERC721/ERC721.sol";

contract Token is ERC721 {
    struct Project {
        string name;
        string symbol;
        uint256 number;
    }
    mapping(uint256 => Project) public a;

    constructor(string memory _name, string memory symbol)
        public
        ERC721(_name, symbol)
    {}

    function mint(
        address _to,
        uint256 id,
        string memory name,
        string memory symbol
    ) public {
        _safeMint(_to, id);
        a[id].name = name;
        a[id].symbol = symbol;
        a[id].number = id;
    }

    function getProjectInformation(uint256 id)
        public
        view
        returns (Project memory)
    {
        return a[id];
    }
}
