import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:pheonix_wallet_app/src/apis/api.dart';
import 'package:pheonix_wallet_app/src/components/home_panel_button.dart';
import 'package:pheonix_wallet_app/src/constants.dart';
import 'package:pheonix_wallet_app/src/controllers/auth_controller.dart';
import 'package:pheonix_wallet_app/src/controllers/controller_home.dart';
import 'package:web3dart/web3dart.dart';

import '../components/component_home.dart';

class SocialRecoveryMenuScreen extends StatelessWidget {
  SocialRecoveryMenuScreen({Key? key}) : super(key: key);

  final AuthController authController = Get.find();
  final WalletController walletController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Stack(
        alignment: Alignment.center,
        fit: StackFit.expand,
        children: [
          Align(
            alignment: Alignment.topCenter,
            child: Image.asset(
              "assets/menu header image.png",
              fit: BoxFit.fill,
              width: MediaQuery.of(context).size.width,
              height: 70,
            ),
          ),
          Column(
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
                    SizedBox(
                      width: 5,
                    ),
                    Text(
                      "Menu",
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
                    GestureDetector(
                      onTap: () {},
                      child: Icon(
                        Icons.notifications,
                        size: 30,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    GestureDetector(
                      onTap: () {},
                      child: Container(
                        width: 30,
                        height: 30,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                        ),
                        child: Image.asset(
                          "assets/user image.png",
                          width: 50,
                          height: 50,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 40,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        HomePanelButton(
                          image: "assets/node registration image.png",
                          label: "Node registation",
                          onTap: () {
                            Get.toNamed(registrationScreen);
                          },
                          size: 100,
                        ),
                        HomePanelButton(
                          image: "assets/add gardians image.png",
                          label: "Add Guardians",
                          onTap: () {
                            Get.toNamed(addShareholdersScreen);
                          },
                          size: 100,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        HomePanelButton(
                          image: "assets/me as a guardian image.png",
                          label: "Me as a Guardian",
                          onTap: () async {
                            walletController.loading.value = true;

                            List<String> beShareHolderList =
                                await Api.checkRequestsForBeAHolder(
                              authController.publicKey.value,
                              authController.privateKey.value,
                              walletController.nodeContractAddress.value,
                            );

                            if (beShareHolderList.length != 0) {
                              walletController.beShareholderRequests.value =
                                  beShareHolderList;
                              Get.toNamed(shareHolderRequestsScreen);
                            } else {
                              Get.snackbar(
                                "Loading Failed!",
                                "Something is wrong. Please try again.",
                                colorText: AppColors.mainRed,
                                backgroundColor: Colors.white70,
                              );
                            }

                            walletController.loading.value = false;
                          },
                          size: 100,
                        ),
                        HomePanelButton(
                          image: "assets/guardians status image.png",
                          label: "Gurdian's Status",
                          onTap: () async {
                            walletController.loading.value = true;

                            dynamic shareHolderList = await Api.getHolderStatus(
                              authController.publicKey.value,
                              authController.privateKey.value,
                              walletController.nodeContractAddress.value,
                            );

                            if (shareHolderList != "") {
                              walletController.shareholderRequestStatus.value =
                                  shareHolderList;
                              Get.toNamed(shareHolderStatusScreen);
                            } else {
                              Get.snackbar(
                                "Loading Failed!",
                                "Something is wrong. Please try again.",
                                colorText: AppColors.mainRed,
                                backgroundColor: Colors.white70,
                              );
                            }

                            walletController.loading.value = false;
                          },
                          size: 100,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    color: AppColors.backgroundRed,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(15),
                      topRight: Radius.circular(15),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 15),
                          child: Image.asset(
                            "assets/Line.png",
                            width: 50,
                            height: 4,
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Expanded(
                          child: SingleChildScrollView(
                            physics: BouncingScrollPhysics(),
                            child: Column(
                              children: [
                                SizedBox(
                                  height: 20,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    HomePanelButton(
                                      image: "assets/distribute key image.png",
                                      label: "Distribute Key",
                                      onTap: () {
                                        Get.toNamed(distributeSharesScreen1);
                                      },
                                      size: 100,
                                      shape: BoxShape.circle,
                                    ),
                                    HomePanelButton(
                                      image: "assets/recovery key image.png",
                                      label: "Recovery Key",
                                      onTap: () {
                                        Get.toNamed(recoveryMenuScreen);
                                      },
                                      size: 100,
                                      shape: BoxShape.circle,
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 30,
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 30),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Image.asset(
                                        "assets/Danger.png",
                                        width: 20,
                                        height: 20,
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Expanded(
                                        child: Text(
                                          "You will be asked to provide a private email address in the above two processes.",
                                          style: GoogleFonts.inter(
                                            textStyle: TextStyle(
                                              color: AppColors.mainRed,
                                              fontSize: 12,
                                              fontWeight: FontWeight.normal,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          walletController.loading.value
              ? Container(
                  color: Colors.black26,
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                )
              : Container(),
          walletController.loading.value
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Align(
                      alignment: Alignment.center,
                      child: LoadingAnimationWidget.staggeredDotsWave(
                        color: AppColors.mainBlue,
                        size: 70,
                      ),
                    ),
                  ],
                )
              : Container(),
        ],
      );
    });
  }
}
