// SPDX-License-Identifier: MIT
pragma solidity ^0.6.0;

import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/v3.0.0/contracts/token/ERC20/ERC20.sol";
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/v3.0.0/contracts/token/ERC20/IERC20.sol";
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/v3.0.0/contracts/access/Ownable.sol";
import "./Crypto.sol";

contract LoanManager is Crypto { 
    
    uint256 private _freeToken;
    uint256 private _rate;
    address private _fundWallet;
    mapping (address => uint256) private _loans;    
    address [] _loansArray;

    event Bet(address _gambler, uint256 _valueToBet);
        
    /**
     * @dev Initializes the contract.
     */
         //constructor(string memory name, string memory symbol, uint256 freeToken, address fundWallet)  CryptoCarpincho(name, symbol) public {
    constructor(string memory name, string memory symbol, uint256 freeToken)  Crypto(name, symbol) public {
        _freeToken = freeToken;
       _rate = 2; //2%
    }
    
    /**
     * @dev transfer free tokens 
     */
    function transferFreeTokens(address guest) onlyOwner public {
        
        _loansArray.push(guest);
        _loans[guest] += (_freeToken + (_freeToken * 2) / 100);//chequear
        transfer(guest,_freeToken);
    }
    
    /**
     * @dev set free tokens value
     */
    function setFreeToken(uint256 value) onlyOwner public {
        
         _freeToken = value;
    }
    
    /**
     * @dev get free token value
     * @return free token value
     */
    function getFreeTokenValue() onlyOwner external view returns (uint256) {
        
         return _freeToken;
    }
    
    
    /**
     * @dev get debt 
     * @return rate
     */
    function getLoan(address guest) public view returns (uint256) {
        
        return _loans[guest];
    }
    
    
    /**
     * @dev get rate 
     * @return rate
     */
    function getRate() public view returns (uint256) {
        
        return _rate;
    }
    
    
    /**
     * @dev get Loans
     * @return array of loans
     */
    function getLoans() public view returns( address  [] memory){
        return _loansArray;
    }
    
        /**
     * @dev get length
     * @return length of loans
     */
    function getLengthLoans() public view returns( uint256){
        return _loansArray.length;
    }

}


