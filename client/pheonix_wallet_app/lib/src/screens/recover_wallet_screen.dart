import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
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
                              "Welcome Back!",
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
                        TextFieldTwo(
                          labelText: "Mnemonic Phrase",
                          controller: textEditingController,
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
                          onPressed: () async {
                            await authController
                                .recoverWallet(textEditingController.text);
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
    );
  }
}
