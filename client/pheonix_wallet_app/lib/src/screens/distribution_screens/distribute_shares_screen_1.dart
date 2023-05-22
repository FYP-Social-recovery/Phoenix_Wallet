import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pheonix_wallet_app/src/constants.dart';
import 'package:pheonix_wallet_app/src/controllers/auth_controller.dart';
import 'package:pheonix_wallet_app/src/controllers/controller_home.dart';
import '../../components/component_home.dart';

class DistributeSharesScreen1 extends StatelessWidget {
  DistributeSharesScreen1({Key? key}) : super(key: key);

  static const routeName = distributeSharesScreen1;

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
              "Email Verification",
              style: TextStyle(
                color: Color.fromRGBO(255, 109, 0, 1),
                fontSize: 35,
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
                  TextFieldTwo(
                    controller: TextEditingController(text: ""),
                    labelText: "Email Address",
                    isEditable: true,
                    fontSize: 25,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  PrimaryButton(
                    buttonText: "Send OTP",
                    onPressed: () {
                      Get.toNamed(distributeSharesScreen2);
                    },
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
