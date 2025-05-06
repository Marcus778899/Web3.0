// SPDX-License-Identifier: MIT
pragma solidity ^0.8.21;
contract Event{
    mapping(address => uint256) public _balances;
    event Transfer(address indexed from, address indexed to, uint256 value);
    function _transfer(
        address from,
        address to,
        uint256 amount
    ) external {
        _balances[from] = 10000000; // 給轉帳地址一些初始代幣
        _balances[from] -= amount; // from 地址減去轉帳數量
        _balances[to] += amount; // to 地址加上轉帳數量
        
        emit Transfer(from, to, amount);
    }
}