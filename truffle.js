const HDWalletProvider = require("truffle-hdwallet-provider");

// Allows us to use ES6 in our migrations and tests.
require('babel-register')

// Edit truffle.config file should have settings to deploy the contract to the Rinkeby Public Network.
// Infura should be used in the truffle.config file for deployment to Rinkeby.

module.exports = {
  networks: {
    development: {
      host: "127.0.0.1",     // Localhost (default: none)
      port: 7545,            // Standard Ethereum port (default: none)
      network_id: "*",       // Any network (default: none)
    },

    rinkeby: {
      provider: function() {
        return new HDWalletProvider(
          "cover general conduct soccer veteran mechanic layer fiscal limb fever deposit leader",
          "https://ropsten.infura.io/v3/219885d3695c4c369ce8c85d5280c38b"
        )
      },
      network_id: '4',
      gas: 4500000,
      gasPrice: 10000000000,
    }





  }
}
