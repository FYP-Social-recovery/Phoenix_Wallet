import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pheonix_wallet_app/src/constants.dart';
import 'package:pheonix_wallet_app/src/controllers/auth_controller.dart';
import 'package:pheonix_wallet_app/src/controllers/controller_home.dart';
import '../../components/component_home.dart';

class ShareHolderRequestsScreen extends StatelessWidget {
  ShareHolderRequestsScreen({Key? key}) : super(key: key);

  static const routeName = shareHolderRequestsScreen;

  final WalletController walletController = Get.find();

  @override
  Widget build(BuildContext context) {
    print(walletController.shareholderRequests.value);
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TopHeaderBar(
              isBackAvailable: true,
              title: "Shareholder Requests",
            ),
            SizedBox(
              height: 40,
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Obx(() {
                  return Column(
                    children: walletController.shareholderRequests.value
                        .map(
                          (element) => Column(
                            children: [
                              TextFieldTwo(
                                controller:
                                    TextEditingController(text: element),
                                labelText: "Request",
                                isEditable: false,
                                fontSize: 20,
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Align(
                                alignment: Alignment.centerRight,
                                child: Container(
                                  width: 150,
                                  child: PrimaryButton(
                                    buttonText: "Accept",
                                    onPressed: () {},
                                    color: Color.fromRGBO(7, 180, 1, 1),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                            ],
                          ),
                        )
                        .toList(),
                  );
                }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
