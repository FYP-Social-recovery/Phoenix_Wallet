import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pheonix_wallet_app/src/constants.dart';
import 'package:pheonix_wallet_app/src/controllers/auth_controller.dart';

class SplashScreen extends StatelessWidget {
  SplashScreen({Key? key}) : super(key: key);

  static const routeName = splashScreen;

  final AuthController authController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              "assets/Phoenix logo.png",
              fit: BoxFit.fitWidth,
              width: MediaQuery.of(context).size.width,
            ),
            const SizedBox(
              height: 100,
            ),
            Obx(
              () => authController.splashScreenLoading.value
                  ? Container(
                      height: 40,
                      width: 40,
                      child: CircularProgressIndicator(
                        color: Colors.orangeAccent[700],
                      ),
                    )
                  : Container(
                      height: 40,
                      width: 40,
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
