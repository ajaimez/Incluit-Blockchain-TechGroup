/*
Comnados para generar el fork de ethereum

-u unlock => buscar wallet con USDT eje: 0xf7b2f3cd946052f8b397f801299b80f053515af9

ganache-cli -f https://mainnet.infura.io/v3/f7995f50bf234187b0cad39c53c24c48 -u 0xf7b2f3cd946052f8b397f801299b80f053515af9


*/
const fs = require("fs");
const Web3 = require('web3');
const usdtAbi = fs.readFileSync('./abi.js');

const recipientAddress = "0x1B1F0f4B347719C61dCf3006D2c6Ebda8188F210";
const unlockAddress = "0xf7b2f3cd946052f8b397f801299b80f053515af9";
const usdtAddress = "0xdAC17F958D2ee523a2206206994597C13D831ec7";

const web3 = new Web3("http://localhost:8545");
const usdt = new web3.eth.Contract(JSON.parse(usdtAbi), usdtAddress);


async function run(){
    let unlockedBalance, recipientBalance;

    ([unlockedBalance , recipientBalance] = await Promise.all( [
        usdt.methods.balanceOf(unlockAddress).call(),
        usdt.methods.balanceOf(recipientAddress).call()
    ]));

    console.log("unlockedBalance:" + unlockedBalance);
    console.log("recipientBalance:" + recipientBalance);

    await usdt.methods.transfer(recipientAddress,100000000000).send( { from: unlockAddress } );  
    
    ([unlockedBalance , recipientBalance] = await Promise.all( [
        usdt.methods.balanceOf(unlockAddress).call(),
        usdt.methods.balanceOf(recipientAddress).call()
    ]));

    console.log("unlockedBalance:" + unlockedBalance);
    console.log("recipientBalance:" + recipientBalance);
}

run();