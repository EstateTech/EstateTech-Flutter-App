import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crypto_estate_tech/common/ColorConstants.dart';
import 'package:crypto_estate_tech/common/widgetConstants.dart';
import 'package:crypto_estate_tech/screens/AuthScreens/user_info_developer.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../homeScreen/home_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
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
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const HomeScreen()));
        } else {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => UserInfoDeveloper(
                        email: value.data()!['email'].toString(),
                      )));
        }
      });
    } else {
      Navigator.pushNamed(context, welcomeScreenRoute);
    }
  }
}
