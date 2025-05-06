// SPDX-License-Identifier: MIT
pragma solidity ^0.8.21;

contract ConstantVsImmutable {
    // constant：在宣告時就必須賦值，值永遠不會變
    uint256 public constant MY_CONSTANT = 100;

    // immutable：可以等 constructor 時才賦值，值一樣不能再改
    address public immutable OWNER;
    uint256 public immutable DEPLOY_BLOCK;
    uint256 public immutable FROM_FUNCTION;

    // constructor：合約部署時執行一次
    constructor() {
        OWNER = msg.sender; // 部署者
        DEPLOY_BLOCK = block.number; // 當前區塊號
        FROM_FUNCTION = getValue(); // 從函式取得一個值
    }

    // 測試用函式，回傳一個數字
    function getValue() public pure returns (uint256) {
        return 999;
    }
}
