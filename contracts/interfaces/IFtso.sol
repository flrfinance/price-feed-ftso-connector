// SPDX-License-Identifier: MIT
pragma solidity 0.8.9;

interface IFtso { 
    function getCurrentPrice() external view returns (uint256 _price, uint256 _timestamp);
    function symbol() external view returns (string memory);
    function ASSET_PRICE_USD_DECIMALS() external view returns (uint);
}