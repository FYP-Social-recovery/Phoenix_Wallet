import 'package:flutter/material.dart';
import 'package:pheonix_wallet_app/src/constants.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  static const routeName = splashScreen;

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
            CircularProgressIndicator(
              color: Colors.orangeAccent[700],
            ),
          ],
        ),
      ),
    );
  }
}
