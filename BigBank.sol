// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.8.2 <0.9.0;

import "./Bank.sol";

contract BigBank is Bank {
    address public owner;

    constructor() {
        owner = msg.sender; // 部署合约的地址为初始管理员
    }

    modifier onlyOwner() {
        require(msg.sender == owner, unicode"只有管理员可以执行此操作");
        _;
    }

    modifier minDeposit() {
        require(msg.value > 0.001 ether, unicode"存款金额必须大于0.001 ether");
        _;
    }

    // 重写存款函数，添加最小存款限制
    function deposit() public payable override minDeposit {
        super.deposit();
    }

    // 重写提现函数，仅允许管理员调用
    function withdraw() public override onlyOwner {
        super.withdraw();
    }

    // 转移管理员
    function transferOwnership(address newOwner) public onlyOwner {
        require(newOwner != address(0), unicode"新管理员地址无效");
        owner = newOwner;
    }
}