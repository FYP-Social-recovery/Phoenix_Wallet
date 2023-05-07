import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pheonix_wallet_app/src/constants.dart';
import 'package:pheonix_wallet_app/src/controllers/auth_controller.dart';

import '../components/component_home.dart';

class TransactionScreen extends StatelessWidget {
  TransactionScreen({Key? key}) : super(key: key);

  final AuthController authController = Get.find();
  final TextEditingController textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            height: 50,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  children: [
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      "Send to",
                      style: TextStyle(
                        color: Color(0xFF343434),
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.circle,
                          color: Colors.black38,
                          size: 10,
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          networks[authController.selectedNetwork.value]
                                      [authController.selectedNetworkType.value]
                                  [authController.selectedNetworkLayer.value]
                              ["FullName"],
                          style: TextStyle(
                            color: Color(0xFF242424),
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ],
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
          Container(
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: Colors.black,
                  width: 2,
                ),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          flex: 1,
                          child: Container(
                            height: 80,
                            child: Center(
                              child: Text(
                                "From : ",
                                style: TextStyle(
                                  color: Color(0xFF000000),
                                  fontSize: 30,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 3,
                          child: Container(
                            height: 80,
                            child: Center(
                              child: TextFieldTwo(
                                controller: textEditingController,
                                labelText: "",
                                hintText: "0xfff....fff",
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          flex: 1,
                          child: Container(
                            height: 80,
                            child: Center(
                              child: Text(
                                "To : ",
                                style: TextStyle(
                                  color: Color(0xFF000000),
                                  fontSize: 30,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 3,
                          child: Container(
                            height: 80,
                            child: Center(
                              child: TextFieldTwo(
                                controller: textEditingController,
                                labelText: "",
                                hintText: "0xfff....fff",
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Column(
                    children: [
                      Text(
                        "Amount",
                        style: TextStyle(
                          color: Color(0xFF000000),
                          fontSize: 30,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 50),
                        child: TextField(
                          controller: textEditingController,
                          style: TextStyle(
                            color: Color(0xFF000000),
                            fontSize: 45,
                            fontWeight: FontWeight.w300,
                          ),
                          decoration: new InputDecoration.collapsed(
                            hintText: '00',
                            hintStyle: TextStyle(
                              color: Color(0xFF4B4B4B),
                              fontSize: 45,
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                          keyboardType: TextInputType.number,
                          textAlign: TextAlign.center,
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "ETH",
                        style: TextStyle(
                          color: Color(0xFF343434),
                          fontSize: 40,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: Color(0xFFFF6D00).withOpacity(0.2),
                          borderRadius: BorderRadius.all(
                            Radius.circular(20),
                          ),
                          boxShadow: <BoxShadow>[
                            BoxShadow(
                              color: Color(0xFFFF6D00).withOpacity(0.1),
                              spreadRadius: 5,
                              blurRadius: 7,
                              offset:
                                  Offset(0, 3), // changes position of shadow
                            ),
                          ],
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            vertical: 7,
                            horizontal: 15,
                          ),
                          child: Text(
                            "Balance : " + "36.00" + " ETH",
                            style: TextStyle(
                              color: Color(0xFFFF6D00),
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  PrimaryButton(
                    buttonText: "Send",
                    onPressed: () {
                      // Get.toNamed(recoverWalletScreen);
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
