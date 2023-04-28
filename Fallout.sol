// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

interface Fallout {
    // We created an interface to call just the method of a funcion "Fal 1 out" in this case
    // It's looks like the constructor, but it is not!
    // The function in this case should be external and not public
    function Fal1out() external payable;
}
