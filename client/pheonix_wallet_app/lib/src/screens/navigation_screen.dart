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

  final _bgColor = Color(0xFFF6F6F6);

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
          Icons.category_outlined,
          Icons.home_outlined,
          Icons.send_outlined,
        ],
        highlightedIcons: [
          Icons.category,
          Icons.home,
          Icons.send_rounded,
        ],
        onTapped: (int value) {
          authController.selectedIndex.value = value;
        },
        bodyBgColor: _bgColor,
        highlightColor: Color(0xFFFF9944),
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
