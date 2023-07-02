import 'package:crypto_estate_tech/common/ColorConstants.dart';
import 'package:crypto_estate_tech/screens/AuthScreens/WelcomeScreen.dart';
import 'package:crypto_estate_tech/common/widgetConstants.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) =>
                const WelcomeScreen()), // Navigate to the home screen
      );
    });
    return Scaffold(
      backgroundColor: mainAppColor,
      body: Center(
        child: Text(
          'CRYPTO TECH AGENCY',
          style: style,
        ),
      ),
    );
  }
}
