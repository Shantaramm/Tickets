// SPDX-License-Identifier: MIT

pragma solidity ^0.8.17;

import "@openzeppelin/contracts/utils/Counters.sol";
import "./Tikets.sol";


contract TiketStore {

    using Counters for Counters.Counter;
    Counters.Counter private _idEvent;

    address private owner;
    address public addressStor;
    uint256 public countEvent;
    address[] public collections;
    struct affair {
        uint256 id;
        address from; // создатель коллекции
        address fabric;
        uint256 supply; // коллво билетов
        string name;
        string symbol;
        string discription;
        bool format; // false - ofline,  true - online
        address ticketCollection; // контркат билетов
        uint256 date; // дата мероприятия 
        uint256 len;
    }

    mapping(uint256 => affair) public incidents;
    mapping(address => uint256[]) public listEvent;

    constructor () {
        owner = msg.sender;
        addressStor = address(this);
    }

    function createEvent(string memory _name, string memory _symbol, 
    string memory _discription, uint256 _supply, bool _format, address[] calldata _whiteList, uint256 _date) 
    public 
    returns(address) {
        _idEvent.increment();
        uint256 idEvent = _idEvent.current();
        uint256 date = block.timestamp +  (_date * 1 days);
        Tikets newTickets = new Tikets(_name, _symbol, _supply, idEvent, _whiteList, msg.sender, date);
        incidents[idEvent] = affair(idEvent, msg.sender, addressStor, _supply, _name, _symbol, _discription, _format, address(newTickets), date, _whiteList.length);
        collections.push(address(newTickets));
        countEvent ++;
        listEvent[msg.sender].push(idEvent);
        return address(newTickets);
    }


    function eventLength() 
    public 
    view 
    returns(uint256) {
       return listEvent[msg.sender].length; 

    }

}
