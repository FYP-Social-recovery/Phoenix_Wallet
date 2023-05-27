import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pheonix_wallet_app/src/constants.dart';
import 'package:pheonix_wallet_app/src/controllers/auth_controller.dart';
import 'package:pheonix_wallet_app/src/controllers/wallet_controller.dart';

import '../components/component_home.dart';
import 'dart:math' as math;

class TransactionScreen extends StatelessWidget {
  TransactionScreen({Key? key}) : super(key: key);

  final AuthController authController = Get.find();
  final WalletController walletController = Get.find();
  final TextEditingController textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Align(
          alignment: Alignment.topCenter,
          child: Image.asset(
            "assets/waves downside small.png",
            fit: BoxFit.fitWidth,
            width: MediaQuery.of(context).size.width,
          ),
        ),
        GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(
                  top: 20,
                  left: 15,
                  right: 15,
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      width: 30,
                      height: 30,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                      ),
                      child: Image.asset(
                        "assets/Phoenix logo mini circular.png",
                        width: 40,
                        height: 40,
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Column(
                          children: [
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              "Send to",
                              style: GoogleFonts.inter(
                                textStyle: TextStyle(
                                  color: Colors.white,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                            Row(
                              children: [
                                Icon(
                                  Icons.circle,
                                  color: Colors.white,
                                  size: 10,
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  walletController.network.value,
                                  style: GoogleFonts.inter(
                                    textStyle: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                    Spacer(),
                    GestureDetector(
                      onTap: () {},
                      child: Icon(
                        Icons.notifications,
                        size: 30,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    GestureDetector(
                      onTap: () {},
                      child: Container(
                        width: 30,
                        height: 30,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                        ),
                        child: Image.asset(
                          "assets/user image.png",
                          width: 50,
                          height: 50,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.width * 0.2,
              ),
              Align(
                alignment: Alignment.centerRight,
                child: Padding(
                  padding: const EdgeInsets.only(right: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 20),
                        child: Transform.rotate(
                          angle: -math.pi / 4,
                          child: Image.asset(
                            "assets/transactions red image.png",
                            width: 100,
                            // height: 130,
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: Text(
                          "Transactions",
                          style: GoogleFonts.inter(
                            textStyle: TextStyle(
                              color: AppColors.mainBlue,
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    TextFieldTwo(
                      labelText: "Receiver’s Address",
                      controller: textEditingController,
                      fontSize: 20,
                      fontWeight: FontWeight.normal,
                      fontColor: AppColors.mainBlue,
                      fontTextAlign: TextAlign.center,
                      labelColor: AppColors.mainBlue,
                      labelSize: 11,
                      labelWeight: FontWeight.w600,
                      labelAlignment: FloatingLabelAlignment.center,
                      borderColor: AppColors.mainBlue,
                      hintText: "0xfff....fff",
                      borderRadius: 10,
                      contentPadding: const EdgeInsets.only(left: 10),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    TextFieldTwo(
                      labelText: "Amount",
                      controller: textEditingController,
                      fontSize: 20,
                      fontWeight: FontWeight.normal,
                      fontColor: AppColors.mainBlue,
                      fontTextAlign: TextAlign.center,
                      labelColor: AppColors.mainBlue,
                      labelSize: 11,
                      labelWeight: FontWeight.w600,
                      labelAlignment: FloatingLabelAlignment.center,
                      borderColor: AppColors.mainBlue,
                      hintText: "",
                      borderRadius: 10,
                      suffix: true,
                      suffixText: walletController.currency.value,
                      contentPadding:
                          const EdgeInsets.only(left: 10, right: 10),
                      suffixStyle: GoogleFonts.inter(
                        textStyle: TextStyle(
                          color: AppColors.mainBlue,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Spacer(
                        flex: 2,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Balance",
                            style: GoogleFonts.inter(
                              textStyle: TextStyle(
                                color: AppColors.mainBlue,
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                walletController.balance.value
                                    .toStringAsFixed(5),
                                style: GoogleFonts.inter(
                                  textStyle: TextStyle(
                                    color: AppColors.mainBlue,
                                    fontSize: 34,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Text(
                                walletController.currency.value,
                                style: GoogleFonts.inter(
                                  textStyle: TextStyle(
                                    color: AppColors.mainBlue,
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      Spacer(
                        flex: 1,
                      ),
                      PrimaryButton(
                        buttonText: "Send",
                        onPressed: () {
                          // Get.toNamed(recoverWalletScreen);
                        },
                      ),
                      Spacer(
                        flex: 1,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
