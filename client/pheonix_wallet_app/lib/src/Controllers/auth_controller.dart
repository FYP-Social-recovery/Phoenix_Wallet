import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pheonix_wallet_app/src/constants.dart';
import 'package:bip39/bip39.dart' as bip39;
import 'package:web3dart/credentials.dart';
import 'package:web3dart/crypto.dart';
import 'dart:convert';
import 'package:convert/convert.dart';
import 'package:dart_bip32_bip44/dart_bip32_bip44.dart';

class AuthController extends GetxController {
  var splashScreenLoading = true.obs;
  var mnemonicPhrase = "".obs;
  var privateKey = "".obs;
  var publicKey = "".obs;
  var balance = 0.00.obs;
  var currency = "ETH".obs;
  var network = "Ethereum mainet".obs;

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
    String randomMnemonic = bip39.generateMnemonic();
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
    balance.value = 0.00;
    Get.toNamed(mnemonicPhraseScreen);
  }

  Future<void> recoverWallet(String phrase) async {
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
    balance.value = 0.00;
    Get.snackbar(
      "Recovery successful",
      "Successfully recovered the wallet.",
      colorText: Color(0xFFFF6D00),
    );
    await Future.delayed(const Duration(seconds: 2));
    Get.toNamed(homeScreen);
  }
}
