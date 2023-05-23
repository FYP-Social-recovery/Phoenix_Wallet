import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart';
import 'package:pheonix_wallet_app/src/constants.dart';
import 'package:bip39/bip39.dart' as bip39;
import 'package:pheonix_wallet_app/src/controllers/nodeService.dart';
import 'package:web3dart/credentials.dart';
import 'package:web3dart/crypto.dart';
import 'dart:convert';
import 'package:convert/convert.dart';
import 'package:dart_bip32_bip44/dart_bip32_bip44.dart';
import 'package:web3dart/web3dart.dart';

import 'controller_home.dart';

class AuthController extends GetxController {
  var splashScreenLoading = true.obs;

  //Wallet credentials
  var mnemonicPhrase = "".obs;
  var privateKey = "".obs;
  var publicKey = "".obs;

  var selectedIndex = 1.obs;

  var loading = false.obs;

  @override
  Future<void> onInit() async {
    super.onInit();
    await initApp();
  }

  Future<void> initApp() async {
    await Future.delayed(const Duration(seconds: 2));

    splashScreenLoading.value = false;
  }

  Future<void> createWallet() async {
    loading.value = true;

    await Future.delayed(const Duration(seconds: 2));
    privateKey.value = "";

    try {
      String randomMnemonic =
          "promote people van pencil december intact cement taste valid history onion fame"; //bip39.generateMnemonic();
      print(randomMnemonic);
      String seed = bip39.mnemonicToSeedHex(randomMnemonic);
      Chain chain = Chain.seed(seed);
      ExtendedKey extendedKey = chain.forPath("m/44'/60'/0'/0/0");
      String privateKeyTemp = extendedKey.privateKeyHex().substring(2);
      Credentials credentials =
          EthPrivateKey.fromHex(extendedKey.privateKeyHex());
      var publicKeyTemp = await credentials.extractAddress();

      mnemonicPhrase.value = randomMnemonic;
      publicKey.value = publicKeyTemp.toString();
      privateKey.value = privateKeyTemp;

      WalletController walletController = Get.find();
      await walletController.getBalance();
    } catch (e) {
      Get.snackbar(
        "Wallet Creation Failed!",
        "Something is wrong. Please try again.",
        colorText: AppColors.mainRed,
      );
      print(e);
      loading.value = false;
      return;
    }

    if (privateKey.value == "") {
      Get.snackbar(
        "Wallet Creation Failed!",
        "Something is wrong. Please try again.",
        colorText: AppColors.mainRed,
      );

      loading.value = false;
      return;
    } else {
      Get.snackbar(
        "Wallet Creation Successful",
        "Successfully created the wallet.",
        colorText: AppColors.mainBlue,
      );

      Get.toNamed(mnemonicPhraseScreen);
      loading.value = false;
    }
  }

  Future<void> importWallet(String phrase) async {
    loading.value = true;

    await Future.delayed(const Duration(seconds: 2));
    privateKey.value = "";

    if (phrase.split(" ").length != 12) {
      Get.snackbar(
        "Wallet Import Failed!",
        "Enter a valid phrase with 12 words.",
        colorText: AppColors.mainRed,
      );

      loading.value = false;
      return;
    }

    try {
      mnemonicPhrase.value = phrase;
      String seed = bip39.mnemonicToSeedHex(phrase);
      Chain chain = Chain.seed(seed);
      ExtendedKey extendedKey = chain.forPath("m/44'/60'/0'/0/0");
      String privateKeyTemp = extendedKey.privateKeyHex().substring(2);
      Credentials credentials =
          EthPrivateKey.fromHex(extendedKey.privateKeyHex());
      var publicKeyTemp = await credentials.extractAddress();

      publicKey.value = publicKeyTemp.toString();
      privateKey.value = privateKeyTemp;

      WalletController walletController = Get.find();
      await walletController.getBalance();
    } catch (e) {
      Get.snackbar(
        "Wallet Import Failed!",
        "Something is wrong. Please try again.",
        colorText: AppColors.mainRed,
      );
      print(e);
      loading.value = false;
      return;
    }

    if (privateKey.value == "") {
      Get.snackbar(
        "Wallet Import Failed!",
        "Something is wrong. Please try again.",
        colorText: AppColors.mainRed,
      );

      loading.value = false;
      return;
    } else {
      Get.snackbar(
        "Wallet Import successful",
        "Successfully imported the wallet.",
        colorText: AppColors.mainBlue,
      );

      Get.toNamed(navigationScreen);
      loading.value = false;
    }
  }
}
