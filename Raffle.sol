// contracts/GLDToken.sol
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "hardhat/console.sol";
import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "./LotteryToken.sol";  

contract Raffle is LotteryToken {

uint public ticketPrice = 100 * 10 ** 18;
uint ticketId;
address public dao; 
mapping(uint => address) public ticketToAddress;
mapping(address => uint[]) public addressToTickets;

uint[] public tickets;


    // Fonction pour acheter un ticket
    function buyTicket(uint256 prixUnitaire, uint256 quantity) external returns (uint) {      //PQ si 1er argument appelé "ticketPrice" ca fait un shadow de variable ? 
        require((prixUnitaire * quantity) == (ticketPrice * quantity), "Not the good price"); 
        // le front end permettrait pas de mettre un mauvais multiple ? 

        transfer(dao, (10 * 10 ** 18 * quantity));
        transfer(address(this), (90 * 10 ** 18 * quantity));

        for(uint i = quantity; i >= 1; i--) {
            addressToTickets[msg.sender] = tickets.push(ticketId);
            ticketToAddress[ticketId] = msg.sender; 
        ticketId++;
        }


        return ticketId;
    }

    // Fonction pour voir le prix global à gagner
    function seePrize() public view returns(uint) {
        return balanceOf(address(this)); 
    }

    // Fonction de tirage aléatoire
    function random() private view returns(uint) {
    return uint(keccak256(abi.encodePacked(block.difficulty, block.timestamp, tickets)));
    }


    event Draw(uint randomNumber); // Osef de donner un nom à cet uint ?

    function lotteryDraw() private returns(address) {
        require(msg.sender == contractOwner, "You are not the contract owner");
        
        uint index = random() % ticketId;
        emit Draw(index);
        console.log(ticketToAddress[index]);

        transfer(ticketToAddress[index], balanceOf(address(this)));
        return ticketToAddress[index];
        ticketId = 0;
    }

}


