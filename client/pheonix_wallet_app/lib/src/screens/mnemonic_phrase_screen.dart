import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pheonix_wallet_app/src/constants.dart';
import 'package:pheonix_wallet_app/src/controllers/auth_controller.dart';
import '../components/component_home.dart';

class MnemonicPhraseScreen extends StatelessWidget {
  MnemonicPhraseScreen({Key? key}) : super(key: key);

  static const routeName = mnemonicPhraseScreen;

  final AuthController authController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Align(
          alignment: Alignment.topCenter,
          child: Image.asset(
            "assets/waves downside.png",
            fit: BoxFit.fitWidth,
            width: MediaQuery.of(context).size.width,
          ),
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    children: [
                      Stack(
                        alignment: AlignmentDirectional.center,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.white,
                            ),
                            width: 150,
                            height: 150,
                          ),
                          Image.asset(
                            "assets/Phoenix logo.png",
                            width: 101,
                            height: 106,
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Text(
                        "Welcome to Phoenix Wallet!",
                        style: GoogleFonts.inter(
                          textStyle: TextStyle(
                            color: AppColors.mainBlue,
                            fontSize: 24,
                            fontWeight: FontWeight.w800,
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                  // Wrap(
                  //   alignment: WrapAlignment.center,
                  //   runSpacing: 10,
                  //   spacing: 10,
                  //   children: authController.mnemonicPhrase.value
                  //       .split(" ")
                  //       .map((word) {
                  //     int index = authController.mnemonicPhrase.value
                  //         .split(" ")
                  //         .indexOf(word);
                  //     return Pill(
                  //       prefix: (index + 1).toString(),
                  //       label: word,
                  //       color: Color(0xFFff6666),
                  //     );
                  //   }).toList(),
                  // ),
                  TextFieldTwo(
                    isEditable: false,
                    labelText: "Mnemonic Phrase",
                    controller: TextEditingController(
                      text: authController.mnemonicPhrase.value,
                    ),
                    fontSize: 20,
                    fontWeight: FontWeight.normal,
                    fontColor: Colors.black,
                    fontTextAlign: TextAlign.center,
                    labelColor: AppColors.mainBlue,
                    labelSize: 11,
                    labelWeight: FontWeight.w600,
                    borderColor: AppColors.mainBlue,
                    contentPadding: EdgeInsets.only(
                      left: 20,
                      right: 20,
                      top: 40,
                      bottom: 40,
                    ),
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
        ),
      ],
    );
  }
}
