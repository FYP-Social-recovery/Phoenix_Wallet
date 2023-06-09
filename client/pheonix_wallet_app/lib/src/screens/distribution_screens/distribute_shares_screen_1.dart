import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:pheonix_wallet_app/src/apis/api.dart';
import 'package:pheonix_wallet_app/src/constants.dart';
import 'package:pheonix_wallet_app/src/controllers/auth_controller.dart';
import 'package:pheonix_wallet_app/src/controllers/controller_home.dart';
import '../../components/component_home.dart';

class DistributeSharesScreen1 extends StatelessWidget {
  DistributeSharesScreen1({Key? key}) : super(key: key);

  static const routeName = distributeSharesScreen1;

  final WalletController walletController = Get.find();
  final AuthController authController = Get.find();

  final TextEditingController textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.mainBlue,
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Obx(() {
          return Stack(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
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
                            color: Colors.white,
                            shape: BoxShape.circle,
                            boxShadow: <BoxShadow>[
                              BoxShadow(
                                color: Colors.white.withOpacity(0.7),
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
                    Spacer(
                      flex: 1,
                    ),
                    Text(
                      "Email Verification",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 36,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      height: 50,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            "assets/Message.png",
                            width: 83,
                            height: 75,
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          TextFieldTwo(
                            labelText: "Enter an Email",
                            controller: textEditingController,
                            fontSize: 20,
                            fontWeight: FontWeight.normal,
                            fontColor: Colors.white,
                            fontTextAlign: TextAlign.center,
                            labelColor: Colors.white,
                            labelSize: 11,
                            labelWeight: FontWeight.w600,
                            labelAlignment: FloatingLabelAlignment.start,
                            borderColor: Colors.white,
                            hintText: "",
                            borderRadius: 10,
                            contentPadding: const EdgeInsets.only(left: 10),
                          ),
                          SizedBox(
                            height: 35,
                          ),
                          Text(
                            "This email should be a\nprivate one which can\nonly be accessed by\nyourself.",
                            style: TextStyle(
                              color: AppColors.mainBlueLight,
                              fontSize: 16,
                              fontWeight: FontWeight.normal,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(
                            height: 60,
                          ),
                          PrimaryButton(
                            buttonText: "Proceed",
                            onPressed: () async {
                              walletController.loading.value = true;

                              walletController.otpHash.value = "";
                              walletController.otp.value = "";
                              walletController.email.value = "";

                              dynamic result = await Api.generateOTP(
                                textEditingController.text,
                              );

                              if (result != "") {
                                walletController.otpHash.value = result;
                                walletController.email.value =
                                    textEditingController.text;
                                Get.snackbar(
                                  "Successful!",
                                  "Successfully send the OTP.",
                                  colorText: AppColors.mainBlue,
                                  backgroundColor: Colors.white70,
                                );
                                Get.toNamed(distributeSharesScreen2);
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
                            color: Color(0xFF007CFF).withOpacity(0.5),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Text(
                            "*This will require to recover the wallet",
                            style: TextStyle(
                              color: AppColors.mainBlueLight,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(
                            height: 20,
                          ),
                        ],
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
                      color: Colors.black54,
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height,
                    )
                  : Container(),
              walletController.loading.value
                  ? Align(
                      alignment: Alignment.center,
                      child: LoadingAnimationWidget.staggeredDotsWave(
                        color: Colors.white,
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
