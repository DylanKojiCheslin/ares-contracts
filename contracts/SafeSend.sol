pragma solidity ^0.4.4;


contract SafeSend {
  function SafeSend(address _recipient) {
    recipient = _recipient;
  }

  function () payable {
    selfdestruct(recipient);
  }

  address public recipient;
}
