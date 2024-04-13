import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crypto_estate_tech/common/ColorConstants.dart';
import 'package:crypto_estate_tech/helperclass/own_firebase_auth.dart';
import 'package:crypto_estate_tech/common/widgetConstants.dart';
import 'package:crypto_estate_tech/components/custom_button.dart';
import 'package:crypto_estate_tech/screens/AuthScreens/user_info_developer.dart';
import 'package:crypto_estate_tech/screens/homeScreen/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pinput/pinput.dart';
import 'package:provider/provider.dart';

import '../../model/signupSaveDataFirebase.dart';
import '../../provider/authProvider.dart';

class OtpScreen extends StatefulWidget {
  final String verificationId;
  final String phoneNumber;
  final String dialCode;
  const OtpScreen(
      {super.key,
      required this.verificationId,
      required this.phoneNumber,
      required this.dialCode});

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  String? otpCode;
  bool _isloading = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _isloading =
        Provider.of<AuthProviderr>(context, listen: true).isOtpScreenLoading;

    return Scaffold(
      backgroundColor: mainAppColor,
      appBar: AppBar(
        backgroundColor: mainAppColor,
        elevation: 0.0,
        leading: GestureDetector(
          onTap: () {
            Provider.of<AuthProviderr>(context, listen: false)
                .setLoadingFalse();
            Navigator.of(context).pop();
          },
          child: const Icon(Icons.arrow_back),
        ),
      ),
      body: SafeArea(
        child: _isloading == true
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Center(
                    child: CircularProgressIndicator(
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  Text(
                    "Verfiying the otp",
                    style: style.copyWith(fontSize: 20.sp, color: Colors.white),
                  )
                ],
              )
            : Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          width: 200,
                          height: 200,
                          padding: const EdgeInsets.all(20.0),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.purple.shade50,
                          ),
                          child: Image.asset(
                            "assets/images/image3.png",
                          ),
                        ),
                        const SizedBox(height: 20),
                        const Text(
                          "Verification",
                          style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                        const SizedBox(height: 10),
                        const Text(
                          "Enter the OTP send to your phone number",
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 20),
                        Pinput(
                          length: 6,
                          showCursor: true,
                          defaultPinTheme: PinTheme(
                            width: 60,
                            height: 60,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                color: Colors.purple.shade200,
                              ),
                            ),
                            textStyle: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          onCompleted: (value) {
                            setState(() {
                              otpCode = value;
                            });
                          },
                        ),
                        const SizedBox(height: 25),
                        GestureDetector(
                          onTap: () {
                            if (otpCode != null) {
                              verifyOtp(context, otpCode!);
                            } else {
                              showSnackBar(context, "Enter 6-Digit code");
                            }
                          },
                          child: SizedBox(
                            width: MediaQuery.of(context).size.width,
                            height: 50,
                            child: CustomButton1(
                              title: "Verify",
                              boxShadowContainer: true,
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        const Text(
                          "Didn't receive any code?",
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                        const SizedBox(height: 15),
                        const Text(
                          "Resend New Code",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.purple,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
      ),
    );
  }

  // verify otp
  void verifyOtp(BuildContext context, String userOtp) {
    final ap = Provider.of<AuthProviderr>(context, listen: false);
    ap.verifyOtp(
      context: context,
      verificationId: widget.verificationId,
      userOtp: userOtp,
      onSuccess: () {
        setState(() {
          _isloading = true;
        });
        FirebaseFirestore.instance
            .collection('users')
            .doc(ap.uid)
            .get()
            .then((value) {
          if (!value.exists) {
            OwnFirebaseAuth().signSaveDataToFirebase(
              SignupSavepDataFirebase(
                  userId: ap.uid,
                  firstName: "",
                  lastName: "",
                  email: "",
                  status: 'user',
                  phoneNumber: widget.phoneNumber,
                  createAt: DateTime.now().toString(),
                  score: 0,
                  photoUrl: "",
                  countryCode: widget.dialCode,
                  isVerified: true,
                  memberType: '',
                  socialLogin: false,
                  currentSubscription: 'Basic',
                  profileCompleted: false,
                  loggedInStatus: 'Phone'),
            );

            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => UserInfoDeveloper(
                          email: "",
                        )));
          } else {
            if (value.data()!['profileCompleted'] ?? false) {
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (context) => HomeScreen(),
                  ),
                  (route) => false);
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
      },
    );
  }
}
