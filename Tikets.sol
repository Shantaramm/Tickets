// SPDX-License-Identifier: MIT

pragma solidity ^0.8.17;


import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/utils/Counters.sol";

contract Tikets is ERC721 {

    using Counters for Counters.Counter;
    Counters.Counter private _idTicet;

    address public owner;
    address private admin;
    uint256 public contractId;
    uint256 public totalSupply;
    bool private stateWhiteList = false;
    uint256 public countTic;
    uint256 public date;
    mapping(address => bool) public whteList;
    address[] public whitelistLook;
    uint256 public lenWhite;


    modifier ifAdmin() {
        require(msg.sender == admin);
        _;
    }

    constructor(string memory _name, string memory _symbol, uint256 _totalSupply, uint256 _id, 
    address[] memory _whiteList, address _admin, uint256 _date) 
    ERC721(_name, _symbol) {
        owner = msg.sender;
        admin = _admin;
        contractId = _id;
        totalSupply = _totalSupply;
        date = _date;
        whitelistLook = _whiteList;
        lenWhite = _whiteList.length;

        if (_whiteList.length != 0) {
            for(uint256 i = 0; i < _whiteList.length; i++) {
                whteList[_whiteList[i]] = true;
            stateWhiteList = true;
            }
        }
    }

    function setWhitelist(address[] calldata _whitelist) public ifAdmin {
        for(uint256 i = 0; i < _whitelist.length; i++) {
            whteList[_whitelist[i]] = true;
        stateWhiteList = true;
        }
    }

    function mint() public {
        require(block.timestamp < date, "Event ended, ticket not available");
        if (stateWhiteList == true){
            require(whteList[msg.sender] == true, "I'm sorry you're not on the whitelist");
        }
        _idTicet.increment();
        uint256 idTicet = _idTicet.current();
        require(idTicet <= totalSupply, "Error!!!");
        _safeMint(msg.sender, idTicet);
        countTic++;
    } 

    function remainingTickets() public view returns(uint256) {
        return totalSupply - countTic;
    }
}
