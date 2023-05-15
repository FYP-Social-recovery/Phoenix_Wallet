import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pheonix_wallet_app/src/constants.dart';
import 'package:pheonix_wallet_app/src/controllers/auth_controller.dart';
import 'package:pheonix_wallet_app/src/controllers/controller_home.dart';

import '../components/component_home.dart';

class SocialRecoveryMenuScreen extends StatelessWidget {
  SocialRecoveryMenuScreen({Key? key}) : super(key: key);

  final AuthController authController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TopHeaderBar(
            title: "Menu",
          ),
          SizedBox(
            height: 20,
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
              child: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomMenuItem(
                      icon: Icons.person,
                      label: "Node Registration",
                      onTap: () {
                        Get.toNamed(registrationScreen);
                      },
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                              color: Colors.black,
                              width: 1,
                            ),
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(
                            bottom: 5,
                            right: 10,
                          ),
                          child: Text(
                            "Wallet Owner Features",
                            style: TextStyle(
                              color: Color(0xFF000000),
                              fontSize: 20,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                    ),
                    CustomMenuItem(
                      icon: Icons.person,
                      label: "Add shareholders",
                      onTap: () {
                        Get.toNamed(addShareholdersScreen);
                      },
                    ),
                    CustomMenuItem(
                      icon: Icons.person,
                      label: "Shareholder status",
                      onTap: () {
                        final WalletController walletController = Get.find();
                        walletController.shareholderRequestStatus.value = [
                          {
                            "holder": 1,
                            "pubKey": "Ox123456f2a34567b3456c45dcb45a6d4",
                            "status": "ACCEPTED"
                          },
                          {
                            "holder": 2,
                            "pubKey": "Ox123456f2a34567b3456c45dcb45a6d4",
                            "status": "PENDING"
                          },
                          {
                            "holder": 3,
                            "pubKey": "Ox123456f2a34567b3456c45dcb45a6d4",
                            "status": "ACCEPTED"
                          },
                        ];
                        Get.toNamed(shareHolderStatusScreen);
                      },
                    ),
                    CustomMenuItem(
                      icon: Icons.person,
                      label: "Distribute shares",
                      onTap: () {},
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                              color: Colors.black,
                              width: 1,
                            ),
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(
                            bottom: 5,
                            right: 10,
                          ),
                          child: Text(
                            "Shareholder features",
                            style: TextStyle(
                              color: Color(0xFF000000),
                              fontSize: 20,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                    ),
                    CustomMenuItem(
                      icon: Icons.person,
                      label: "Accept shareholder requests",
                      onTap: () {
                        final WalletController walletController = Get.find();
                        walletController.shareholderRequests.value = [
                          "Ox123456f2a34567b3456c45dcb45a6d4",
                          "Ox123456f2a34567b3456c45dcb45a6d4",
                          "Ox123456f2a34567b3456c45dcb45a6d4",
                        ];
                        Get.toNamed(shareHolderRequestsScreen);
                      },
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                              color: Colors.black,
                              width: 1,
                            ),
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(
                            bottom: 5,
                            right: 10,
                          ),
                          child: Text(
                            "Wallet recovery features",
                            style: TextStyle(
                              color: Color(0xFF000000),
                              fontSize: 20,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                    ),
                    CustomMenuItem(
                      icon: Icons.person,
                      label: "Request for wallet recovery",
                      onTap: () {},
                    ),
                    CustomMenuItem(
                      icon: Icons.person,
                      label: "Recover request view",
                      onTap: () {},
                    ),
                    CustomMenuItem(
                      icon: Icons.person,
                      label: "Recover wallet",
                      onTap: () {},
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
