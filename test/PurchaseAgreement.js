const { expect } = require("chai");

describe("Token contract", function () {
  let Token;
  let erc20Token;
  let seller;
  let buyer;
  let value;

  beforeEach(async function () {
    Token = await ethers.getContractFactory("PurchaseAgreement");
    [seller, buyer, ...addrs] = await ethers.getSigners();
    erc20Token = await Token.deploy();
  });

  describe("Deployment", function () {
    it("Should set the seller as owner", async function () {
      expect(await erc20Token.seller()).to.equal(seller.address);
    });

    // it("Should assign the total supply of tokens to the owner", async function () {
    //   const sellerVal = await erc20Token.balanceOf(seller.address);
    //   expect(await erc20Token.value()).to.equal(sellerVal*2);
    // });
  });

//   describe("Transactions", function () {
//     it("")
//   });

});