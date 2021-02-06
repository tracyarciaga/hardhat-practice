pragma solidity ^0.5.0;

import "hardhat/console.sol";

import "@openzeppelin/contracts/crowdsale/Crowdsale.sol";
import "@openzeppelin/contracts/crowdsale/validation/TimedCrowdsale.sol";

contract LoftTokenCrowdsale is Crowdsale, TimedCrowdsale {
  mapping(address => uint256) public contributions;

  constructor(
      uint256 _rate, 
      address payable _wallet, 
      IERC20 _token,
      uint256 _openingTime,
      uint256 _closingTime
  ) 
    Crowdsale(_rate, _wallet, _token) 
    TimedCrowdsale(_openingTime, _closingTime)
    public 
  {
  }

  /**
  * @dev Returns the amount contributed so far by a sepecific user.
  * @param _beneficiary Address of contributor
  * @return User contribution so far
  */
  function getUserContribution(address _beneficiary)
    public view returns (uint256)
  {
    return contributions[_beneficiary];
  }

  /**
  * @dev Override for extensions that require an internal state to check for validity (current user contributions,
  * etc.)
  * @param beneficiary Address receiving the tokens
  * @param weiAmount Value in wei involved in the purchase
  */
  function _updatePurchasingState(
    address beneficiary,
    uint256 weiAmount
  )
    internal
  {
    super._updatePurchasingState(beneficiary, weiAmount);
    uint256 _existingContribution = contributions[beneficiary];
    uint256 _newContribution = _existingContribution.add(weiAmount);
    contributions[beneficiary] = _newContribution;
  }

}