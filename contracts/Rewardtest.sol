// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

contract LoyaltyProgram {
    address public owner; // The owner of the loyalty program smart contract
    uint256 public purchaseamt; // Purchase amount to calculate loyalty points
    uint256 public loyaltypoints; // Loyalty points earned per purchaseamt

    string[] public rewards; // List of available rewards
    string[] public customers; //list of customers 
    string[] public merchants; //list of merchants



    struct RewardStruct {
        string rewardName;
        uint256 loyaltypointsRequired;
    }

    struct CustomerAccountStruct {
        string accountName;
        uint256 customerbalancepoints;
        bool isCustomer;
    }

    struct MerchantAccountStruct {
        string merchantName;
        uint256 merchantbalancepoints;
        bool isMerchant;
    }





  
    //mapping(address => CustomerAccount) public customerAccounts; // Mapping of customer accounts



/*
    constructor() {
        owner = msg.sender;
        purchaseamt = 10; // Default purchase amount (change as needed)
        loyaltypoints = 1; // Default loyalty points (change as needed)
        rewards.push(Reward("Reward 1", 10)); // Default rewards (change as needed)
        rewards.push(Reward("Reward 2", 20));
        merchant = MerchantAccount("Merchant", 0); // Single merchant

        // Initialize merchant's account
        customerAccounts[address(this)] = merchant;
    }
*/


    //set deployer as owner
    constructor() {
        owner = msg.sender;
    }
    // Modifier to restrict access to the owner
    modifier onlyOwner() {
        require(msg.sender == owner, "Only the owner can call this function");
        _;
    }



/*
    // Function to add or modify rewards by the owner
    function addOrUpdateReward(string memory _rewardName, uint256 _loyaltypointsRequired) public onlyOwner
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
*/

    // Function for customers or merchants to create an account
    function createMerchantAccount(string memory _merchantName) public {
        //require(merchants[msg.sender] == true,"Cant creat account. Account Exists");
        //MerchantAccountStruct storage merchant;
        //merchant = MerchantAccountStruct(_merchantName, 50, true);
        //merchant.push(MerchantAccountStruct(_merchantName, 50,true));
        //MerchantAccount[msg.sender] = MerchantAccountStruct(_merchantName, 50,true); // Start with 50 balancepoints
    }




    function createCustomerAccount(string memory _accountName) public {        
        //require(bytes(CustomerAccount[msg.sender].accountName).length == 0,
         //   "Customer account already exists"
        //);
        //CustomerAccountStruct memory customer;
        //customer = CustomerAccountStruct(_accountName,0,true);
    }




/*
    // Function for customers to check their balancepoints
    function checkBalancePointsCustomer() public view returns (uint256) {
        return CustomerAccount[msg.sender].balancepoints;
    }

    function checkBalancePointsMerchant() public view returns (uint256) {
        return MerchantAccount[msg.sender].balancepoints;
    }
*/



/*
    // Function for merchants to award loyalty points to a customer
    function awardLoyaltyPoints(address customer, int256 _purchaseamt) public {
        require(_purchaseamt > 0, "Purchase amount must be greater than 0");
        require(msg.sender == address(this), "Merchant not registered");
        uint256 pointsEarned = uint256(_purchaseamt) / purchaseamt * loyaltypoints;
        customerAccounts[customer].balancepoints += pointsEarned;
    }

*/

/*
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
    */
}
