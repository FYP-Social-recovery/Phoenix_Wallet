import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pheonix_wallet_app/src/constants.dart';
import 'package:pheonix_wallet_app/src/controllers/auth_controller.dart';
import '../../components/component_home.dart';

class AddShareholdersScreen extends StatelessWidget {
  AddShareholdersScreen({Key? key}) : super(key: key);

  static const routeName = addShareholdersScreen;

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
              title: "Add Shareholders",
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
                          labelText: "Holder 1",
                          hintText: "Type public key here...",
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        TextFieldTwo(
                          controller: textEditingController,
                          labelText: "Holder 2",
                          hintText: "Type public key here...",
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        TextFieldTwo(
                          controller: textEditingController,
                          labelText: "Holder 3",
                          hintText: "Type public key here...",
                        ),
                        SizedBox(
                          height: 20,
                        ),
                      ],
                    ),
                    PrimaryButton(
                      buttonText: "Add",
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
