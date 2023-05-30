import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
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
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Stack(
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
                          alignment: Alignment.center,
                          width: 30,
                          height: 30,
                          decoration: BoxDecoration(
                            color: Colors.black.withOpacity(0.1),
                            shape: BoxShape.circle,
                            boxShadow: <BoxShadow>[
                              BoxShadow(
                                color: Colors.black.withOpacity(0.7),
                                blurRadius: 1,
                                blurStyle: BlurStyle.outer,
                                offset: Offset(2, 2),
                                spreadRadius: 0,
                              ),
                            ],
                          ),
                          child: IconButton(
                            onPressed: () {
                              Get.back();
                            },
                            icon: Icon(
                              Icons.arrow_back_ios_new_rounded,
                              color: AppColors.mainBlue,
                              size: 15,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          "Phoenix Wallet",
                          style: GoogleFonts.inter(
                            textStyle: TextStyle(
                              color: Colors.white,
                              fontSize: 24,
                              fontWeight: FontWeight.w700,
                              fontStyle: FontStyle.italic,
                            ),
                          ),
                          textAlign: TextAlign.start,
                        ),
                        Spacer(),
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
                      ],
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.width * 0.25,
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
                            child: Image.asset(
                              "assets/me as a guardian red image.png",
                              width: 100,
                              // height: 130,
                            ),
                          ),
                          Align(
                            alignment: Alignment.centerRight,
                            child: Text(
                              "Guardian's Requests",
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
                    height: 40,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      children: [
                        TextFieldTwo(
                          labelText: "Guardian 1",
                          controller: TextEditingController(),
                          fontSize: 20,
                          fontWeight: FontWeight.normal,
                          fontColor: AppColors.mainBlue,
                          fontTextAlign: TextAlign.center,
                          labelColor: AppColors.mainBlue,
                          labelSize: 11,
                          labelWeight: FontWeight.w600,
                          labelAlignment: FloatingLabelAlignment.start,
                          borderColor: AppColors.mainBlue,
                          hintText: "0xfff....fff",
                          borderRadius: 10,
                          contentPadding: const EdgeInsets.only(left: 10),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        Container(
                          width: 150,
                          child: PrimaryButton(
                            buttonText: "Accept",
                            onPressed: () {},
                            color: Color.fromRGBO(7, 180, 1, 1),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Spacer(
                    flex: 2,
                  ),
                  Spacer(
                    flex: 2,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
