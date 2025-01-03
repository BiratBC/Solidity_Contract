// SPDX-License-Identifier: MIT
pragma solidity 0.8.8; //adding solidity version which should match up with compiler


//contract is like class in oop
contract SimpleStorage { //
    //Types : boolean, uint, int, address (hexadecimal address), byte
    // bool hasFavouriteNumber = true;
    // string favouriteNumberInText = "Ten";
    // bytes32 favouriteBytes = "cats";
    //visibility :- default -> internal, private, public, external, internal
    // uint256 public favouriteNumber; //Intialized to '0'



    // function store(uint256 _favouriteNumber) public {
    //     favouriteNumber = _favouriteNumber;
    //     favouriteNumber = favouriteNumber + 1;
    // }
    //view and pure (no modification allowed) -> doesnt need gas to spend
    //view :- this function only reads -> doesnt take any input
    // function retrieve() public view returns(uint256) {
    //     return favouriteNumber;
    // }
    //pure :- only reads but also doesnt take any arguments from blockchain like favourite number , this like pure virtual function in c++
    // function read() public pure returns(uint256){
    //     return (5 * 5);
    // }

    //structure in solidity
    uint256 favoriteNumber;
    struct People{
        uint256 id; //0th index
        string name; //1st index
        uint256 favoriteNumber;
    }
    // People public person1 = People({
    //     id : 1,
    //     name : "Birat"
    // });

    //Array
    // uint256[] myFavouriteNumber;
    //Array of structure
    People[] public person;

    // function addPerson(string memory _name, uint256 _id) public {
    //     People memory newPerson = People(_id, _name); //pass value as same order in structure
    //     // People memory newPerson = People({
    //     //     id : _id,
    //     //     name : _name
    //     // });
    //     person.push(newPerson);
    // }

    //calldata,memory, storage
    /*
    calldata -> temp var which cannot be modified
    memory -> temp var which can be modified , require for array, string and mappings
    calldata -> permanent var which cannot be modified
    6 Places you can store and access data
        calldata
        memory
        storage
        code
        logs
        stack
    */

    //Mapping (key (unique), value pair)
    //Here key is a string type and corresponding value is of unsigned int
    mapping (string => uint256) public nameToId;

    function addPerson(string memory _name, uint256 _id, uint256 _favouriteNumber) public {//since function variables(parameters) only exists temporaryr we use memory keyword
        People memory newPerson = People(_id, _name, _favouriteNumber);
        person.push(newPerson);
        nameToId[_name] = _id; //added to map named nameToId
    }

      function store(uint256 _favoriteNumber) public virtual {
        favoriteNumber = _favoriteNumber;
    }
    

    function retrieve() public view returns (uint256){
        return favoriteNumber;
    }
    
    //EVM :-Etherium Virtual Machine -> Avalance, PhaANTOM, Polygon


} 
//0xd9145CCE52D386f254917e481eB44e9943F39138