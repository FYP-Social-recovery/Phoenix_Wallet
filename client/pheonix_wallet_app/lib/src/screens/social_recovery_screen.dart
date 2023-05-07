import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pheonix_wallet_app/src/controllers/auth_controller.dart';

class SocialRecoveryScreen extends StatelessWidget {
  SocialRecoveryScreen({Key? key}) : super(key: key);

  final AuthController authController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Social Recovery Screen",
            style: TextStyle(
              color: Color(0xFFFF6D00),
              fontSize: 40,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
