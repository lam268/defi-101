// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

contract Whitelist {
    constructor() {
        owner = msg.sender;
    }

    address owner;
    mapping(address => bool) whitelistedAddresses;

    modifier onlyOwner() {
        require(msg.sender == owner, "Ownable: caller is not the owner");
        _;
    }

    function addUser(address _addressToWhitelist) public onlyOwner {
        whitelistedAddresses[_addressToWhitelist] = true;
    }

    function verifyUser(address _whitelistedAddress)
        public
        view
        returns (bool)
    {
        bool userIsWhitelisted = whitelistedAddresses[_whitelistedAddress];
        return userIsWhitelisted;
    }
}
