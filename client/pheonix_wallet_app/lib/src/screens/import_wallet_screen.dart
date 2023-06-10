import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:pheonix_wallet_app/src/constants.dart';
import 'package:pheonix_wallet_app/src/controllers/auth_controller.dart';
import '../components/component_home.dart';

class ImportWalletScreen extends StatelessWidget {
  ImportWalletScreen({Key? key}) : super(key: key);

  static const routeName = importWalletScreen;

  TextEditingController textEditingController = new TextEditingController();
  final AuthController authController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Obx(() {
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
                                      fontWeight: FontWeight.w700,
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
                            PrimaryButton(
                              buttonText: "Continue",
                              onPressed: () async {
                                await authController
                                    .importWallet(textEditingController.text);
                                // .importWallet(
                                //     "promote people van pencil december intact cement taste valid history onion fame");
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
            authController.loading.value
                ? Align(
                    alignment: Alignment.center,
                    child: LoadingAnimationWidget.staggeredDotsWave(
                      color: AppColors.mainBlue,
                      size: 70,
                    ),
                  )
                : Container(),
            authController.loading.value
                ? Container(
                    color: Colors.black26,
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height,
                  )
                : Container(),
          ],
        );
      }),
    );
  }
}
