// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;


import "@openzeppelin/contracts/proxy/Clones.sol";
import "@openzeppelin/contracts-upgradeable/token/ERC20/presets/ERC20PresetFixedSupplyUpgradeable.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract TokenFactory is Ownable {
    address public immutable tokenImplementation;
    address[] public tokenContracts;
    uint256 public tokenCounter;

    constructor() {
        tokenImplementation = address(new ERC20PresetFixedSupplyUpgradeable());
    }


    function createTokenClone(string memory name, 
    string memory symbol,
    uint256 supply,
    address newOnwer) external onlyOwner returns (address) {
        address tokenClone = Clones.clone(tokenImplementation);
        ERC20PresetFixedSupplyUpgradeable(tokenClone).initialize(name, symbol, supply, newOnwer);
        tokenContracts.push(tokenClone);
        tokenCounter += 1;
        return tokenClone;

    }

    function getTokenAddress(uint256 _idx) external view returns (address) {
        return tokenContracts[_idx];
    }

    function getTokenCounter() external view returns (uint256) {
        return tokenCounter;
    }
}
