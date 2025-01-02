// SPDX-License-Identifier: Apache-2.0
import "@openzeppelin/contracts/access/Ownable.sol";
pragma solidity ^0.8.26;

contract Twitter {
    // Maximum length for a tweet
    uint16 public MAX_TWEET_LENGTH = 280;

    // Struct to represent a tweet
    struct Tweet {
        uint256 id; // Added ID for each tweet to make them unique
        address author;
        string content;
        uint256 timestamp;
        uint256 likes;
    }

    // Mapping from address to an array of tweets
    mapping(address => Tweet[]) public tweets;

    

    // Events for better tracking of actions
    event TweetCreated(address indexed author, uint256 indexed tweetId, string content);
    event TweetLiked(address indexed author, uint256 indexed tweetId, address indexed liker);
    event TweetUnliked(address indexed author, uint256 indexed tweetId, address indexed unliker);

 address public owner;
    // Constructor to set the owner of the contract
    constructor() {
        owner = msg.sender;
    }

    // Modifier to restrict function access to the contract owner
    modifier onlyOwner() {
        require(msg.sender == owner, "Only the owner can call this function");
        _;
    }

    // Function to change the maximum tweet length
    function changeTweetLength(uint16 newTweetLength) public onlyOwner() {
        MAX_TWEET_LENGTH = newTweetLength;
    }

// function for getting total Likes
function getTotalLikes(address _author) external view returns(uint)
{
    // by default the variables which is declared in solidity is set to 0 u don't have to set it to zero manually
    uint totalLikes;
    for(uint i = 0;i<tweets[_author].length;i++)
    {
        totalLikes += tweets[_author][i].likes;
    }
    return totalLikes;

}

    // Function to create a new tweet
    function createTweet(string memory _tweet) public {
        require(bytes(_tweet).length <= MAX_TWEET_LENGTH, "Tweet is too long");

        uint256 tweetId = tweets[msg.sender].length;  // Assign unique ID based on the array length
        Tweet memory newTweet = Tweet({
            id: tweetId,
            author: msg.sender,
            content: _tweet,
            timestamp: block.timestamp,
            likes: 0
        });
        tweets[msg.sender].push(newTweet);
        emit TweetCreated(msg.sender, tweetId, _tweet);
    }

    // Function to get a specific tweet by index
    function getTweet(uint256 _i) public view returns (Tweet memory) {
        require(_i < tweets[msg.sender].length, "Tweet index out of bounds");
        return tweets[msg.sender][_i];
    }

    // Function to get all tweets for a user
    function getAllTweets(address _owner) public view returns (Tweet[] memory) {
        return tweets[_owner];
    }

    // Function to like a tweet
    function likeTweet(address _author, uint256 _tweetId) public {
        require(_tweetId < tweets[_author].length, "Tweet ID does not exist");
        tweets[_author][_tweetId].likes += 1;
        emit TweetLiked(_author, _tweetId, msg.sender);
    }

    // Function to unlike a tweet
    function unlikeTweet(address _author, uint256 _tweetId) public {
        require(_tweetId < tweets[_author].length, "Tweet ID does not exist");
        require(tweets[_author][_tweetId].likes > 0, "Cannot unlike if no likes");
        tweets[_author][_tweetId].likes -= 1;
        emit TweetUnliked(_author, _tweetId, msg.sender);
    }
}