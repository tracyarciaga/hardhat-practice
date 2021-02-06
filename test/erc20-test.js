const { expect } = require("chai");
const _name = "Loft Token";
const _symbol = "LOFT";
const _decimals = 18;

describe("Loft Token Attributes", function() {
  it("Should have the correct name", async function() {
    const LoftToken = await hre.ethers.getContractFactory("LoftToken");
    const loftToken = await LoftToken.deploy();
    await loftToken.deployed();
    expect(await loftToken.name()).to.equal(_name);

  });
  it("Should have the correct symbol", async function() {
    const LoftToken = await hre.ethers.getContractFactory("LoftToken");
    const loftToken = await LoftToken.deploy();
    await loftToken.deployed();
    expect(await loftToken.symbol()).to.equal(_symbol);
  });
  it("Should have the correct decimals", async function() {
    const LoftToken = await hre.ethers.getContractFactory("LoftToken");
    const loftToken = await LoftToken.deploy();
    await loftToken.deployed();
    expect(await loftToken.decimals()).to.equal(_decimals);
  });
  it("Should only have 100K supply", async function() {
    const LoftToken = await hre.ethers.getContractFactory("LoftToken");
    const loftToken = await LoftToken.deploy();
    await loftToken.deployed();
    expect(await loftToken.totalSupply()).to.equal(100000);
  });
});

