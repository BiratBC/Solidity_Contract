
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;
import "./SimpleStorage.sol";

contract StorageFactory {
        // SimpleStorage public simpleStorage;
        SimpleStorage[] public simpleStorageArray;
    function createSimpleStorage() public{
        SimpleStorage simpleStorage = new SimpleStorage();
        simpleStorageArray.push(simpleStorage);
    }
    function storageFactoryStore(uint256 _simpleStorageIndex, uint256 _simpleStorageNumber)public {
        //Address 
        //ABI - Application Binary Interface ->its contains all the input/output functions
        SimpleStorage simpleStorage  =simpleStorageArray[_simpleStorageIndex];
        simpleStorage.store(_simpleStorageNumber);
    }

    function getStorageFactoryStore(uint256 _simpleStorageIndex)public view returns(uint256){
        return simpleStorageArray[_simpleStorageIndex].retrieve();
    }
}