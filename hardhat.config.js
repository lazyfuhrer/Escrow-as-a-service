require('dotenv').config();
require("@nomiclabs/hardhat-waffle");

const {API_URL, PRIVATE_KEY} = process.env;

module.exports = {
  solidity: "0.8.17",
  networks: {
    polygon_mumbai: {
      url: API_URL,
      accounts: [`0x${PRIVATE_KEY}`]
    }
  },
}