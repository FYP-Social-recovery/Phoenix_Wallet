import 'package:awesome_bottom_navigation/awesome_bottom_navigation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pheonix_wallet_app/src/constants.dart';
import 'package:pheonix_wallet_app/src/controllers/auth_controller.dart';
import 'package:pheonix_wallet_app/src/screens/home_screen.dart';
import 'package:pheonix_wallet_app/src/screens/social_recovery_menu_screen.dart';
import 'package:pheonix_wallet_app/src/screens/transaction_screen.dart';

class NavigationScreen extends StatelessWidget {
  NavigationScreen({Key? key}) : super(key: key);

  static const routeName = navigationScreen;

  final AuthController authController = Get.find();

  final List<Widget> pages = [
    SocialRecoveryMenuScreen(),
    HomeScreen(),
    TransactionScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: AwesomeBottomNav(
        icons: [
          Icon(
            Icons.category_outlined,
          ),
          Icon(
            Icons.home_outlined,
          ),
          Icon(
            Icons.send_outlined,
          ),
        ],
        highlightedIcons: [
          Icon(
            Icons.category,
            color: Colors.white,
          ),
          Icon(
            Icons.home,
            color: Colors.white,
          ),
          Icon(
            Icons.send_rounded,
            color: Colors.white,
          ),
        ],
        onTapped: (int value) {
          authController.selectedIndex.value = value;
        },
        bodyBgColor: AppColors.backgroundRed,
        highlightColor: AppColors.mainBlue,
        navFgColor: Colors.grey.withOpacity(0.5),
        navBgColor: Colors.white,
      ),
      body: Obx(
        () => SafeArea(
          child: pages[authController.selectedIndex.value],
        ),
      ),
    );
  }
}
