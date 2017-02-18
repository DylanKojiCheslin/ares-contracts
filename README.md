<img src="http://ares.sh/assets/img/aresprotocol-black-transparent-cropped.png" width="300" />

<br />

## ares-protocol

The official Ethereum smart-contract implementaiton of the ARES protocol.

## About

In May 2016, a smart contract called “The DAO” was launched on the Ethereum blockchain.  The contract - a decentralized investment fund – was the first large-scale deployment of a decentralized application. It raised 11.5 million Ether, worth over $230 million US Dollars just prior to its collapse.  The ARES protocol aims to present an alternative implementation to the DAO that eliminates any game theoretic and mechanical attacks that would result in the loss of user funds for active users.

## Overview

The ARES protocol is implemented with the “Solidity” smart-contract programming language. It is composed of 4 contracts: (1) Fund, (2) Token, (3) Board and (4) Rules contracts.

### Fund.sol
This contract holds the Ether on behalf of all investors.  The Board contract is responsible for directing the Fund to pay out Ether to successful investment proposals.  The Token contract is responsible for directing the Fund to refund Ether to investors who wish to withdraw.

See: [Fund.sol](contracts/Fund.sol)

### HoldingToken.sol
This contract manages the creation of tokens when an investment is made into the Fund, and handles the destruction of tokens when a withdrawal is made from the Fund.  Each token allows the holder to cast a single vote on any proposal. Critically, the Token contract also ensures that tokens cannot change ownership during a vote on a proposal.  This ensures that a set of tokens can’t vote multiple times on a single proposal.

See: [HoldingToken.sol](contracts/HoldingToken.sol)

### BoardRoom.sol
This contract handles the creation, voting, and execution of investment proposals, as well as any proposals to change the Rules contract.  The Board contract defers to the Rules contract for all its conditions.

See: [BoardRoom.sol](contracts/BoardRoom.sol)

### ARESRules.sol
This contract defines all the conditions that are required for the actual operation of the DAO.  These conditions include the bond size, voting period, grace period, voting quorum, execution period, the interpreting of votes, among others.

See: [ARESRules.sol](contracts/ARESRules.sol)

For more details, see: [ARES Protocol White Paper](http://ares.sh/white-paper) for more details.

## Contributing

Please help better the ecosystem by submitting issues and pull requests to `ares-protocol`. We need all the help we can get to build the absolute best linting standards and utilities. We follow the AirBNB linting standard for JS and the unix philosophy for everything.

## Help out

There is always a lot of work to do, and will have many rules to maintain. So please help out in any way that you can:

- Create, enhance, and debug ares-protocol rules (see our guide to ["Working on rules"](./.github/CONTRIBUTING.md)).
- Improve documentation.
- Chime in on any open issue or pull request.
- Open new issues about your ideas for making `ares-protocol` better, and pull requests to show us how your idea works.
- Add new tests to *absolutely anything*.
- Create or contribute to ecosystem tools.
- Spread the word!

Please consult our [Code of Conduct](CODE_OF_CONDUCT.md) docs before helping out.

We communicate via [issues](https://github.com/ares-protocol/ares-protocol/issues) and [pull requests](https://github.com/ares-protocol/ares-protocol/pulls).

## Important documents

- [Changelog](CHANGELOG.md)
- [Code of Conduct](CODE_OF_CONDUCT.md)
- [License](https://raw.githubusercontent.com/ares-protocol/ares-protocol/master/LICENSE)

## Relationship to the DAO

ARES Protocol has no formal relation to the Slock.it DAO project. While we do reference "the DAO" in the ARES protocol white paper, we do not directly use any code from their repositories.

See: [ARES Protocol White Paper](http://ares.sh/white-paper) for more details.

## WARNING/DISCLAIMER

This code should not be deployed to Ethereum mainnet. It is still under heavy development and is highly experimental. Do not use or deploy this code to start another DAO or "the ARES DAO". Please read the license for more details.

## Licence

This project is licensed under the MIT license, Copyright (c) 2016 BoardRoom. For more information see LICENSE.md.

```
The MIT License

Copyright (c) 2016 BoardRoom.

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.
```
