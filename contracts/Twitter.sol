// "SPDX-License-Identifier": Apache-2.0
pragma solidity ^0.8.26;

contract Twitter {




    // we are using a mapping between the address and the string and then actually making it to the public variable
    // What is a mapping???
    // Answer : Mapping is nothing but a key value pair just like we have objects in javascript here address is the key and string is the value
    mapping(address => string[]) public tweets;

   

// this is how we declare a function in solidity
    function createTweet(string memory _tweet) public {
        tweets[msg.sender].push(_tweet);
    }

// this is the function for getting the information we had used the keyword view in this function because this function does not doing any modification related task inside it
    function getTweet(address _owner,uint _i) public view returns(string memory){
       return tweets[_owner] [_i] ;
    }

    function getAllTweets(address _owner) public view returns (string[] memory){
        return tweets[_owner];
    }
}