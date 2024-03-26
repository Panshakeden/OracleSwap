// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test, console} from "forge-std/Test.sol";
import "../src/Counter.sol";
import "../src/IERC20.sol";
// import "../contracts/ERC20.sol";

contract Counter is Test {

    TokenSwap swapContract;

     IERC20 eth;
     IERC20 link;
     IERC20  dai;

    address AddrEth = address(0xa);
    address AddrDai = address(0xb);
    address AddrLink = address(0xc);


    function setUp() public {
      
     swapContract = new TokenSwap(address(dai), address(eth), address(link));
        
        AddrEth = mkaddr("AddrEth");
        AddrDai = mkaddr("AddrDai");
        AddrLink = mkaddr("AddrLink");

     
        
    }


    function testswapETHforDAI() public {
        switchSigner(AddrDai);
        dai.transfer(address(swapContract), 900000);

        switchSigner(AddrEth);
        uint balanceOfDaiBeforeSwap = dai.balanceOf(AddrEth);
        eth.approve(address(swapContract), 1);

        // swapContract.swapEthDai(1);

        uint balanceOfDaiAfterSwap = dai.balanceOf(AddrEth);

        assertGt(balanceOfDaiAfterSwap, balanceOfDaiBeforeSwap);

    }

     function testswapETHforLINK() public {
        switchSigner(AddrLink);
        link.transfer(address(swapContract), 900000);

        switchSigner(AddrEth);
        uint balanceOfLinkBeforeSwap = link.balanceOf(AddrEth);
        eth.approve(address(swapContract), 1);

        // swapContract.swapEthLink(1);

        uint balanceOflinkAfterSwap = link.balanceOf(AddrEth);

        assertGt(balanceOflinkAfterSwap, balanceOfLinkBeforeSwap);

    }

     function testswapLINKforDAI() public {
        switchSigner(AddrDai);
        dai.transfer(address(swapContract), 900000);

        switchSigner(AddrLink);
        uint balanceOfDaiBeforeSwap = dai.balanceOf(AddrLink);
        link.approve(address(swapContract), 1);

        // swapContract.swapLinkDai(1);

        uint balanceOfDaiAfterSwap = dai.balanceOf(AddrLink);

        assertGt(balanceOfDaiAfterSwap, balanceOfDaiBeforeSwap);

    }

     function testswapLINKforETH() public {
        switchSigner(AddrEth);
        eth.transfer(address(swapContract), 900000);

        switchSigner(AddrLink);
        uint balanceOfLinkBeforeSwap = eth.balanceOf(AddrLink);
        link.approve(address(swapContract), 1);

        // swapContract.swapLinkEth(1);

        uint balanceOfLinkAfterSwap = eth.balanceOf(AddrLink);

        assertGt(balanceOfLinkAfterSwap, balanceOfLinkBeforeSwap);

    }

     function testswapDAIforLINK() public {
        switchSigner(AddrLink);
        link.transfer(address(swapContract), 900000);

        switchSigner(AddrDai);
        uint balanceOfLinkBeforeSwap = link.balanceOf(AddrDai);
        dai.approve(address(swapContract), 1);

        // swapContract.swapDaiLink(1);

        uint balanceOfLinkAfterSwap = link.balanceOf(AddrDai);

        assertGt(balanceOfLinkAfterSwap, balanceOfLinkBeforeSwap);

    }

     function testswapDAIforETH() public {
        switchSigner(AddrEth);
        eth.transfer(address(swapContract), 900000);

        switchSigner(AddrDai);
        uint balanceOfEthBeforeSwap = eth.balanceOf(AddrDai);
        dai.approve(address(swapContract), 1);

        // swapContract.swapDaiEth(1);

        uint balanceOfEthAfterSwap = eth.balanceOf(AddrEth);

        assertGt(balanceOfEthAfterSwap, balanceOfEthBeforeSwap);

    }

    function mkaddr(string memory name) public returns (address) {
        address addr = address(
            uint160(uint256(keccak256(abi.encodePacked(name))))
        );
        vm.label(addr, name);
        return addr;
    }

    function switchSigner(address _newSigner) public {
        address foundrySigner = 0x1804c8AB1F12E6bbf3894d4083f33e07309d1f38;
        if (msg.sender == foundrySigner) {
            vm.startPrank(_newSigner);
        } else {
            vm.stopPrank();
            vm.startPrank(_newSigner);
        }
    }

    
}