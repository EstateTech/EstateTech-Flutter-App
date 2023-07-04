import 'package:crypto_estate_tech/common/widgetConstants.dart';
import 'package:crypto_estate_tech/screens/walkthroughScreens/walkthrough.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../common/ColorConstants.dart';
import '../../common/custom_button_widget.dart';

class CongratulationScreen extends StatelessWidget {
  const CongratulationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Center(
                child: Text(
                  'Wow!',
                  textAlign: TextAlign.center,
                  style: style.copyWith(
                      fontSize: 22.sp,
                      color: Colors.black,
                      fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(
                height: 10.h,
              ),
              Center(
                child: Text(
                  'Your profile is complete. ',
                  textAlign: TextAlign.center,
                  style: style.copyWith(
                      fontSize: 16.sp,
                      color: Colors.black,
                      fontWeight: FontWeight.w500),
                ),
              ),
              Image.asset(
                'assets/images/success.png',
                fit: BoxFit.cover,
              ),
              Center(
                child: Text(
                  'Congratulations!',
                  textAlign: TextAlign.center,
                  style: style.copyWith(
                      fontSize: 22.sp,
                      color: Colors.black,
                      fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(
                height: 14.h,
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 24.w),
                child: Center(
                  child: Text(
                    'You can start listing your property now',
                    textAlign: TextAlign.center,
                    style: style.copyWith(
                        fontSize: 18.sp,
                        color: Colors.black,
                        fontWeight: FontWeight.w500),
                  ),
                ),
              ),
              SizedBox(
                height: 60.h,
              ),
              CustomButton(
                onPressed: () {
                  Navigator.pushNamed(context, walkThroughScreenRoute);
                },
                textStyle: style.copyWith(
                  color: Colors.white,
                  fontSize: 19.sp,
                  letterSpacing: 2.w,
                  fontWeight: FontWeight.w500,
                ),
                borderColor: Colors.black,
                text: 'Let\'s go!',
                fillColor: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [mainAppColor, Colors.black]),
              ),
              SizedBox(
                height: 50.h,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
