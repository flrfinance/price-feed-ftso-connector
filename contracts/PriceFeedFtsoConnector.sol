// SPDX-License-Identifier: MIT
pragma solidity 0.8.9;

import "./utils/Address.sol";
import "./interfaces/IPriceFeed.sol";
import "./interfaces/IFtso.sol";

contract PriceFeedFtsoConnector is IPriceFeed {

    IFtso public immutable ftso; 
    uint public constant DECIMAL_PRECISION = 18; 
    uint public immutable PRECISION_DIFFERENCE; //needed for raising FTSO precision (usually 1e5) to loans price feed precision (1e18) 

    constructor(address _ftso) {
        Address.checkContract(_ftso);
        ftso = IFtso(_ftso);
        uint ftsoPrecision = ftso.ASSET_PRICE_USD_DECIMALS();
        require(ftsoPrecision <= DECIMAL_PRECISION, "PriceFeedFtsoConnector: FTSO precision is too high");
        PRECISION_DIFFERENCE = 10 ** (DECIMAL_PRECISION - ftsoPrecision);
     }

    function fetchPrice() external view override returns (uint) {
        (uint price,) = ftso.getCurrentPrice();
        return price * PRECISION_DIFFERENCE;
    }
}