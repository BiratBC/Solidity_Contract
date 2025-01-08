//GET FUNDS FROM USERS
//WITHDRAW FUNDS
//SET MINIMUM FUNDING VALUE

// SPDX-License-Identifier: MIT
pragma solidity ^0.8.8;

import "contracts/FundMeApp/contracts/PriceConverter.sol";

contract FundMe {
    using PriceConverter for uint256;
    
    uint256 public minimumUSD = 50 * 1e18; //this is in wei

    address[] public funders;

    mapping (address => uint256) public addressToAmountFunded; //creating a map[key value pair] to track the record of amount sent by funders with their name


    function fund() public payable {
        //Want to set a minimum fund amount in USD
        //1. How do we send ETH to this contract?
        require(msg.value.getConversionRate() >= minimumUSD, "You have to atleast send 1 ETH"); //to get the value of what user is sending , its global
        funders.push(msg.sender); //pushes the sendeers address to the funders stack
        addressToAmountFunded[msg.sender] = msg.value;
    }

    

   
    // function withdraw() {}
}