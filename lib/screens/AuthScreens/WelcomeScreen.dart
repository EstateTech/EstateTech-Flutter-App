import 'package:crypto_estate_tech/common/ColorConstants.dart';
import 'package:crypto_estate_tech/components/custom_button.dart';
import 'package:crypto_estate_tech/components/custom_white_box.dart';
import 'package:crypto_estate_tech/common/fixedvalues.dart';
import 'package:crypto_estate_tech/common/widgetConstants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../common/custom_button_widget.dart';
import '../../components/divider_padding.dart';
import '../../components/socialLoginbutton.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: mainAppColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(left: 20.h, right: 20.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 20.h,
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
                      showModalBottomSheet(
                        context: context,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18.r)),
                        builder: (context) {
                          return Container(
                            padding: EdgeInsets.symmetric(horizontal: 22.w),
                            width: double.infinity,
                            height: 400.h,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  height: 20.h,
                                ),
                                Center(
                                  child: Container(
                                    width: 50.w,
                                    height: 5.h,
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                        color: Color(0xFFD9D9D9),
                                        borderRadius:
                                            BorderRadius.circular(6.r)),
                                  ),
                                ),
                                SizedBox(
                                  height: 30.h,
                                ),
                                Text(
                                  'Account type',
                                  style: style.copyWith(
                                      fontSize: 20.sp,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w700),
                                ),
                                SizedBox(
                                  height: 10.h,
                                ),
                                Text.rich(TextSpan(
                                    text:
                                        'By clicking on the "agree and continue” button below, you accept our ',
                                    style: style.copyWith(
                                        height: 1.7,
                                        color: Colors.black,
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.w300),
                                    children: <InlineSpan>[
                                      TextSpan(
                                        text: 'Cookies Policy Terms ',
                                        style: style.copyWith(
                                            decoration:
                                                TextDecoration.underline,
                                            height: 1.7,
                                            color: Colors.black,
                                            fontSize: 14.sp,
                                            fontWeight: FontWeight.w400),
                                      ),
                                      TextSpan(
                                        text: 'and ',
                                        style: style.copyWith(
                                            height: 1.7,
                                            color: Colors.black,
                                            fontSize: 14.sp,
                                            fontWeight: FontWeight.w400),
                                      ),
                                      TextSpan(
                                        text: 'Conditions Data Policy',
                                        style: style.copyWith(
                                            height: 1.7,
                                            decoration:
                                                TextDecoration.underline,
                                            color: Colors.black,
                                            fontSize: 14.sp,
                                            fontWeight: FontWeight.w300),
                                      ),
                                    ])),
                                SizedBox(
                                  height: 20.h,
                                ),
                                CustomButton(
                                  onPressed: () {
                                    Navigator.pushNamed(
                                        context, userinfodeveloperscreenroute);
                                  },
                                  textStyle: style.copyWith(
                                    color: Colors.white,
                                    fontSize: 19.sp,
                                    fontWeight: FontWeight.w500,
                                  ),
                                  borderColor: Colors.black,
                                  text: 'Member',
                                  fillColor: LinearGradient(
                                      begin: Alignment.topCenter,
                                      end: Alignment.bottomCenter,
                                      colors: [mainAppColor, Colors.black]),
                                ),
                                SizedBox(
                                  height: 10.h,
                                ),
                                CustomButton(
                                  onPressed: () {
                                    Navigator.pushNamed(
                                        context, userinfodeveloperscreenroute);
                                  },
                                  textStyle: style.copyWith(
                                    color: Colors.white,
                                    fontSize: 19.sp,
                                    fontWeight: FontWeight.w500,
                                  ),
                                  borderColor: Colors.black,
                                  text: 'Developer',
                                  fillColor: LinearGradient(
                                      begin: Alignment.topCenter,
                                      end: Alignment.bottomCenter,
                                      colors: [mainAppColor, Colors.black]),
                                ),
                                SizedBox(
                                  height: 10.h,
                                ),
                                CustomButton(
                                  onPressed: () {
                                    Navigator.pushNamed(
                                        context, userinfodeveloperscreenroute);
                                  },
                                  textStyle: style.copyWith(
                                    color: Colors.white,
                                    fontSize: 19.sp,
                                    fontWeight: FontWeight.w500,
                                  ),
                                  borderColor: Colors.black,
                                  text: 'Agency',
                                  fillColor: LinearGradient(
                                      begin: Alignment.topCenter,
                                      end: Alignment.bottomCenter,
                                      colors: [mainAppColor, Colors.black]),
                                ),
                                SizedBox(
                                  height: 10.h,
                                ),
                              ],
                            ),
                          );
                        },
                      );
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
      ),
    );
  }
}
