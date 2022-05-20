// contracts/GLDToken.sol
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "hardhat/console.sol";
import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract LotteryToken is ERC20 {
   
   address public contractOwner;

    constructor() ERC20("Lottery", "LTR") {
        _mint(msg.sender, 100000 * 10 ** 18);
        contractOwner = msg.sender;
    }

}

