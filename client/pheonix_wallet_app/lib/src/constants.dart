// route names
const String sampleItemPage = '/sample_item';
const String settingsPage = '/settings';

const String splashScreen = '/';
const String mnemonicPhraseScreen = '/mnemonicPhraseScreen';
const String recoverWalletScreen = '/recoverWalletScreen';
const String navigationScreen = '/navigationScreen';

const List<Map<String, dynamic>> networks = [
  {
    "Name": "Ethereum",
    "Mainnet": {
      "L1": {
        "Name": "Ethereum",
        "ChainId": 1,
        "RpcUrl": "abc.com",
        "FullName": "Ethereum Mainnet",
      },
      "L2": {
        "Name": "Arbitrum",
        "ChainId": 1,
        "RpcUrl": "abc.com",
        "FullName": "Arbitrum Mainnet",
      },
    },
    "Testnet": {
      "L1": {
        "Name": "Georli",
        "ChainId": 1,
        "RpcUrl": "abc.com",
        "FullName": "Ethereum Testnet",
      },
      "L2": {
        "Name": "Arbitrum Georli",
        "ChainId": 1,
        "RpcUrl": "abc.com",
        "FullName": "Arbitrum Testnet",
      },
    },
  },
];
