// route names
const String sampleItemPage = '/sample_item';
const String settingsPage = '/settings';

const String splashScreen = '/';
const String mnemonicPhraseScreen = '/mnemonicPhraseScreen';
const String recoverWalletScreen = '/recoverWalletScreen';
const String navigationScreen = '/navigationScreen';
const String registrationScreen = '/navigationScreen/menu/registrationScreen';
const String addShareholdersScreen =
    '/navigationScreen/menu/distribution/addShareholdersScreen';
const String shareHolderRequestsScreen =
    '/navigationScreen/menu/distribution/shareHolderRequestsScreen';
const String shareHolderStatusScreen =
    '/navigationScreen/menu/distribution/shareHolderStatusScreen';
const String distributeSharesScreen1 =
    '/navigationScreen/menu/distribution/distributeSharesScreen1';
const String distributeSharesScreen2 =
    '/navigationScreen/menu/distribution/distributeSharesScreen2';
const String distributeSharesScreen3 =
    '/navigationScreen/menu/distribution/distributeSharesScreen3';

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
