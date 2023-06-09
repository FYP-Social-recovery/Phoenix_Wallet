import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:pheonix_wallet_app/src/apis/api.dart';
import 'package:pheonix_wallet_app/src/constants.dart';
import 'package:pheonix_wallet_app/src/controllers/auth_controller.dart';
import 'package:pheonix_wallet_app/src/controllers/wallet_controller.dart';
import 'package:web3dart/web3dart.dart';
import '../../components/component_home.dart';

class AddShareholdersScreen extends StatelessWidget {
  AddShareholdersScreen({Key? key}) : super(key: key);

  static const routeName = addShareholdersScreen;

  TextEditingController textEditingController1 = new TextEditingController();
  TextEditingController textEditingController2 = new TextEditingController();
  TextEditingController textEditingController3 = new TextEditingController();
  final AuthController authController = Get.find();
  final WalletController walletController = Get.find();

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
                              padding: const EdgeInsets.only(right: 20),
                              child: Image.asset(
                                "assets/add gurdians red image.png",
                                width: 100,
                                // height: 130,
                              ),
                            ),
                            Align(
                              alignment: Alignment.centerRight,
                              child: Text(
                                "Add Gurdians",
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
                      child: Column(
                        children: [
                          TextFieldTwo(
                            labelText: "Guardian 1",
                            controller: textEditingController1,
                            fontSize: 20,
                            fontWeight: FontWeight.normal,
                            fontColor: AppColors.mainBlue,
                            fontTextAlign: TextAlign.center,
                            labelColor: AppColors.mainBlue,
                            labelSize: 11,
                            labelWeight: FontWeight.w600,
                            labelAlignment: FloatingLabelAlignment.start,
                            borderColor: AppColors.mainBlue,
                            hintText: "0xfff....fff",
                            borderRadius: 10,
                            contentPadding: const EdgeInsets.only(left: 10),
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          TextFieldTwo(
                            labelText: "Guardian 2",
                            controller: textEditingController2,
                            fontSize: 20,
                            fontWeight: FontWeight.normal,
                            fontColor: AppColors.mainBlue,
                            fontTextAlign: TextAlign.center,
                            labelColor: AppColors.mainBlue,
                            labelSize: 11,
                            labelWeight: FontWeight.w600,
                            labelAlignment: FloatingLabelAlignment.start,
                            borderColor: AppColors.mainBlue,
                            hintText: "0xfff....fff",
                            borderRadius: 10,
                            contentPadding: const EdgeInsets.only(left: 10),
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          TextFieldTwo(
                            labelText: "Guardian 3",
                            controller: textEditingController3,
                            fontSize: 20,
                            fontWeight: FontWeight.normal,
                            fontColor: AppColors.mainBlue,
                            fontTextAlign: TextAlign.center,
                            labelColor: AppColors.mainBlue,
                            labelSize: 11,
                            labelWeight: FontWeight.w600,
                            labelAlignment: FloatingLabelAlignment.start,
                            borderColor: AppColors.mainBlue,
                            hintText: "0xfff....fff",
                            borderRadius: 10,
                            contentPadding: const EdgeInsets.only(left: 10),
                          ),
                          SizedBox(
                            height: 30,
                          ),
                        ],
                      ),
                    ),
                    Spacer(
                      flex: 2,
                    ),
                    PrimaryButton(
                      buttonText: "Add",
                      onPressed: () async {
                        walletController.loading.value = true;

                        await Api.addTemporaryShareHolder(
                          authController.publicKey.value,
                          authController.privateKey.value,
                          textEditingController1.text,
                          walletController.nodeContractAddress.value,
                        );
                        await Api.addTemporaryShareHolder(
                          authController.publicKey.value,
                          authController.privateKey.value,
                          textEditingController2.text,
                          walletController.nodeContractAddress.value,
                        );
                        await Api.addTemporaryShareHolder(
                          authController.publicKey.value,
                          authController.privateKey.value,
                          textEditingController3.text,
                          walletController.nodeContractAddress.value,
                        );

                        await Api.makeHolderRequests(
                          authController.publicKey.value,
                          authController.privateKey.value,
                          walletController.nodeContractAddress.value,
                        );

                        Get.snackbar(
                          "Successfully Added",
                          "Successfully Sent Gurdian Requests.",
                          colorText: AppColors.mainBlue,
                        );

                        walletController.loading.value = false;
                        Get.back();
                      },
                    ),
                    Spacer(
                      flex: 2,
                    ),
                  ],
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
