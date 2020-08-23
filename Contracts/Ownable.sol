
pragma solidity ^0.5.0;

contract Ownable {

    address public owner;

    
    constructor () internal {

        owner = msg.sender;
    }

 
    modifier onlyOwner(address caller) {
        require(owner == caller, "Ownable: caller is not the owner");
        _;
    }

}