// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;
import "./IERC20.sol";

contract TokenSwap {
    IERC20 public ethToken;
    IERC20 public linkToken;
    IERC20 public daiToken;

    constructor(address _ethToken, address _linkToken, address _daiToken) {
        ethToken = IERC20(_ethToken);
        linkToken = IERC20(_linkToken);
        daiToken = IERC20(_daiToken);
    }

    function swapETHforLINK(uint256 amount) external {
        require(amount > 0, "Amount must be greater than zero");
        ethToken.transferFrom(msg.sender, address(this), amount);
        linkToken.transfer(msg.sender, amount);
    }

    function swapLINKforETH(uint256 amount) external {
        require(amount > 0, "Amount must be greater than zero");
        linkToken.transferFrom(msg.sender, address(this), amount);
        ethToken.transfer(msg.sender, amount);
    }

    function swapETHforDAI(uint256 amount) external {
        require(amount > 0, "Amount must be greater than zero");
        ethToken.transferFrom(msg.sender, address(this), amount);
        daiToken.transfer(msg.sender, amount);
    }

    function swapDAIforETH(uint256 amount) external {
        require(amount > 0, "Amount must be greater than zero");
        daiToken.transferFrom(msg.sender, address(this), amount);
        ethToken.transfer(msg.sender, amount);
    }

    function swapLINKforDAI(uint256 amount) external {
        require(amount > 0, "Amount must be greater than zero");
        linkToken.transferFrom(msg.sender, address(this), amount);
        daiToken.transfer(msg.sender, amount);
    }

    function swapDAIforLINK(uint256 amount) external {
        require(amount > 0, "Amount must be greater than zero");
        daiToken.transferFrom(msg.sender, address(this), amount);
        linkToken.transfer(msg.sender, amount);
    }
}
