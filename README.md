# hardhat-practice

# Token Contract Behavior
- Pausable

# Crowdsale Contract Behavior
- Timed
- Stages: First, Second
- Access Control
- PostDeliveryCrowdsale: Crowdsale that locks tokens from withdrawal until it ends.
- AllowanceCrowdsale: Extension of Crowdsale where tokens are held by a wallet, which approves an allowance to the crowdsale.
- Extension of closing time
- Increasing rate price
- Pausable

# Notes
- Conclusion for separate deployments of crowdsale contracts or just one with defined stages

# OpenZeppelin Links Used 
https://docs.openzeppelin.com/contracts/2.x/
https://docs.openzeppelin.com/contracts/2.x/crowdsales
https://docs.openzeppelin.com/contracts/2.x/api/crowdsale