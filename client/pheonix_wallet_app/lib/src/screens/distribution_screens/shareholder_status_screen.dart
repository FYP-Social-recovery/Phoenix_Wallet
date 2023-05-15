import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pheonix_wallet_app/src/constants.dart';
import 'package:pheonix_wallet_app/src/controllers/auth_controller.dart';
import 'package:pheonix_wallet_app/src/controllers/controller_home.dart';
import '../../components/component_home.dart';

class ShareHolderStatusScreen extends StatelessWidget {
  ShareHolderStatusScreen({Key? key}) : super(key: key);

  static const routeName = shareHolderStatusScreen;

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
              title: "Shareholder Status",
            ),
            SizedBox(
              height: 40,
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Obx(() {
                  return Column(
                    children: walletController.shareholderRequestStatus.value
                        .map(
                          (element) => Column(
                            children: [
                              TextFieldTwo(
                                controller: TextEditingController(
                                    text: element["pubKey"]),
                                labelText: "Shareholder " +
                                    element["holder"].toString(),
                                isEditable: false,
                                fontSize: 20,
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Align(
                                alignment: Alignment.centerRight,
                                child: Container(
                                  width: 180,
                                  child: PrimaryButton(
                                    buttonText: element["status"] == "ACCEPTED"
                                        ? "Accepted"
                                        : element["status"] == "PENDING"
                                            ? "Pending"
                                            : "Rejected",
                                    onPressed: () {},
                                    color: element["status"] == "ACCEPTED"
                                        ? Color.fromRGBO(7, 180, 1, 1)
                                        : element["status"] == "PENDING"
                                            ? Color.fromRGBO(199, 179, 1, 1)
                                            : Color.fromRGBO(180, 1, 1, 1),
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
