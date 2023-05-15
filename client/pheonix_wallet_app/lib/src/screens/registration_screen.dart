import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pheonix_wallet_app/src/constants.dart';
import 'package:pheonix_wallet_app/src/controllers/auth_controller.dart';
import '../components/component_home.dart';

class RegistrationScreen extends StatelessWidget {
  RegistrationScreen({Key? key}) : super(key: key);

  static const routeName = registrationScreen;

  TextEditingController textEditingController = new TextEditingController();
  final AuthController authController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TopHeaderBar(
              isBackAvailable: true,
              title: "Node registration",
            ),
            SizedBox(
              height: 20,
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(
                      children: [
                        TextFieldTwo(
                          controller: textEditingController,
                          labelText: "Username",
                          hintText: "Type username here...",
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 70),
                          child: OutlineButton(
                            buttonText: "Check Validity",
                            onPressed: () async {
                              // await authController
                              //     .recoverWallet(textEditingController.text);
                            },
                          ),
                        ),
                      ],
                    ),
                    PrimaryButton(
                      buttonText: "Submit",
                      onPressed: () async {
                        // await authController
                        //     .recoverWallet(textEditingController.text);
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
