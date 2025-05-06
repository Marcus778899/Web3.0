// SPDX-License-Identifier: MIT
pragma solidity ^0.8.21;

contract DataLocation{

    uint[] x = [1, 2, 3]; // state variable

    function fStorage() public {
        uint[] storage xStorage = x;
        xStorage[0] = 10; // x的索引0會改變
    }
    
    function bar() external pure returns(uint){
        // xx, yy invaild external
        uint xx = 1;
        uint yy = 3;
        uint zz = xx + yy;
        return(zz);
    }

    function global() external view returns(address, uint, bytes memory){
        // reserved words
        address sender = msg.sender;
        uint blockNum = block.number;
        bytes memory data = msg.data;
        return(sender, blockNum, data);
    }

}