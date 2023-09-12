import 'package:crypto_estate_tech/common/widgetConstants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../common/ColorConstants.dart';

class LoginSecurityScreen extends StatefulWidget {
  const LoginSecurityScreen({super.key});

  @override
  State<LoginSecurityScreen> createState() => _LoginSecurityScreenState();
}

class _LoginSecurityScreenState extends State<LoginSecurityScreen> {
  bool switchValueEmail = false;
  bool switchValueSms = false;
  bool switchValueAuth = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(left: 20.h),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 70.h,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Icon(
                  Icons.arrow_back,
                  size: 40.h,
                  color: Colors.black54,
                ),
              ),
              SizedBox(
                height: 30.h,
              ),
              Padding(
                padding: EdgeInsets.only(left: 20.h),
                child: Text(
                  "Login And Security",
                  style: style.copyWith(
                      fontSize: 25.sp,
                      color: Shade2purple,
                      fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(
                height: 20.h,
              ),
              Align(
                alignment: Alignment.center,
                child: Column(
                  children: [
                    SizedBox(
                      height: 70.h,
                      width: 70.h,
                      child: SvgPicture.asset(
                        "assets/images/verify_checked._icon.svg",
                        width: 20.h,
                        height: 20.h,
                      ),
                    ),
                    SizedBox(
                      height: 5.h,
                    ),
                    Text(
                      "Your identity \n verified!",
                      style: style.copyWith(
                          color: Shade2purple,
                          fontSize: 25.sp,
                          fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    )
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(right: 10.h),
                child: Text(
                  "This will help us to recover your account\nquickly in case yu lost acces to it.",
                  style: style.copyWith(color: Shade2purple, fontSize: 17.sp),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(
                height: 25.h,
              ),
              Text(
                "Double verification",
                style: style.copyWith(
                    color: Shade2purple,
                    fontSize: 22.sp,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 20.h,
              ),
              Padding(
                padding: EdgeInsets.only(right: 40.h),
                child: Align(
                  alignment: Alignment.center,
                  child: Text(
                    "To ensure nobody access your account without permission from you, activate double verification on login from new devices, by email or by sms.",
                    style: style.copyWith(
                        fontSize: 17.sp,
                        color: Colors.black45,
                        wordSpacing: 1.5),
                  ),
                ),
              ),
              SizedBox(
                height: 20.h,
              ),
              VerifyOptions(
                  "By email",
                  switchValueEmail ? "Activated" : "Deactivated",
                  switchValueEmail, (newValue) {
                setState(() {
                  switchValueEmail = newValue;
                });
              }),
              const SizedBox(
                height: 30.0,
              ),
              VerifyOptions(
                  "By Sms",
                  switchValueSms ? "Activated" : "Deactivated",
                  switchValueSms, (newValue) {
                setState(() {
                  switchValueSms = newValue;
                });
              }),
              const SizedBox(
                height: 30.0,
              ),
              VerifyOptions(
                  "Two-factors auth",
                  switchValueAuth ? "Activated" : "Deactivated",
                  switchValueAuth, (newValue) {
                setState(() {
                  switchValueAuth = newValue;
                });
              }),
            ],
          ),
        ),
      ),
    );
  }

  Padding VerifyOptions(String heading, String verifyStatus, bool switchvalue,
      void Function(bool) onChanged) {
    return Padding(
      padding: EdgeInsets.only(left: 20.h, right: 50.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  heading,
                  style: style.copyWith(
                      fontSize: 20.sp,
                      color: Shade2purple,
                      fontWeight: FontWeight.bold),
                ),
                Text(
                  verifyStatus,
                  style:
                      numberStyle.copyWith(color: Colors.grey, fontSize: 15.sp),
                )
              ],
            ),
          ),
          CustomSwitch2(
            value: switchvalue,
            onChanged: onChanged,
          ),
        ],
      ),
    );
  }
}

class CustomSwitch2 extends StatelessWidget {
  final bool value;
  final ValueChanged<bool> onChanged;

  const CustomSwitch2({
    super.key,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onChanged(!value);
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeInOut,
        width: 80.w,
        height: 35.h,
        decoration: BoxDecoration(
            border: Border.all(
              color: !value
                  ? const Color(0xffA29DAD)
                  : const Color(0XFF5F5187), // Customize the border color
              width: 1.0,
            ),
            borderRadius: BorderRadius.circular(20.r),
            boxShadow: !value
                ? [const BoxShadow(color: Colors.transparent)]
                : [
                    const BoxShadow(color: Color(0XFF5F5187)),
                    const BoxShadow(
                        color: Color(0XFF5F5187),
                        blurRadius: 10,
                        spreadRadius: 0.5),
                    const BoxShadow(
                        color: Colors.white,
                        blurRadius: 20,
                        spreadRadius: -5.0),
                    const BoxShadow(
                        color: Colors.white,
                        blurRadius: 20,
                        spreadRadius: -1.0),
                  ]
            //  color: value ? Shade2purple : Colors.white,
            ),
        alignment: value ? Alignment.centerRight : Alignment.centerLeft,
        child: Container(
          width: 26.0,
          height: 26.0,
          margin: EdgeInsets.only(left: 5.h, right: 5.h),
          decoration: BoxDecoration(
              shape: BoxShape.circle,
              //  color: Colors.transparent,
              border: Border.all(
                color: !value
                    ? const Color(0xffA29DAD)
                    : const Color(0XFF5F5187), // Customize the border color
                width: 1.5,
              ),
              boxShadow: !value
                  ? [const BoxShadow(color: Colors.transparent)]
                  : [
                      const BoxShadow(color: Color(0XFF5F5187)),
                      const BoxShadow(
                          color: Colors.white,
                          blurRadius: 10,
                          spreadRadius: -5.0),
                      const BoxShadow(
                          color: Colors.white,
                          blurRadius: 10,
                          spreadRadius: -1.0),
                    ]),
          child: Icon(
            value ? Icons.check : Icons.close,
            color: !value ? const Color(0xffA29DAD) : const Color(0XFF5F5187),
            size: 20.0,
          ),
        ),
      ),
    );
  }
}
