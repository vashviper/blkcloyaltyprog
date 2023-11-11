const ethers = require('ethers');

// Connect to Ethereum using an Ethereum provider (e.g., MetaMask)
const provider = new ethers.providers.Web3Provider(window.ethereum);

// Load your Smart Contract
const contractAddress = '0x065e2A50434B1c360CAE4a5616A93C647Df4AD0F';
const contractABI = [
  {
		"anonymous": false,
		"inputs": [
			{
				"indexed": false,
				"internalType": "address",
				"name": "customer",
				"type": "address"
			},
			{
				"indexed": false,
				"internalType": "uint256",
				"name": "pointsEarned",
				"type": "uint256"
			}
		],
		"name": "PointsEarned",
		"type": "event"
	},
	{
		"anonymous": false,
		"inputs": [
			{
				"indexed": false,
				"internalType": "address",
				"name": "customer",
				"type": "address"
			},
			{
				"indexed": false,
				"internalType": "uint256",
				"name": "pointsRedeemed",
				"type": "uint256"
			},
			{
				"indexed": false,
				"internalType": "uint256",
				"name": "rewardId",
				"type": "uint256"
			}
		],
		"name": "PointsRedeemed",
		"type": "event"
	},
	{
		"anonymous": false,
		"inputs": [
			{
				"indexed": false,
				"internalType": "address",
				"name": "customer",
				"type": "address"
			}
		],
		"name": "Registered",
		"type": "event"
	},
	{
		"anonymous": false,
		"inputs": [
			{
				"indexed": false,
				"internalType": "uint256",
				"name": "rewardId",
				"type": "uint256"
			},
			{
				"indexed": false,
				"internalType": "uint256",
				"name": "pointsRequired",
				"type": "uint256"
			},
			{
				"indexed": false,
				"internalType": "string",
				"name": "rewardName",
				"type": "string"
			}
		],
		"name": "RewardAdded",
		"type": "event"
	},
	{
		"inputs": [
			{
				"internalType": "uint256",
				"name": "rewardId",
				"type": "uint256"
			},
			{
				"internalType": "uint256",
				"name": "pointsRequired",
				"type": "uint256"
			},
			{
				"internalType": "string",
				"name": "rewardName",
				"type": "string"
			}
		],
		"name": "addReward",
		"outputs": [],
		"stateMutability": "nonpayable",
		"type": "function"
	},
	{
		"inputs": [
			{
				"internalType": "uint256",
				"name": "points",
				"type": "uint256"
			},
			{
				"internalType": "address",
				"name": "_customer",
				"type": "address"
			}
		],
		"name": "earnPoints",
		"outputs": [],
		"stateMutability": "nonpayable",
		"type": "function"
	},
	{
		"inputs": [
			{
				"internalType": "uint256",
				"name": "rewardId",
				"type": "uint256"
			}
		],
		"name": "redeemPoints",
		"outputs": [],
		"stateMutability": "nonpayable",
		"type": "function"
	},
	{
		"inputs": [],
		"name": "register",
		"outputs": [],
		"stateMutability": "nonpayable",
		"type": "function"
	},
	{
		"inputs": [],
		"stateMutability": "nonpayable",
		"type": "constructor"
	},
	{
		"inputs": [],
		"name": "checkBalance",
		"outputs": [
			{
				"internalType": "uint256",
				"name": "",
				"type": "uint256"
			}
		],
		"stateMutability": "view",
		"type": "function"
	},
	{
		"inputs": [
			{
				"internalType": "address",
				"name": "",
				"type": "address"
			}
		],
		"name": "customers",
		"outputs": [
			{
				"internalType": "uint256",
				"name": "balance",
				"type": "uint256"
			},
			{
				"internalType": "bool",
				"name": "isRegistered",
				"type": "bool"
			}
		],
		"stateMutability": "view",
		"type": "function"
	},
	{
		"inputs": [],
		"name": "owner",
		"outputs": [
			{
				"internalType": "address",
				"name": "",
				"type": "address"
			}
		],
		"stateMutability": "view",
		"type": "function"
	},
	{
		"inputs": [
			{
				"internalType": "uint256",
				"name": "",
				"type": "uint256"
			}
		],
		"name": "rewardNames",
		"outputs": [
			{
				"internalType": "string",
				"name": "",
				"type": "string"
			}
		],
		"stateMutability": "view",
		"type": "function"
	},
	{
		"inputs": [
			{
				"internalType": "uint256",
				"name": "",
				"type": "uint256"
			}
		],
		"name": "rewards",
		"outputs": [
			{
				"internalType": "uint256",
				"name": "",
				"type": "uint256"
			}
		],
		"stateMutability": "view",
		"type": "function"
	}

];
const contract = new ethers.Contract(contractAddress, contractABI, provider);

// Register a customer
async function registerCustomer() {
  try {
    const signer = provider.getSigner();
    const transaction = await contract.connect(signer).register();
    await transaction.wait();
    alert('Customer registered successfully!');
  } catch (error) {
    alert('Error registering customer: ' + error.message);
  }
}

// Earn points
async function earnPoints(points) {
  try {
    const signer = provider.getSigner();
    const transaction = await contract.connect(signer).earnPoints(points);
    await transaction.wait();
    alert('Points earned successfully!');
  } catch (error) {
    alert('Error earning points: ' + error.message);
  }
}

// Check balance
async function checkBalance() {
  try {
    const balance = await contract.balanceOf(signer.getAddress());
    alert(`Your point balance: ${balance}`);
  } catch (error) {
    alert('Error checking balance: ' + error.message);
  }
}

// Redeem points
async function redeemPoints(rewardId) {
  try {
    const signer = provider.getSigner();
    const transaction = await contract.connect(signer).redeemPoints(rewardId);
    await transaction.wait();
    alert('Points redeemed successfully!');
  } catch (error) {
    alert('Error redeeming points: ' + error.message);
  }
}

// Load and display available rewards
async function loadRewards() {
  const rewardsDiv = document.getElementById('rewards');
  rewardsDiv.innerHTML = '<h2>Available Rewards</h2>';
  
  try {
    const rewardsCount = await contract.getRewardsCount();
    for (let i = 0; i < rewardsCount; i++) {
      const reward = await contract.rewards(i);
      rewardsDiv.innerHTML += `<p>Reward ${i + 1}: ${reward.name} (Points Required: ${reward.pointsRequired})</p>`;
    }
  } catch (error) {
    rewardsDiv.innerHTML += '<p>Error loading rewards.</p>';
  }
}

// Attach event listeners
document.getElementById('registerButton').addEventListener('click', registerCustomer);
document.getElementById('earnPointsButton').addEventListener('click', () => {
  const pointsToEarn = document.getElementById('pointsToEarn').value;
  earnPoints(pointsToEarn);
});
document.getElementById('checkBalanceButton').addEventListener('click', checkBalance);
document.getElementById('redeemPointsButton').addEventListener('click', () => {
  const rewardId = document.getElementById('rewardId').value;
  redeemPoints(rewardId);
});
document.addEventListener('DOMContentLoaded', loadRewards);
