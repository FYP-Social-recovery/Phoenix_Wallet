import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pheonix_wallet_app/src/constants.dart';
import 'package:pheonix_wallet_app/src/controllers/auth_controller.dart';
import '../components/component_home.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);

  static const routeName = homeScreen;

  final AuthController authController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Phoenix wallet",
                style: TextStyle(
                  color: Color(0xFFFF6D00),
                  fontSize: 40,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(
                height: 50,
              ),
              Text(
                "Not Registered",
                style: TextStyle(
                  color: Color(0xFF000000),
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Text(
                "Public Key",
                style: TextStyle(
                  color: Color(0xFF000000),
                  fontSize: 20,
                  fontWeight: FontWeight.w400,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                authController.publicKey.value.substring(0, 4) +
                    "...." +
                    authController.publicKey.value
                        .substring(authController.publicKey.value.length - 4),
                style: TextStyle(
                  color: Color(0xFF000000),
                  fontSize: 20,
                  fontWeight: FontWeight.w200,
                ),
              ),
              SizedBox(
                height: 50,
              ),
              Text(
                "Balance",
                style: TextStyle(
                  color: Color(0xFF000000),
                  fontSize: 20,
                  fontWeight: FontWeight.w400,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                authController.balance.value.toString() +
                    " " +
                    authController.currency.value,
                style: TextStyle(
                  color: Color(0xFF000000),
                  fontSize: 40,
                  fontWeight: FontWeight.w200,
                ),
              ),
              SizedBox(
                height: 5,
              ),
              Text(
                "\$0.0 USD",
                style: TextStyle(
                  color: Color(0xFF000000),
                  fontSize: 25,
                  fontWeight: FontWeight.w200,
                ),
              ),
              SizedBox(
                height: 50,
              ),
              Text(
                authController.network.value,
                style: TextStyle(
                  color: Color(0xFF000000),
                  fontSize: 25,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
