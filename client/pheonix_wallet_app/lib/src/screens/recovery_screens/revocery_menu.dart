import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pheonix_wallet_app/src/constants.dart';
import 'package:pheonix_wallet_app/src/controllers/auth_controller.dart';
import 'package:pheonix_wallet_app/src/controllers/controller_home.dart';
import '../../components/component_home.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:pheonix_wallet_app/src/apis/api_home.dart';

class RecoveryMenuScreen extends StatelessWidget {
  RecoveryMenuScreen({Key? key}) : super(key: key);

  static const routeName = recoveryMenuScreen;

  final WalletController walletController = Get.find();
  final AuthController authController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.mainBlue,
      body: SafeArea(
        child: Obx(() {
          return Stack(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Spacer(flex: 1),
                      RecoveryMenuButton(
                        image: "assets/recovery key image.png",
                        label: "Initiate recovery",
                        onTap: () {
                          Get.toNamed(recoveryRequestScreen1);
                        },
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      RecoveryMenuButton(
                        image: "assets/recovery request image.png",
                        label: "Recovery Requests",
                        onTap: () async {
                          walletController.loading.value = true;

                          dynamic result = await Api.checkRequestsForShare(
                            authController.publicKey.value,
                            authController.privateKey.value,
                            walletController.nodeContractAddress.value,
                          );

                          if (result.length != 0) {
                            walletController.shareRecoveryRequests.value =
                                result;
                            // Get.snackbar(
                            //   "Successful!",
                            //   "Successfully send the OTP.",
                            //   colorText: AppColors.mainBlue,
                            // );
                            Get.toNamed(recoveryRequestsScreen);
                          } else {
                            Get.snackbar(
                              "Failed!",
                              "Something is wrong. Please try again.",
                              colorText: AppColors.mainRed,
                            );
                          }

                          walletController.loading.value = false;
                        },
                      ),
                      SizedBox(
                        height: 40,
                      ),
                      Container(
                        width: 190,
                        child: Divider(
                          color: Colors.white,
                          height: 2,
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      RecoveryMenuButton(
                        image: "assets/Wallet.png",
                        label: "Recover Wallet",
                        onTap: () {
                          Get.toNamed(recoveryScreen1);
                        },
                      ),
                      Spacer(flex: 1),
                      PrimaryButton(
                        buttonText: "Back",
                        onPressed: () {
                          Get.back();
                        },
                        color: Color(0xFF007CFF).withOpacity(0.5),
                      ),
                      Spacer(flex: 1),
                    ],
                  ),
                ),
              ),
              walletController.loading.value
                  ? Align(
                      alignment: Alignment.center,
                      child: LoadingAnimationWidget.staggeredDotsWave(
                        color: AppColors.mainBlue,
                        size: 70,
                      ),
                    )
                  : Container(),
              walletController.loading.value
                  ? Container(
                      color: Colors.black26,
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height,
                    )
                  : Container(),
            ],
          );
        }),
      ),
    );
  }
}

class RecoveryMenuButton extends StatelessWidget {
  const RecoveryMenuButton({
    super.key,
    required this.onTap,
    required this.image,
    required this.label,
    this.size = 74,
    this.shape = BoxShape.rectangle,
  });

  final Function()? onTap;
  final String image;
  final String label;
  final double size;
  final BoxShape shape;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
            child: Image.asset(
              image,
              width: size,
              height: size,
              fit: BoxFit.fill,
            ),
          ),
          SizedBox(
            height: 15,
          ),
          Text(
            label,
            style: GoogleFonts.inter(
              textStyle: TextStyle(
                color: AppColors.boxTextPink,
                fontSize: 16,
                fontWeight: FontWeight.normal,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
