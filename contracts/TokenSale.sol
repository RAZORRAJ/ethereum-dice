pragma solidity ^0.5.0;
import "./myToken.sol";
contract TokenSale {

    myToken public tokenContract;
    uint256 public tokenPrice;
    uint256 public tokensSold;

    event Sell(
      address _buyer,
      uint256 _amount
    );

    constructor (myToken _tokenContract, uint256 _tokenPrice) public {
        tokenContract = _tokenContract;
        tokenPrice = _tokenPrice;
    }

    function buyTokens(uint256 _numberOfTokens) public payable {
        require(msg.value == _numberOfTokens * tokenPrice);
        require(tokenContract.balanceof(address(this)) >= _numberOfTokens);
        require(tokenContract.transfer(msg.sender, _numberOfTokens));
        tokensSold += _numberOfTokens;
        emit Sell(msg.sender, _numberOfTokens);
    }
}
