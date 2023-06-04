// route names
import 'package:flutter/material.dart';

const String sampleItemPage = '/sample_item';
const String settingsPage = '/settings';

const String splashScreen = '/';
const String mnemonicPhraseScreen = '/mnemonicPhraseScreen';
const String importWalletScreen = '/importWalletScreen';
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
const String recoveryMenuScreen = '/navigationScreen/menu/recovery';
const String recoveryRequestsScreen =
    '/navigationScreen/menu/recovery/recoveryRequestsScreen';
const String recoveryRequestScreen1 =
    '/navigationScreen/menu/recovery/recoveryRequestScreen1';
const String recoveryRequestScreen2 =
    '/navigationScreen/menu/recovery/recoveryRequestScreen2';
const String recoveryScreen1 =
    '/navigationScreen/menu/recovery/recoveryScreen1';
const String recoveryScreen2 =
    '/navigationScreen/menu/recovery/recoveryScreen2';
const String recoveryScreen3 =
    '/navigationScreen/menu/recovery/recoveryScreen3';

const List<String> networkTypes = ["Mainnet", "Testnet"];
const List<String> networkLayers = ["L1", "L2"];
const List<Map<String, dynamic>> networks = [
  {
    "Name": "Ethereum",
    "Mainnet": {
      "L1": {
        "Name": "Ethereum",
        "ChainId": 1,
        "RpcUrl": "https://mainnet.infura.io/v3/",
        "Currency": "ETH",
        "FullName": "Ethereum Mainnet",
        "ExplorerURL": "https://etherscan.io",
      },
      "L2": {
        "Name": "Arbitrum",
        "ChainId": 42161,
        "RpcUrl": "https://arbitrum-mainnet.infura.io",
        "Currency": "ETH",
        "FullName": "Arbitrum One",
        "ExplorerURL": "https://explorer.arbitrum.io",
      },
    },
    "Testnet": {
      "L1": {
        "Name": "Ethereum",
        "ChainId": 5,
        "RpcUrl":
            "https://eth-goerli.g.alchemy.com/v2/8L-St1WDAiIktazEqEolQfntGghuPR94",
        "Currency": "Eth",
        "FullName": "Goerli",
        "ExplorerURL": "https://goerli.etherscan.io",
      },
      "L2": {
        "Name": "Arbitrum",
        "ChainId": 421613,
        "RpcUrl":
            "https://arb-goerli.g.alchemy.com/v2/kmaQkTzL0jVfzpP6t9J1R04Y0hr9GGJE",
        "Currency": "AGOR",
        "FullName": "Arbitrum Goerli",
        "ExplorerURL": "https://goerli-rollup-explorer.arbitrum.io",
      },
    },
  },
];

class AppColors {
  static Color mainBlue = Color(0xFF115DA9);
  static Color mainBlueLight = Color(0xFFCCE5FF);
  static Color mainRed = Color(0xFFA91111);
  static Color backgroundRed = Color(0xFFF5F5F5);
  static Color boxText = Color(0xFFADA2C3);
  static Color boxTextPink = Color(0xFFFCDDEC);
  static Color mainGreen = Color(0xFF61FF00);
  static Color mainYellow = Color(0xFFFE9800);
}

class ApiConstants {
  static String baseUrl = 'https://jsonplaceholder.typicode.com';
  static String usersEndpoint = '/users';
}
