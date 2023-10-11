// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

contract LoyaltyProgram {
    address public owner;
    
    struct Customer {
        uint256 balance;
        bool isRegistered;
    }
    
    mapping(address => Customer) public customers;
    mapping(uint256 => uint256) public rewards;
    mapping(uint256 => string) public rewardNames;
    
    event Registered(address customer);
    event PointsEarned(address customer, uint256 pointsEarned);
    event PointsRedeemed(address customer, uint256 pointsRedeemed, uint256 rewardId);
    event RewardAdded(uint256 rewardId, uint256 pointsRequired, string rewardName);
    
    constructor() {
        owner = msg.sender;
    }
    
    modifier onlyOwner() {
        require(msg.sender == owner, "Only the owner can call this function");
        _;
    }
    
    function register() public {
        require(!customers[msg.sender].isRegistered, "Customer is already registered");
        customers[msg.sender] = Customer(100, true);
        emit Registered(msg.sender);
    }
    
    function earnPoints(uint256 points) public {
        require(customers[msg.sender].isRegistered, "Customer is not registered");
        customers[msg.sender].balance += points;
        emit PointsEarned(msg.sender, points);
    }
    
    function checkBalance() public view returns (uint256) {
        return customers[msg.sender].balance;
    }
    
    function redeemPoints(uint256 rewardId) public {
        require(customers[msg.sender].isRegistered, "Customer is not registered");
        require(rewards[rewardId] > 0, "Reward not found");
        require(customers[msg.sender].balance >= rewards[rewardId], "Insufficient points");
        
        customers[msg.sender].balance -= rewards[rewardId];
        emit PointsRedeemed(msg.sender, rewards[rewardId], rewardId);
        // Implement reward distribution logic here
    }
    
    function addReward(uint256 rewardId, uint256 pointsRequired, string memory rewardName) public onlyOwner {
        rewards[rewardId] = pointsRequired;
        rewardNames[rewardId] = rewardName;
        emit RewardAdded(rewardId, pointsRequired, rewardName);
    }
}
