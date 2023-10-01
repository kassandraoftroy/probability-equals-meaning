// SPDX-License-Identifier: MIT
pragma solidity 0.8.20;

contract ProbabilityEqualsMeaning {
    error OnlyOwner();
    error TextUnset();
    string public constant metadata = "paper.tex.gz";
    bytes[] public text;
    uint256 public textNumPieces;
    address public immutable owner;

    constructor() {
        owner = msg.sender;
    }

    function setText(bytes calldata text_) external {
        if (msg.sender != owner) revert OnlyOwner();
        text.push(text_);
        textNumPieces += 1;
    }

    function getText() external view returns (bytes memory) {
        uint256 len = text.length;
        if (len == 0) revert TextUnset();
        bytes memory x = text[0];
        for (uint256 i = 1; i < len; i++) {
            x = bytes.concat(x, text[i]);
        }

        return x;
    }
}
