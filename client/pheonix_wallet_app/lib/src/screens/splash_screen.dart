import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:pheonix_wallet_app/src/constants.dart';
import 'package:pheonix_wallet_app/src/controllers/auth_controller.dart';
import '../components/component_home.dart';

class SplashScreen extends StatelessWidget {
  SplashScreen({Key? key}) : super(key: key);

  static const routeName = splashScreen;

  final AuthController authController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Align(
            alignment: Alignment.bottomCenter,
            child: Image.asset(
              "assets/waves upside.png",
              fit: BoxFit.fitWidth,
              width: MediaQuery.of(context).size.width,
            ),
          ),
          Scaffold(
            backgroundColor: Colors.transparent,
            body: SafeArea(
              child: GestureDetector(
                onTap: () {
                  FocusScope.of(context).unfocus();
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Spacer(
                          flex: 2,
                        ),
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
                                  width: 122,
                                  height: 120,
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Text(
                              "Phoenix Wallet",
                              style: GoogleFonts.inter(
                                textStyle: TextStyle(
                                  color: AppColors.mainBlue,
                                  fontSize: 24,
                                  fontWeight: FontWeight.w800,
                                  fontStyle: FontStyle.italic,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Spacer(
                          flex: 2,
                        ),
                        Obx(
                          () => authController.splashScreenLoading.value
                              ? LoadingAnimationWidget.staggeredDotsWave(
                                  color: AppColors.mainBlue,
                                  size: 70,
                                )
                              : authController.loading.value
                                  ? LoadingAnimationWidget.staggeredDotsWave(
                                      color: AppColors.mainBlue,
                                      size: 70,
                                    )
                                  : Column(
                                      children: [
                                        PrimaryButton(
                                          buttonText: "Create Wallet",
                                          onPressed: () async {
                                            authController.loading.value = true;

                                            await authController.createWallet();

                                            authController.loading.value =
                                                false;
                                          },
                                          color: AppColors.mainBlue,
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        OutlineButton(
                                          buttonText: "Import Wallet",
                                          onPressed: () {
                                            Get.toNamed(importWalletScreen);
                                          },
                                          color: AppColors.mainBlue,
                                        ),
                                      ],
                                    ),
                        ),
                        Spacer(
                          flex: 1,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
