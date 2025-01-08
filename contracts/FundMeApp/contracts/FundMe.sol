//GET FUNDS FROM USERS
//WITHDRAW FUNDS
//SET MINIMUM FUNDING VALUE

//WE WANT THE ONE WHO DEPLOY THIS CONTRACT BE THE OWNER OF THIS FUND ME

// SPDX-License-Identifier: MIT
pragma solidity ^0.8.8;

import "contracts/FundMeApp/contracts/PriceConverter.sol";

error NotOwner(); //replacing require with this will save more gas

contract FundMe {
    //constant , immutable
    using PriceConverter for uint256;

    uint256 public constant MINIMUM_USD = 50 * 1e18; //this is in wei

    address[] public funders;

    mapping(address => uint256) public addressToAmountFunded; //creating a map[key value pair] to track the record of amount sent by funders with their name

    //Owner
    address public immutable i_owner; //naming convention for immutable variable i_

    constructor() {
        i_owner = msg.sender;
    }

    function fund() public payable {
        //Want to set a minimum fund amount in USD
        //1. How do we send ETH to this contract?
        require(
            msg.value.getConversionRate() >= MINIMUM_USD,
            "You have to atleast send 1 ETH"
        ); //to get the value of what user is sending , its global
        funders.push(msg.sender); //pushes the sendeers address to the funders stack
        addressToAmountFunded[msg.sender] = msg.value;
    }

    function withdraw() public onlyOwner {
        // require(msg.sender == owner, "Sender is not owner");

        for (
            uint256 funderIndex = 0;
            funderIndex < funders.length;
            funderIndex++
        ) {
            address funder = funders[funderIndex];
            addressToAmountFunded[funder] = 0; //the amount to the funder's address will be set to 0
        }
        //reset the array funders
        funders = new address[](0); //cleaning the memory
        //actually withdraw the amount

        //NATIVE FUNCTIONS TO SEND MONEY : transfer, send and call

        //transfer -> returns error
        //msg.sender = address
        //payble(msg.sender) = payable address
        // payable(msg.sender).transfer(address(this).balance); //this is the way of sending eth from this contract address(this) means whole contract
        // send -> returns -= bool
        // bool sendSuccess = payable(msg.sender).send(address(this).balance);
        // require(sendSuccess, "send Failed");
        //call
        (bool callSuccess, ) = payable(msg.sender).call{
            value: address(this).balance
        }("");
        require(callSuccess, "call Failed");
    }

    modifier onlyOwner() {
        // require(msg.sender == i_owner, "Sender is not owner");
        if (msg.sender != i_owner) {
            revert NotOwner();
        }
        _; //its like next() or run the other code
    }

    //WHAT HAPPENS IF SOMEONE  SENDS THIS CONTRACT ETH WITHOUT CALLING THE FUND FUNCTION WHICH CAN BE POSSIBLE

    //fallback()
    //receive()


//if someone accidently sends us money without calling the fuind() function these two advance function will divert to call the funde function 
//automatically 
    receive() external payable { 
        fund();
    }

    fallback() external payable { 
        fund();
    }
}
