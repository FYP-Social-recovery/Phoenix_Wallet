import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart';
import 'package:pheonix_wallet_app/src/apis/api.dart';
import 'package:pheonix_wallet_app/src/constants.dart';
import 'package:bip39/bip39.dart' as bip39;
import 'package:pheonix_wallet_app/src/services/nodeService.dart';
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
  var entrophy = "".obs;

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

    await Future.delayed(const Duration(seconds: 1));
    privateKey.value = "";
    publicKey.value = "";
    mnemonicPhrase.value = "";
    entrophy.value = "";

    WalletController walletController = Get.find();
    walletController.registered.value = false;
    walletController.nodeContractAddress.value = "";
    walletController.username.value = "";
    walletController.email.value = "";

    walletController.beShareholderRequests.value = [""];
    walletController.shareholderRequestStatus.value = [];
    walletController.shareRecoveryRequests.value = [""];

    walletController.usernameExists.value = false;

    walletController.otpHash.value = "";
    walletController.otp.value = "";
    walletController.generatedSigendOTP.value = "";

    try {
      String randomMnemonic = await Api.generateMnemonicForNewAccount();
      print(randomMnemonic);
      List<String> keyList = await Api.importWalletFromMnemonic(randomMnemonic);

      mnemonicPhrase.value = randomMnemonic;
      publicKey.value = keyList[1];
      privateKey.value = keyList[0];

      entrophy.value = await Api.mnemonicToEntropy(randomMnemonic);

      WalletController walletController = Get.find();
      await walletController.getBalance();
    } catch (e) {
      Get.snackbar(
        "Wallet Creation Failed!",
        "Something is wrong. Please try again.",
        colorText: AppColors.mainRed,
        backgroundColor: Colors.white70,
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
        backgroundColor: Colors.white70,
      );

      loading.value = false;
      return;
    } else {
      Get.snackbar(
        "Wallet Creation Successful!",
        "Successfully created the wallet.",
        colorText: AppColors.mainBlue,
        backgroundColor: Colors.white70,
      );

      Get.toNamed(mnemonicPhraseScreen);
      loading.value = false;
    }
  }

  Future<void> importWallet(String phrase) async {
    loading.value = true;

    await Future.delayed(const Duration(seconds: 1));
    privateKey.value = "";
    publicKey.value = "";
    mnemonicPhrase.value = "";
    entrophy.value = "";

    WalletController walletController = Get.find();
    walletController.registered.value = false;
    walletController.nodeContractAddress.value = "";
    walletController.username.value = "";
    walletController.email.value = "";

    walletController.beShareholderRequests.value = [""];
    walletController.shareholderRequestStatus.value = [];
    walletController.shareRecoveryRequests.value = [""];

    walletController.usernameExists.value = false;

    walletController.otpHash.value = "";
    walletController.otp.value = "";
    walletController.generatedSigendOTP.value = "";

    if (phrase.split(" ").length != 12) {
      Get.snackbar(
        "Wallet Import Failed!",
        "Enter a valid phrase with 12 words.",
        colorText: AppColors.mainRed,
        backgroundColor: Colors.white70,
      );

      loading.value = false;
      return;
    }

    try {
      List<String> keyList = await Api.importWalletFromMnemonic(phrase);

      mnemonicPhrase.value = phrase;
      publicKey.value = keyList[1];
      privateKey.value = keyList[0];

      entrophy.value = await Api.mnemonicToEntropy(phrase);

      WalletController walletController = Get.find();
      await walletController.getBalance();
      String contract = await Api.getContractAddressByPublicAddress(
          publicKey.value, privateKey.value);
      if (contract != '0x0000000000000000000000000000000000000000') {
        String username =
            await Api.getUserName(publicKey.value, privateKey.value, contract);
        walletController.nodeContractAddress.value = contract;
        walletController.username.value = username;
        walletController.registered.value = true;
      }
    } catch (e) {
      Get.snackbar(
        "Wallet Import Failed!",
        "Something is wrong. Please try again.",
        colorText: AppColors.mainRed,
        backgroundColor: Colors.white70,
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
        backgroundColor: Colors.white70,
      );

      loading.value = false;
      return;
    } else {
      Get.snackbar(
        "Wallet Import successful!",
        "Successfully imported the wallet.",
        colorText: AppColors.mainBlue,
        backgroundColor: Colors.white70,
      );

      Get.toNamed(navigationScreen);
      loading.value = false;
    }
  }
}
