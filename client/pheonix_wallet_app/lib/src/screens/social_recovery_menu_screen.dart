import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pheonix_wallet_app/src/controllers/auth_controller.dart';

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
          Container(
            height: 50,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Menu",
                  style: TextStyle(
                    color: Color(0xFF343434),
                    fontSize: 25,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(10),
                  bottomRight: Radius.circular(10)),
              boxShadow: <BoxShadow>[
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 5,
                  blurRadius: 7,
                  offset: Offset(0, 3), // changes position of shadow
                ),
              ],
            ),
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
                      onTap: () {},
                    ),
                    CustomMenuItem(
                      icon: Icons.person,
                      label: "Shareholder status",
                      onTap: () {},
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
