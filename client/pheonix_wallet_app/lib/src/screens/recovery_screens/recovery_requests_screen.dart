import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pheonix_wallet_app/src/constants.dart';
import 'package:pheonix_wallet_app/src/controllers/auth_controller.dart';
import 'package:pheonix_wallet_app/src/controllers/controller_home.dart';
import '../../components/component_home.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:pheonix_wallet_app/src/apis/api_home.dart';

class RecoveryRequestsScreen extends StatelessWidget {
  RecoveryRequestsScreen({Key? key}) : super(key: key);

  static const routeName = recoveryRequestsScreen;

  final WalletController walletController = Get.find();
  final AuthController authController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Obx(() {
          return Stack(
            children: [
              Align(
                alignment: Alignment.topCenter,
                child: Image.asset(
                  "assets/waves downside small.png",
                  fit: BoxFit.fitWidth,
                  width: MediaQuery.of(context).size.width,
                ),
              ),
              GestureDetector(
                onTap: () {
                  FocusScope.of(context).unfocus();
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 20,
                        left: 15,
                        right: 15,
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            alignment: Alignment.center,
                            width: 30,
                            height: 30,
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
                                size: 15,
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            "Phoenix Wallet",
                            style: GoogleFonts.inter(
                              textStyle: TextStyle(
                                color: Colors.white,
                                fontSize: 24,
                                fontWeight: FontWeight.w700,
                                fontStyle: FontStyle.italic,
                              ),
                            ),
                            textAlign: TextAlign.start,
                          ),
                          Spacer(),
                          Container(
                            width: 30,
                            height: 30,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.circle,
                            ),
                            child: Image.asset(
                              "assets/Phoenix logo mini circular.png",
                              width: 40,
                              height: 40,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.width * 0.25,
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: Padding(
                        padding: const EdgeInsets.only(right: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(right: 50),
                              child: Image.asset(
                                "assets/recovery request red image.png",
                                width: 100,
                                // height: 130,
                              ),
                            ),
                            Align(
                              alignment: Alignment.centerRight,
                              child: Text(
                                "Recovery Requests",
                                style: GoogleFonts.inter(
                                  textStyle: TextStyle(
                                    color: AppColors.mainBlue,
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: ListView.separated(
                        shrinkWrap: true,
                        itemBuilder: (BuildContext, int) {
                          return RequestBox(
                            title: walletController.shareRecoveryRequests[int],
                            subTitle: "Unknown",
                            icon: Icons.check_rounded,
                            color: AppColors.mainGreen,
                            iconColor: AppColors.mainBlue,
                            onPressed: () async {
                              walletController.loading.value = true;

                              await Future.delayed(Duration(seconds: 2));

                              dynamic result = 1;
                              // await Api.releaseShare(
                              //     authController.publicKey.value,
                              //     authController.privateKey.value,
                              //     walletController.nodeContractAddress.value,
                              //     walletController
                              //         .shareRecoveryRequests.value[int]);

                              if (result != 0) {
                                walletController.shareRecoveryRequests.value
                                    .removeWhere((element) =>
                                        element ==
                                        walletController
                                            .shareRecoveryRequests.value[int]);
                                Get.snackbar(
                                  "Successful",
                                  "Successfully accepted the share recovery request.",
                                  colorText: AppColors.mainBlue,
                                  backgroundColor: Colors.white70,
                                );
                              } else {
                                Get.snackbar(
                                  "Failed!",
                                  "Something is wrong. Please try again.",
                                  colorText: AppColors.mainRed,
                                  backgroundColor: Colors.white70,
                                );
                              }

                              walletController.loading.value = false;
                            },
                          );
                          // RequestBox(
                          //   title: "0xfffg2f23d234fg233gf345gf34",
                          //   subTitle: "Unknown",
                          //   icon: Icons.close_rounded,
                          //   color: AppColors.mainYellow,
                          //   iconColor: AppColors.mainBlue,
                          //   onPressed: () {},
                          // )
                        },
                        separatorBuilder: (BuildContext, int) {
                          return SizedBox(
                            height: 15,
                          );
                        },
                        itemCount:
                            walletController.shareRecoveryRequests.length,
                      ),
                    ),
                    Spacer(
                      flex: 2,
                    ),
                  ],
                ),
              ),
              walletController.loading.value
                  ? Container(
                      color: Colors.black26,
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height,
                    )
                  : Container(),
              walletController.loading.value
                  ? Align(
                      alignment: Alignment.center,
                      child: LoadingAnimationWidget.staggeredDotsWave(
                        color: AppColors.mainBlue,
                        size: 70,
                      ),
                    )
                  : Container(),
            ],
          );
        }),
      ),
    );
  }
}
