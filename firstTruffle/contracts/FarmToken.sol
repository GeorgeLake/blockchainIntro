pragma solidity ^0.6.2;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts/utils/Address.sol";
import "@openzeppelin/contracts/token/ERC20/SafeERC20.sol";
import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract FarmToken is ERC20 {
    using Address for address;
    using SafeMath for uint256;
    using SafeERC20 for IERC20;

    IERC20 public token;

    constructor(address _token)
        public
        ERC20("FarmToken", "FRM")
    {
        token = IERC20(_token);
    }
    
    // balance on this smart contract
    function balance() public view returns (uint256) {
        return token.balanceOf(address(this));
    }

    // mint and transfer specied amount of farmtokens to user
    function deposit(uint256 _amount) public {
        // Amount must be greater than zero
        require(_amount > 0, "amount cannot be 0");
        // Transfer MyToken to smart contract
        token.safeTransferFrom(msg.sender, address(this), _amount);
        // Mint FarmToken to msg sender
        _mint(msg.sender, _amount);
    }

    // burn farmtokens in exchange for mytokens
    function withdraw(uint256 _amount) public {
        // Burn FarmTokens from msg sender
        _burn(msg.sender, _amount);
        // Transfer MyTokens from this smart contract to msg sender
        token.safeTransfer(msg.sender, _amount);
    }

}
