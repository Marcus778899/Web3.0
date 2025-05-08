// SPDX-License-Identifier: MIT
pragma solidity ^0.8.21;

contract OtherContract{
    uint256 private _x = 0;
    event Log(uint amount, uint gas);

    function getBalance() view public returns(uint) {
        return address(this).balance;
    }

    function setX(uint256 x) external payable{
        _x = x;
        if(msg.value > 0){
            emit Log(msg.value, gasleft());
        }
    }

    function getX() external view returns(uint x){
        x = _x;
    }
}

contract CallContract{

    // 傳入合約地址
    function callsetX(address _address, uint256 x) external {
        OtherContract(_address).setX(x);
    }

    // 傳入合約變數
    function callgetX(OtherContract _address) external view returns (uint x){
        x = _address.getX();
    }

    // 建立合約變數
    function callGetX2(address _address) external view returns (uint x){
        OtherContract oc = OtherContract(_address);
        x = oc.getX();
    }

    // 呼叫合約並發送ETH
    function setXTransferETH(address contractAddress, uint256 x) payable external {
        OtherContract(contractAddress).setX{value: msg.value}(x);
    }
}