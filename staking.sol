// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;
import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract staking is ERC20{
    mapping(address => uint) public staked;
    mapping(address => uint) private stakedFromTS; //TS is time stamp

    constructor() ERC20("JoySam Token", "JST"){ // To initialise the ERC 20 from OpenZepelin
        _mint(msg.sender, 10**18);
    }
    function stake(uint amount) public { //to capture the amount we want to stake 
        require(amount > 0, "amount is < = 0"); 
        require(balanceOf(msg.sender) >= amount, "You do not have up to that amount");//The amount the person is calling should be greater or equal to the amount you want to stake
        _transfer(msg.sender, address(this), amount); // Taking the money out of the person account
 
        if(staked[msg.sender] > 0){// the staked amount should be greater than 0, if it is greater we can claim
        claim();
}
 
    stakedFromTS[msg.sender] = block.timestamp; //It is from our mapping. We want to incorporate the values in the mapping
    staked[msg.sender] = staked[msg.sender] + amount; //we are adding the staked amount 
}
 
    function unstake(uint amount) public { // to unstake the amount
    require(amount >0, "amount <=0"); // whatever you are unstaking should be greater than 0
 
    require(staked[msg.sender] > 0, "You did not stake with us");//if t
    _transfer(address(this), msg.sender, amount);//transfer of the inputted amount to the to person address
 
    stakedFromTS[msg.sender] = block.timestamp; //to help capture the time we
    staked[msg.sender] = staked[msg.sender] - amount; // to deduct the staked amount
    //staked[msg.sender]-= amount another way to write line 32
 
}
 
    function claim() public {
    require(staked[msg.sender] > 0, "You did not stake with us"); //What you should claim must be greater than 0
    uint secondsStaked = block.timestamp - stakedFromTS[msg.sender]; // Check the time you've staked 
    
    uint rewards = staked[msg.sender] * secondsStaked / 3.154e7;//the amount staked times seconds divided by a yesr to know the rewards
    _mint(msg.sender,rewards);// to mint the reward that was claimed
    stakedFromTS[msg.sender] = block.timestamp;// the time the reward was claimed
 
}
 
}
    
   