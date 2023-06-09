import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
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
                  children: [
                    Align(
                      alignment: Alignment.topLeft,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: Container(
                          alignment: Alignment.center,
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            color: Colors.black.withOpacity(0.1),
                            shape: BoxShape.circle,
                            boxShadow: <BoxShadow>[
                              BoxShadow(
                                color: Colors.black.withOpacity(0.7),
                                blurRadius: 1,
                                blurStyle: BlurStyle.outer,
                                offset: Offset(2, 2),
                                spreadRadius: 0,
                              ),
                            ],
                          ),
                          child: IconButton(
                            onPressed: () {
                              Get.back();
                            },
                            icon: Icon(
                              Icons.arrow_back_ios_new_rounded,
                              color: AppColors.mainBlue,
                              size: 25,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
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
                                    fontWeight: FontWeight.w700,
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
                          Stack(
                            alignment: Alignment.bottomCenter,
                            children: [
                              TextFieldTwo(
                                isEditable: false,
                                labelText: "Mnemonic Phrase",
                                controller: TextEditingController(
                                  text: authController.mnemonicPhrase.value,
                                ),
                                fontSize: 20,
                                fontWeight: FontWeight.normal,
                                fontColor: AppColors.mainBlue,
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
                              Align(
                                alignment: Alignment.bottomRight,
                                child: IconButton(
                                  splashRadius: 20,
                                  tooltip: "Copy to clipboard",
                                  onPressed: () async {
                                    await Clipboard.setData(ClipboardData(
                                        text: authController
                                            .mnemonicPhrase.value));
                                  },
                                  icon: Icon(
                                    Icons.copy,
                                    color: AppColors.mainBlue,
                                    size: 15,
                                  ),
                                ),
                              ),
                            ],
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
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
