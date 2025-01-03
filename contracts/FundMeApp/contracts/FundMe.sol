//GET FUNDS FROM USERS
//WITHDRAW FUNDS
//SET MINIMUM FUNDING VALUE

// SPDX-License-Identifier: MIT
pragma solidity ^0.8.8;

contract FundMe {
    
    uint256 public minimumUSD = 50;
    function fund() public payable {
        //Want to set a minimum fund amount in USD
        //1. How do we send ETH to this contract?
        require(msg.value >= minimumUSD, "You have to atleast send 1 ETH"); //to get the value of what user is sending , its global

    }
    // function withdraw() {}
}