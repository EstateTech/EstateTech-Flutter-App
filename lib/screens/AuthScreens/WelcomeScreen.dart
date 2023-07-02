import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crypto_estate_tech/common/ColorConstants.dart';
import 'package:crypto_estate_tech/components/custom_button.dart';
import 'package:crypto_estate_tech/components/custom_white_box.dart';
import 'package:crypto_estate_tech/common/fixedvalues.dart';
import 'package:crypto_estate_tech/common/widgetConstants.dart';
import 'package:crypto_estate_tech/screens/AuthScreens/user_info_developer.dart';
import 'package:crypto_estate_tech/screens/AuthScreens/user_info_developer_agency_info2.dart';
import 'package:crypto_estate_tech/screens/homeScreen/home_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../../common/custom_button_widget.dart';
import '../../common/own_firebase_auth.dart';
import '../../components/divider_padding.dart';
import '../../components/socialLoginbutton.dart';
import '../../model/signupSaveDataFirebase.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  bool _isloading = false;
  final googleSignIn = GoogleSignIn();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: mainAppColor,
      body: _isloading
          ? Center(
              child: CupertinoActivityIndicator(
                color: Colors.white,
              ),
            )
          : Padding(
              padding: EdgeInsets.only(left: 20.h, right: 20.w),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 50.h,
                    ),
                    Text(
                      "Welcome!",
                      style: style.copyWith(fontSize: 22.sp),
                    ),
                    Text(
                      "Please log in or sign up.",
                      style: style.copyWith(fontSize: 15.sp),
                    ),
                    SizedBox(
                      height: 20.h,
                    ),

                    CustomWhiteBox(
                      boxShadowContainer: false,
                      widget: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            "United Arab Emirates(+971)",
                            style: style.copyWith(color: Colors.black),
                          ),
                          Icon(
                            Icons.keyboard_arrow_down_outlined,
                            size: 25.h,
                          )
                        ],
                      ),
                    ),

                    SizedBox(
                      height: 10.h,
                    ),

                    CustomWhiteBox(
                        boxShadowContainer: false,
                        widget: Center(
                          child: TextField(
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                                hintText: "Phone Number",
                                hintStyle: style.copyWith(color: Colors.black),
                                border: InputBorder.none),
                          ),
                        )),
                    SizedBox(
                      height: 10.h,
                    ),
                    Text(
                      labelTextWelcome,
                      style: style.copyWith(
                        color: Colors.white.withOpacity(0.8),
                      ),
                    ),
                    SizedBox(
                      height: 10.h,
                    ),

                    CustomButton1(boxShadowContainer: true, title: 'Continue'),
                    SizedBox(
                      height: 25.h,
                    ),
                    DividerPending(),
                    SizedBox(
                      height: 20.h,
                    ),
                    SocialLoginButton(
                        onPressed: () {
                          googleProvide('');
                        },
                        boxShadowContainer: true,
                        imagePath: 'assets/images/google.svg',
                        title: 'Continue with Google'),
                    // WhiteContainer(context: context, boxShadowContainer: true),
                    SizedBox(
                      height: 10.h,
                    ),
                    SocialLoginButton(
                        onPressed: () {},
                        boxShadowContainer: true,
                        imagePath: 'assets/images/facebook.svg',
                        title: 'Continue with Facebook'),
                    SizedBox(
                      height: 10.h,
                    ),
                    SocialLoginButton(
                        onPressed: () {},
                        boxShadowContainer: true,
                        imagePath: 'assets/images/apple.svg',
                        title: 'Continue with Apple'),

                    SizedBox(
                      height: 40.h,
                    ),
                    DividerPending(),
                    SizedBox(
                      height: 30.h,
                    ),
                    CustomButton1(
                        boxShadowContainer: true, title: 'Connect your wallet')
                  ],
                ),
              ),
            ),
    );
  }

  Future googleProvide(String memberType) async {
    await FirebaseAuth.instance.signOut();
    try {
      setState(() {
        _isloading = true;
      });

      GoogleSignInAccount? googleSignInAccount = await googleSignIn.signIn();

      if (googleSignInAccount != null) {
        GoogleSignInAuthentication googleSignInAuthentication =
            await googleSignInAccount.authentication;
        AuthCredential credential = GoogleAuthProvider.credential(
            idToken: googleSignInAuthentication.idToken,
            accessToken: googleSignInAuthentication.accessToken);

        UserCredential result =
            await FirebaseAuth.instance.signInWithCredential(credential);

        var userData = result.user;
        print(userData);

        if (userData != null) {
          setState(() {
            _isloading = false;
          });

          print(userData);

          FirebaseFirestore.instance
              .collection('users')
              .doc(userData.uid)
              .get()
              .then((value) {
            if (value.data() == null) {
              OwnFirebaseAuth().signSaveDataToFirebase(
                SignupSavepDataFirebase(
                    userId: userData.uid,
                    firstName:
                        userData.displayName!.split(' ').first.toString(),
                    lastName: userData.displayName!.split(' ').last.toString(),
                    email: userData.email,
                    status: 'user',
                    phoneNumber: userData.phoneNumber,
                    createAt: DateTime.now().toString(),
                    score: 0,
                    photoUrl: userData.photoURL,
                    countryCode: '+92',
                    isVerified: true,
                    memberType: '',
                    socialLogin: true,
                    currentSubscription: 'Basic',
                    profileCompleted: false,
                    loggedInStatus: 'Google'),
              );

              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => UserInfoDeveloper(
                            email: userData.email!,
                          )));
            } else {
              if (value.data()!['profileCompleted']) {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => HomeScreen()));
              } else {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => UserInfoDeveloper(
                              email: value.data()!['email'],
                            )));
              }
            }
          });

          // userProvider
          //     .saveUserDataToProvider(
          //         userData.uid);

          // Navigator.push(
          //     context, MaterialPageRoute(builder: (context) => HomeScreen()));
        } else {}
      } else {
        setState(() {
          _isloading = false;
        });
      }
    } catch (e) {
      setState(() {
        _isloading = false;
      });
    }
  }
}