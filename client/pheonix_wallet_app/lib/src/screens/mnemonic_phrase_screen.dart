import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pheonix_wallet_app/src/constants.dart';
import 'package:pheonix_wallet_app/src/controllers/auth_controller.dart';
import '../components/component_home.dart';

class MnemonicPhraseScreen extends StatelessWidget {
  MnemonicPhraseScreen({Key? key}) : super(key: key);

  static const routeName = mnemonicPhraseScreen;

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
                "Mnemonic Phrase",
                style: TextStyle(
                  color: Color(0xFFFF6D00),
                  fontSize: 25,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Wrap(
                alignment: WrapAlignment.center,
                runSpacing: 10,
                spacing: 10,
                children:
                    authController.mnemonicPhrase.value.split(" ").map((word) {
                  int index = authController.mnemonicPhrase.value
                      .split(" ")
                      .indexOf(word);
                  return Pill(
                    prefix: (index + 1).toString(),
                    label: word,
                    color: Color(0xFFff6666),
                  );
                }).toList(),
              ),
              PrimaryButton(
                buttonText: "Continue",
                onPressed: () {
                  Get.toNamed(navigationScreen);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
