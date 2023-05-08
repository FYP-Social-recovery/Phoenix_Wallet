import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:pheonix_wallet_app/src/constants.dart';
import 'package:pheonix_wallet_app/src/controllers/auth_controller.dart';
import '../components/component_home.dart';

class SplashScreen extends StatelessWidget {
  SplashScreen({Key? key}) : super(key: key);

  static const routeName = splashScreen;

  final AuthController authController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: Padding(
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
                      : authController.loading.value
                          ? LoadingAnimationWidget.staggeredDotsWave(
                              color: Color(0xFFFF6D00),
                              size: 70,
                            )
                          : Column(
                              children: [
                                Container(
                                  height: 40,
                                  width: 40,
                                ),
                                PrimaryButton(
                                  buttonText: "Create Wallet",
                                  onPressed: () async {
                                    authController.loading.value = true;
                                    await Future.delayed(Duration(seconds: 2));
                                    await authController.createWallet();
                                    authController.loading.value = false;
                                  },
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                OutlineButton(
                                  buttonText: "Recover Wallet",
                                  onPressed: () {
                                    Get.toNamed(recoverWalletScreen);
                                  },
                                ),
                              ],
                            ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
