import { HardhatUserConfig } from "hardhat/config";
import "@nomicfoundation/hardhat-toolbox";
import "dotenv/config";

const SEPOLIA_RPC_URL = process.env.SEPOLIA_PROCESS_ENV || "";
const PRIVATE_KEY = process.env.PRIVATE_KEY || "0xKEY";
const ETHERSCAN_API_KEY = process.env.ETHERSCAN_API_KEY || "ApiKey";
const COINMARKETCAP_API_KEY = process.env.COINMARKETCAP_API_KEY || "ApiKey";

const config: HardhatUserConfig = {
  solidity: "0.8.20",
  defaultNetwork: "hardhat",
  networks: {
    hardhat: {
      chainId: 31337,
      // blockConfirmations: 1
    },
    sepolia: {
      chainId: 11155111,
      url: SEPOLIA_RPC_URL,
      accounts: [PRIVATE_KEY],
      // blockConfirmations: 1,
    },
  },
  etherscan: {
    apiKey: ETHERSCAN_API_KEY,
  },
  gasReporter: {
    // put it enabled: true -> only when you want to check gas optimizations
    enabled: false,
    noColors: true,
    outputFile: "gas-report.txt",
    currency: "USD",
    coinmarketcap: COINMARKETCAP_API_KEY,
    // token: "MATIC", // polygon network
  },
  mocha: {
    timeout: 200000, //200 seconds
  },
};

export default config;
