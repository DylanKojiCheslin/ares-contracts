pragma solidity ^0.4.4;


contract SafeSend {
  function () payable {
    selfdestruct(recipient);
  }

  function SafeSend(address _recipient) {
    recipient = _recipient;
  }

  address public recipient;
}
