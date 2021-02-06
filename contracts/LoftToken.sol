pragma solidity ^0.5.0;

import "hardhat/console.sol";
import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/token/ERC20/ERC20Detailed.sol";
import "@openzeppelin/contracts/token/ERC20/ERC20Pausable.sol";

contract LoftToken is ERC20, ERC20Detailed, ERC20Pausable {

  string private _name = "Loft Token";
  string private _symbol = "LOFT";
  uint8 private _decimals = 18;
  uint256 private _totalSupply = 100000;
  address private _owner;
  
  constructor() 
    ERC20Detailed(_name, _symbol, _decimals) 
    public 
  {
    require(totalSupply() < _totalSupply, "Cannot mint more than 100K");
    _mint(msg.sender, _totalSupply);
    // Set deployer as owner
    _owner = msg.sender;
  }
 
  function owner()
    public view returns (address)
  {
    return _owner;
  }

}
