import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crypto_estate_tech/common/ColorConstants.dart';
import 'package:crypto_estate_tech/common/widgetConstants.dart';
import 'package:crypto_estate_tech/provider/authProvider.dart';
import 'package:crypto_estate_tech/screens/AuthScreens/user_info_developer.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../homeScreen/home_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  var authProvider;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) {
        navigate();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    authProvider = Provider.of<AuthProvider>(context, listen: true);
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

  Future navigate() async {
    // check is for google
    var user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .get()
          .then((value) {
        if (value.data()!['profileCompleted']) {
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => const HomeScreen()),
              (route) => false);
        } else {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => UserInfoDeveloper(
                        email: value.data()!['email'].toString(),
                      )));
        }
      });

      authProvider.updateCurrencyRates();
    } else {
      Navigator.pushNamed(context, welcomeScreenRoute);
    }
  }
}
