// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.8.2 <0.9.0;

import "./BigBank.sol";

contract Ownable {
    address public owner;
    BigBank public bank;

    constructor(address payable _bankAddress) {
        owner = msg.sender;
        bank = BigBank(_bankAddress);
    }

    modifier onlyOwner() {
        require(msg.sender == owner, unicode"只有Ownable合约管理员可以执行此操作");
        _;
    }

    // 转移 BigBank 合约的所有权
    function transferBigBankOwnership(address newOwner) public onlyOwner {
        bank.transferOwnership(newOwner);
    }

    // 提现函数，仅允许 Ownable 合约调用
    function withdrawFromBigBank() public onlyOwner {
        bank.withdraw();
    }
}