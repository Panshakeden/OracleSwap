// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;
import {AggregatorV3Interface} from "../lib/chainlink/contracts/src/v0.8/shared/interfaces/AggregatorV3Interface.sol";

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


     function scalePrice(
        int256 _price,
        uint8 _priceDecimals,
        uint8 _decimals
    ) internal pure returns (int256) {
        if (_priceDecimals < _decimals) {
            return _price * int256(10 ** uint256(_decimals - _priceDecimals));
        } else if (_priceDecimals > _decimals) {
            return _price / int256(10 ** uint256(_priceDecimals - _decimals));
        }
        return _price;
    }
     function getDerivedPrice(
        AggregatorV3Interface _base,
        AggregatorV3Interface _quote,
        uint8 _decimals
    ) public view returns (int256) {
        require(
            _decimals > uint8(0) && _decimals <= uint8(18),
            "Invalid _decimals"
        );
        int256 decimals = int256(10 ** uint256(_decimals));
        (, int256 basePrice, , , ) = _base.latestRoundData();
        uint8 baseDecimals = _base.decimals();
        basePrice = scalePrice(basePrice, baseDecimals, _decimals);

        (, int256 quotePrice, , , ) = _quote.latestRoundData();
        uint8 quoteDecimals = _quote.decimals();
        quotePrice = scalePrice(quotePrice, quoteDecimals, _decimals);

        return (basePrice * decimals) / quotePrice;
    }

    
}
