// SPDX-License-Identifier: MIT
pragma solidity ^0.8.21;

contract TestReceive{
    
    event Log(uint amount, uint gas);
    
    receive() external payable { 
        emit Log(msg.value, gasleft());
    }

    function getBalance() view public returns(uint){
        return address(this).balance;
    }

    event fallbackCalled(address Sender, uint Value, bytes Data);
    
    fallback() external payable{
        emit fallbackCalled(msg.sender, msg.value, msg.data);
    }
}

contract TestSend{

    constructor() payable{}

    receive() external payable { }

    // transfer()
    function transferETH(address payable _to, uint amount) external payable{
        _to.transfer(amount);
    }

    // send()
    error SendFailed();

    function sendETH(address payable _to, uint amount) external payable {
        bool successful = _to.send(amount);
        if(!successful){
            revert SendFailed();
        }
    }

    // call
    error CallFailed();

    function callETH(address payable _to, uint amount) external payable{
        (bool successful,) = _to.call{value: amount}("");
        if(!successful){
            revert CallFailed();
        }
    }

    function getBalance() view public returns(uint){
        return address(this).balance;
    }

}