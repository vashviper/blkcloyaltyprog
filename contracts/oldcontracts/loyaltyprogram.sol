// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

contract loyaltyProgram{




  function getBalance() external view returns (uint256) {
        return address(this).balance;
    }

    
}