// "SPDX-License-Identifier" : Apache-2.0
pragma solidity ^0.8.26;

contract Calculator {


  uint256 result = 0;


// function for creating addition function in solidity
  function add(uint256 num) public{
    result +=num;
  }


// function for creatin subtraction function
  function sub(uint256 num) public{
   result = result - num;
}

// function for creating multiplication of the function

function mul(uint256 num) public{
    result = result*num;
}

function get() public view returns(uint256){
    return result;
}



}

