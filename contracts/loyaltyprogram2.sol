// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

contract LoyaltyProgram {
    address public owner; //contract owner
    
    struct Customer {
        uint256 balance; // can be called to check the balance points
        bool isRegistered; //customer need to register or they will not be able to earn or redeem points
    }
    
    mapping(address => Customer) public customers;
    mapping(uint256 => uint256) public rewards; // the rewards are redeemed via rewardID
    mapping(uint256 => string) public rewardNames; // rewardID can be assigned a reward description
    
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
        customers[msg.sender] = Customer(100, true); // Upon registering the customer earns 100 points
        emit Registered(msg.sender);
    }
    
    function earnPoints(uint256 points, address _customer) public onlyOwner{
        //require(customers[msg.sender].isRegistered, "Customer is not registered"); //if customer did not register then points cannot be earned
        customers[_customer].balance += points; // for adding points to balance points
        emit PointsEarned(msg.sender, points);
    }
    
    function checkBalance() public view returns (uint256) {
        return customers[msg.sender].balance;// for checking the balance points
    }
    
    function redeemPoints(uint256 rewardId) public {
        require(customers[msg.sender].isRegistered, "Customer is not registered");
        require(rewards[rewardId] > 0, "Reward not found");
        require(customers[msg.sender].balance >= rewards[rewardId], "Insufficient points"); // if customer balance points is less than the reward points
        
        customers[msg.sender].balance -= rewards[rewardId]; // for deducting reward points from balance points
        emit PointsRedeemed(msg.sender, rewards[rewardId], rewardId);
        // Implement reward distribution logic here : To transact customer need
    }
    
    function addReward(uint256 rewardId, uint256 pointsRequired, string memory rewardName) public onlyOwner {
        rewards[rewardId] = pointsRequired; // rewardID is used to redeem, need to assign a number and points
        rewardNames[rewardId] = rewardName; // assign a reward name to a reward id
        emit RewardAdded(rewardId, pointsRequired, rewardName);
    }
}
