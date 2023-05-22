import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:get/get.dart';
import 'package:pheonix_wallet_app/src/constants.dart';
import 'package:pheonix_wallet_app/src/controllers/auth_controller.dart';
import 'package:pheonix_wallet_app/src/controllers/controller_home.dart';
import '../../components/component_home.dart';

class DistributeSharesScreen2 extends StatelessWidget {
  DistributeSharesScreen2({Key? key}) : super(key: key);

  static const routeName = distributeSharesScreen2;

  final WalletController walletController = Get.find();

  @override
  Widget build(BuildContext context) {
    print(walletController.shareholderRequests.value);
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TopHeaderBar(
              isBackAvailable: true,
              title: "Distribute Shares",
            ),
            SizedBox(
              height: 60,
            ),
            Text(
              "Verification Code",
              style: TextStyle(
                color: Color.fromRGBO(255, 109, 0, 1),
                fontSize: 35,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(
              height: 50,
            ),
            Text(
              "We emailed you a code.\nPlease enter it below.",
              style: TextStyle(
                color: Color.fromRGBO(0, 0, 0, 1),
                fontSize: 20,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(
              height: 50,
            ),
            Spacer(
              flex: 1,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  OtpTextField(
                    numberOfFields: 5,
                    borderColor: Color(0xFFFF6D00),

                    //set to true to show as box or false to show as dash
                    showFieldAsBox: true,
                    //runs when a code is typed in
                    onCodeChanged: (String code) {
                      //handle validation or checks here
                    },
                    //runs when every textfield is filled
                    onSubmit: (String verificationCode) {
                      showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: Text("Verification Code"),
                              content:
                                  Text('Code entered is $verificationCode'),
                            );
                          });
                    }, // end onSubmit
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  PrimaryButton(
                    buttonText: "Verify",
                    onPressed: () {},
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  Text(
                    "Didn't get a code?",
                    style: TextStyle(
                      color: Color.fromRGBO(0, 0, 0, 1),
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(
                    height: 40,
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
    );
  }
}
