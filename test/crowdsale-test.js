const { expect } = require("chai");
const _name = "Loft Token";
const _symbol = "LOFT";
const _decimals = 18;
const _rate = 1000; //how many tokens for 1 Ether


const duration = {
  seconds: function (val) { return val; },
  minutes: function (val) { return val * this.seconds(60); },
  hours: function (val) { return val * this.minutes(60); },
  days: function (val) { return val * this.hours(24); },
  weeks: function (val) { return val * this.days(7); },
  years: function (val) { return val * this.days(365); },
};

describe("Loft Token Crowdsale", function() { 
  it("Should track rate, wallet and token", async function() {
    const LoftToken = await hre.ethers.getContractFactory("LoftToken");
    const loftToken = await LoftToken.deploy();
    const _token = await loftToken.deployed();
    // const [owner] = await ethers.getSigners();
    const _wallet = hre.ethers.Wallet.createRandom();
    console.log(_wallet);
    
    const providers = hre.ethers.providers;
    const provider = new providers.JsonRpcProvider('http://localhost:8545');
    const latestBlockStamp = await provider.getBlock('latest');
    console.log(latestBlockStamp.timestamp);

    this.openingTime = latestBlockStamp + duration.weeks(1);
    this.closingTime = this.openingTime + duration.weeks(1);
    console.log(this.openingTime);
    console.log(this.closingTime);

    const Crowdsale = await hre.ethers.getContractFactory("LoftTokenCrowdsale");
    const crowdsale = await Crowdsale.deploy(_rate, _wallet.address, _token.address, this.openingTime, this.closingTime);
    await crowdsale.deployed();
    const token = await crowdsale.token();
    console.log(token);
    console.log(_token.address);
    expect(token).to.equal(_token.address);
    expect(await crowdsale.rate()).to.equal(_rate);
    expect(await crowdsale.wallet()).to.equal(_wallet.address);
  });
});
