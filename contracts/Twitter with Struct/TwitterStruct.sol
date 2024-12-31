// "SPDX-License-Identifier" : Apache-2.0
pragma solidity ^0.8.26;

contract Twitter {

    

    uint16 public MAX_TWEET_LENGTH=280;



    // how to define it using struct in Solidity
    struct Tweet{
        address author;
        string content;
        uint256 timestamp;
        uint256 likes;
    }



    // we are using a mapping between the address and the string and then actually making it to the public variable
    // What is a mapping???
    // Answer : Mapping is nothing but a key value pair just like we have objects in javascript here address is the key and string is the value
    mapping(address => Tweet[]) public tweets;

    address public owner;


// created a owner variable which is a sender if msg.sender is a owner than we have to run the function otherwise not this is the main key
   constructor (){
     owner = msg.sender;
   }


// as we know modifiers are same as what i do as role based authentication using javascript here also we are more or less doing the same
   modifier onlyOwner(){
    require(msg.sender == owner, "You are not the owner");
    _;
   }

    // for changing max tweet length using this 
    // also we had used onlyOwner modifier for checking the logic
    function changeTweetLength(uint16 newTweetLength) public onlyOwner{
        MAX_TWEET_LENGTH =  newTweetLength;
    }

// this is how we declare a function in solidity
    function createTweet(string memory _tweet) public {

     
    // Important concepts in Solidiy ( Require ) we use " require " keyword as if else is something is true return this or exit simple as that just a conditional statement nothing else
    // We are using bytes function to convert the string into bytes and then comparing it lol
     require(bytes(_tweet).length <= MAX_TWEET_LENGTH, "Your Tweet is too long bro");

        Tweet memory newTweet = Tweet({
            author: msg.sender,
            content: _tweet,
            timestamp: block.timestamp,
            likes:0
        });
        tweets[msg.sender].push(newTweet);
    }

// this is the function for getting the information we had used the keyword view in this function because this function does not doing any modification related task inside it
    function getTweet(uint _i) public view returns(Tweet memory){
       return tweets[msg.sender] [_i] ;
    }

    function getAllTweets(address _owner) public view returns (Tweet[] memory){
        return tweets[_owner];
    }
}