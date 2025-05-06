// SPDX-License-Identifier: MIT
pragma solidity ^0.8.21;

// 抽象合約：只定義，不完全實作
abstract contract Animal {
    function sound() public view virtual returns (string memory);
}

// 子合約：繼承並實作 sound()
contract Dog is Animal {
    function sound() public pure override returns (string memory) {
        return "woof";
    }
}

contract Cat is Animal{
    function sound() public pure override returns (string memory){
        return "meow";
    }
}

// 介面定義，只列出功能
interface IHello {
    function sayHello() external view returns (string memory);
}

// 合約實作這個介面
contract HelloWorld is IHello {
    function sayHello() external pure override returns (string memory) {
        return "Hi Solidity!!";
    }
}