// SPDX-License-Identifier: MIT

pragma solidity ^0.8.17;

import "@openzeppelin/contracts/token/ERC721/IERC721.sol"; 

contract Verifier {


    function verifier(address _collection, address _user) public view returns (bool) {
        IERC721 tickets = IERC721(_collection);
        if (tickets.balanceOf(_user) != 0){
            return true;
        return false;
        }
    }

}
