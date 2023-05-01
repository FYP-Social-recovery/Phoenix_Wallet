import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pheonix_wallet_app/src/constants.dart';

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

  void createWallet() {
    mnemonicPhrase.value =
        "drill gain then core flag width short avoid worth battle multiply three";
    publicKey.value = "0x050Ca8FBaA785B6C71dF11b855edda7EEFFAB32B";
    privateKey.value =
        "b970ae74ea4a0b976bec7ac3c80384965b7ab67c3808252b0ac8e84517bee417";
    balance.value = 0.00;
    Get.toNamed(mnemonicPhraseScreen);
  }

  Future<void> recoverWallet(String phrase) async {
    mnemonicPhrase.value =
        "drill gain then core flag width short avoid worth battle multiply three";
    publicKey.value = "0x050Ca8FBaA785B6C71dF11b855edda7EEFFAB32B";
    privateKey.value =
        "b970ae74ea4a0b976bec7ac3c80384965b7ab67c3808252b0ac8e84517bee417";
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
