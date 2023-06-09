import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:pheonix_wallet_app/src/apis/api.dart';
import 'package:pheonix_wallet_app/src/constants.dart';
import 'package:pheonix_wallet_app/src/controllers/auth_controller.dart';
import 'package:pheonix_wallet_app/src/controllers/controller_home.dart';
import '../../components/component_home.dart';

class DistributeSharesScreen2 extends StatelessWidget {
  DistributeSharesScreen2({Key? key}) : super(key: key);

  static const routeName = distributeSharesScreen2;

  final WalletController walletController = Get.find();
  final AuthController authController = Get.find();

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
                      "Enter OTP",
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
                            "assets/Password.png",
                            width: 83,
                            height: 75,
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          OtpTextField(
                            numberOfFields: 4,
                            borderColor: Color(0xFFFFFFFF),
                            textStyle: TextStyle(
                              color: Colors.white,
                            ),

                            focusedBorderColor: AppColors.mainGreen,
                            decoration: InputDecoration(
                              focusColor: AppColors.mainGreen,
                            ),
                            //set to true to show as box or false to show as dash
                            showFieldAsBox: false,
                            //runs when a code is typed in
                            onCodeChanged: (String code) {
                              // walletController.otp.value =
                              //     walletController.otp.value + code;
                              // print(walletController.otp.value);
                              //handle validation or checks here
                            },
                            //runs when every textfield is filled
                            onSubmit: (String verificationCode) {
                              walletController.otp.value = verificationCode;
                              print(walletController.otp.value);
                              // showDialog(
                              //     context: context,
                              //     builder: (context) {
                              //       return AlertDialog(
                              //         alignment: Alignment.center,
                              //         title: Text("Verification Code"),
                              //         content: Text(
                              //             'Code entered is $verificationCode'),
                              //       );
                              //     });
                            }, // end onSubmit
                          ),
                          SizedBox(
                            height: 35,
                          ),
                          Text(
                            "One time password is\ngenerated and sended to\nyour email address",
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

                              int val = int.parse(walletController.otp.value);

                              print(val);

                              walletController.otp.value = val.toString();

                              dynamic result = await Api.getOTPHash(
                                walletController.otp.value,
                              );

                              print(walletController.otp.value);

                              print(result);
                              print(walletController.otpHash.value);

                              if (result != 0) {
                                if (result == walletController.otpHash.value) {
                                  Get.snackbar(
                                    "Successful!",
                                    "Successfully verified email.",
                                    colorText: AppColors.mainBlue,
                                    backgroundColor: Colors.white70,
                                  );
                                  Get.toNamed(distributeSharesScreen3);
                                } else {
                                  Get.snackbar(
                                    "Failed!",
                                    "OTP is not matching please try again.",
                                    colorText: AppColors.mainRed,
                                    backgroundColor: Colors.white70,
                                  );
                                }
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
