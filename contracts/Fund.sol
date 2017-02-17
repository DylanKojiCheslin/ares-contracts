pragma solidity ^0.4.4;


contract Fund {
  modifier onlyowners {
    if (msg.sender == token || msg.sender == owner) {
      _;
    } else {
      throw;
    }
  }

  /// @notice The contract fallback function
  function () public payable {}

  function transfer_ownership(address _owner) public onlyowners {
    owner = _owner;
  }

  function setToken(address _token) public onlyowners {
    token = _token;
  }

  function Fund() public {
    owner = msg.sender;
  }

  function forward_transaction(
    address _destination,
    uint _value,
    bytes _calldata)
    public
    onlyowners {
    if (!_destination.call.value(_value)(_calldata)) {
      throw;
    }
  }

  address public token;
  address public owner;
}