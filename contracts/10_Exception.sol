// SPDX-License-Identifier: MIT
pragma solidity ^0.8.21;

error NotOwner();

contract Errors{

    mapping ( uint256 => address ) public _owners;

    function transferOwner1(uint256 tokenID, address newOwner) external {
        if(_owners[tokenID] != msg.sender){
            revert NotOwner();
        }
        _owners[tokenID] = newOwner;
    }

}

contract TestException{

    mapping(address => uint256) public balanceOf;

    function transfer(address recipient, uint amount) public {

        require(amount > 0, "Transfer amount must be greater than zero");
        require(balanceOf[msg.sender] >= amount, "Insufficient balance");
        
        balanceOf[msg.sender] -= amount;
        balanceOf[recipient] += amount;
    }

    function safeDivide(uint a, uint b) public pure returns (uint) {
        assert(b != 0); // 檢查除數是否為零
        return a / b;
    }

    function withdraw(uint amount) public {
        if (balanceOf[msg.sender] < amount) {
            revert("Insufficient balance for withdrawal");
        }
        balanceOf[msg.sender] -= amount;
        payable(msg.sender).transfer(amount);
    }

}