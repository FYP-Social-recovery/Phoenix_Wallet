import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pheonix_wallet_app/src/constants.dart';
import 'package:pheonix_wallet_app/src/controllers/auth_controller.dart';
import '../components/component_home.dart';

class RecoverWalletScreen extends StatelessWidget {
  RecoverWalletScreen({Key? key}) : super(key: key);

  static const routeName = recoverWalletScreen;

  TextEditingController textEditingController = new TextEditingController();
  final AuthController authController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text(
                "Recover Wallet",
                style: TextStyle(
                  color: Color(0xFFFF6D00),
                  fontSize: 25,
                  fontWeight: FontWeight.w600,
                ),
              ),
              TextFieldTwo(
                controller: textEditingController,
                labelText: "Mnemonic Phrase",
              ),
              PrimaryButton(
                buttonText: "Continue",
                onPressed: () async {
                  await authController
                      .recoverWallet(textEditingController.text);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
