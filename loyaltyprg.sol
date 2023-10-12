// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

contract LoyaltyProgram {
    address public owner; // The owner of the loyalty program smart contract

    uint256 public purchaseamt; // Purchase amount to calculate loyalty points
    uint256 public loyaltypoints; // Loyalty points earned per purchaseamt

    struct Reward {
        string rewardName;
        uint256 loyaltypointsRequired;
    }

    struct CustomerAccount {
        string accountName;
        uint256 balancepoints;
    }

    Reward[] public rewards; // List of available rewards
    CustomerAccount public merchant;

    mapping(address => CustomerAccount) public customerAccounts; // Mapping of customer accounts

    constructor() {
        owner = msg.sender;
        purchaseamt = 10; // Default purchase amount (change as needed)
        loyaltypoints = 1; // Default loyalty points (change as needed)
        rewards.push(Reward("Reward 1", 10)); // Default rewards (change as needed)
        rewards.push(Reward("Reward 2", 20));
        merchant = CustomerAccount("Merchant", 0); // Single merchant

        // Initialize merchant's account
        customerAccounts[address(this)] = merchant;
    }

    // Modifier to restrict access to the owner
    modifier onlyOwner() {
        require(msg.sender == owner, "Only the owner can call this function");
        _;
    }

    // Function to add or modify rewards by the owner
    function addOrUpdateReward(string memory _rewardName, uint256 _loyaltypointsRequired)
        public
        onlyOwner
    {
        bool rewardExists = false;
        for (uint256 i = 0; i < rewards.length; i++) {
            if (keccak256(bytes(rewards[i].rewardName)) == keccak256(bytes(_rewardName))) {
                rewards[i].loyaltypointsRequired = _loyaltypointsRequired;
                rewardExists = true;
                break;
            }
        }
        if (!rewardExists) {
            rewards.push(Reward(_rewardName, _loyaltypointsRequired));
        }
    }

    // Function for customers to create an account
    function createCustomerAccount(string memory _accountName) public {
        require(
            bytes(customerAccounts[msg.sender].accountName).length == 0,
            "Customer account already exists"
        );
        customerAccounts[msg.sender] = CustomerAccount(_accountName, 20); // Start with 20 balancepoints
    }

    // Function for customers to check their balancepoints
    function checkBalancePoints() public view returns (uint256) {
        return customerAccounts[msg.sender].balancepoints;
    }

    // Function for merchants to award loyalty points to a customer
    function awardLoyaltyPoints(address customer, int256 _purchaseamt) public {
        require(_purchaseamt > 0, "Purchase amount must be greater than 0");
        require(msg.sender == address(this), "Merchant not registered");
        uint256 pointsEarned = uint256(_purchaseamt) / purchaseamt * loyaltypoints;
        customerAccounts[customer].balancepoints += pointsEarned;
    }

    // Function for customers to redeem rewards
    function redeemReward(uint256 rewardIndex) public {
        require(rewardIndex < rewards.length, "Invalid reward index");
        require(
            customerAccounts[msg.sender].balancepoints >= rewards[rewardIndex].loyaltypointsRequired,
            "Insufficient balancepoints"
        );
        customerAccounts[msg.sender].balancepoints -= rewards[rewardIndex].loyaltypointsRequired;
        // Implement reward redemption logic here, e.g., send the reward to the customer
        // This is a simplified example, and you should customize it as per your needs
    }
}
