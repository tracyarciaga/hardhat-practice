pragma solidity ^0.5.0;

import "hardhat/console.sol";
import "@openzeppelin/contracts/access/Roles.sol";
import "@openzeppelin/contracts/crowdsale/Crowdsale.sol";
import "@openzeppelin/contracts/crowdsale/emission/AllowanceCrowdsale.sol";
import "@openzeppelin/contracts/crowdsale/validation/TimedCrowdsale.sol";
import "@openzeppelin/contracts/crowdsale/distribution/PostDeliveryCrowdsale.sol";

contract LoftTokenCrowdsale is Crowdsale, AllowanceCrowdsale, TimedCrowdsale, PostDeliveryCrowdsale {
  using Roles for Roles.Role;

  Roles.Role private _admin;
  uint8 private _stage;
  uint256 private _secondSaleOpening;

  mapping(address => uint256) public contributions;
  enum CrowdsaleStage { First, Second }
  

  constructor(
      uint256 _rate, 
      address payable _wallet, 
      IERC20 _token,
      address _tokenWallet,
      uint256 _openingTime,
      uint256 _closingTime,
      uint8 _crowdsaleStage
  ) 
    PostDeliveryCrowdsale()
    TimedCrowdsale(_openingTime, _closingTime)
    AllowanceCrowdsale(_tokenWallet)
    Crowdsale(_rate, _wallet, _token) 
    public 
  {
    // TODO: check if deployer is also the token contract owner
    // require(msg.sender == _token.owner);

    // Set deployer as admin
    _admin.add(msg.sender);

    // Set state
    // TODO: Comment if doing two deployments per stage.
    // _stage = uint8(CrowdsaleStage.First);
    // _secondSaleOpening = _closingTime + 30 days;

    if (_crowdsaleStage == uint8(CrowdsaleStage.Second)) {
      require(_rate >= 200);
    }

  }

  function stage()
    public view returns (uint8)
  {
    return _stage;
  }

  /**
  * @dev Returns the amount contributed so far by a sepecific user.
  * @param beneficiary Address of contributor
  * @return User contribution so far
  */
  function getUserContribution(address beneficiary)
    public view returns (uint256)
  {
    return contributions[beneficiary];
  }

 

  /**
  * TODO: Uncomment this function if doing single deployment only.
  * @dev Allows admin to start the second sale.
  * @param closingTime new closingTime
  */
//  function startSecondSale(uint256 closingTime, address tokenWallet) public {
//     require(_admin.has(msg.sender), "Calling address does not have admin role.");
//     require(super.isOpen(), "First Sale not yet done.");
//     _stage == uint8(CrowdsaleStage.Second);
//     super._deliverTokens(tokenWallet, 30000);
//     super._extendTime(closingTime);
//   }

 /**
  * @dev Allows admin to extend time of the sale.
  * @param closingTime new closingTime
  */
 function extendTime(uint256 closingTime) public {
    require(_admin.has(msg.sender), "Calling address does not have admin role");
    if (_stage == uint8(CrowdsaleStage.First)) {
      // Presale Closing time (can be adjusted to a maximum of 60 days)
      require(closingTime > (now + 60 days), "Cannot extend first sale to more than 60 days");
    }
    super._extendTime(closingTime);
  }


  /**
  * @dev Extend parent behavior by updating contributions.
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
    uint256 existingContribution = contributions[beneficiary];
    uint256 newContribution = existingContribution.add(weiAmount);
    contributions[beneficiary] = newContribution;
  }

}