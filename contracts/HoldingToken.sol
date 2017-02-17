pragma solidity ^0.4.4;


import "StandardToken.sol";
import "Proxy.sol";
import "SafeSend.sol";
import "Board.sol";

contract HoldingToken is StandardToken {
  modifier released(address _sender) {
    if (now > holdUntil[_sender]) {
      _;
    } else {
      throw;
    }
  }

  modifier validPurchase() {
    var (position, weight) = board.voteOf(_negationProposalID, msg.sender);

    if ((address(token) == address(0) || (token.burned(msg.sender) > 0
        && msg.value <= token.burned(msg.sender)
        && balances[msg.sender] == 0))
      && (address(board) == address(0) || (position != _negationPosition || weight == 0))
      && (totalWhitelisted == 0 || whitelist[msg.sender] == true)) {
      _;
    } else { throw; }
  }

  function purchaseTokens() public validPurchase payable returns (uint256 amountPurchased) {
    if (msg.value < 1 ether) { throw; }
    amountPurchased = msg.value / 1 ether;

    if (amountPurchased + totalSupply > tokenCap
      || msg.value == 0
      || now > lastIssuance) {
      throw;
    }

    totalSupply += amountPurchased;
    totalIssued += amountPurchased;
    balances[msg.sender] += amountPurchased;

    if(!fund.send(this.balance)) {
      throw;
    }
  }

  function holdForVoting(uint256 _holdPeriod) public {
    holdUntil[msg.sender] = now + _holdPeriod;
  }

  function burnAndWithdrawETH() public returns (address balanceClaim) {
    uint256 balance = balances[msg.sender];
    if (balance <= 0) { throw; }
    uint256 etherWithdrawn = (fund.balance * balance) / totalSupply;
    burned[msg.sender] = etherWithdrawn;
    holdUntil[msg.sender] = 0;
    totalSupply -= balance;
    totalBurned += balance;
    burnBalance[msg.sender] = balance;
    balances[msg.sender] = 0;
    burnedAt[msg.sender] = now;

    address safeSend = address(new SafeSend(msg.sender));
    fund.forward_transaction(safeSend, etherWithdrawn, "");
  }

  function transfer(address _to, uint256 _value) public released(msg.sender) returns (bool) {
    return super.transfer(_to, _value);
  }

  function transferFrom(address _from, address _to, uint256 _value) public released(_from) returns (bool success) {
    return super.transferFrom(_from, _to, _value);
  }

  function approve(address _spender, uint256 _value) public released(msg.sender) returns (bool success) {
    return super.approve(_spender, _value);
  }

  function HoldingToken(address _fund,
    uint256 _tokenCap,
    uint256 _lastIssuance,
    address _token,
    address _negationBoard,
    uint256 _negationProposalID,
    uint256 _negationPosition,
    address[] _whitelist) public {
    lastIssuance = _lastIssuance;
    tokenCap = _tokenCap;
    fund = Proxy(_fund);
    board = Board(_negationBoard);
    token = HoldingToken(_token);
    negationProposal = _negationProposalID;
    negationPosition = _negationPosition;
    totalWhitelisted = _whitelist.length;

    for (uint256 i = 0; i <= uint256(_whitelist.length); i++) {
      whitelist[_whitelist[i]] = true;
    }
  }

  mapping(address => bool) public whitelist;
  mapping(address => uint256) public burnBalance;
  mapping(address => uint256) public burnedAt;
  mapping(address => uint256) public burned;
  mapping(address => uint256) public holdUntil;

  uint256 public totalWhitelisted;
  uint256 public totalIssued;
  uint256 public totalBurned;
  uint256 public tokenCap;
  uint256 public lastIssuance;
  uint256 public negationProposal;
  uint256 public negationPosition;
  Board public negationBoard;

  Proxy public fund;
}