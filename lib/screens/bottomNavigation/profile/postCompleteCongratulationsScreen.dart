import 'package:crypto_estate_tech/common/ColorConstants.dart';
import 'package:crypto_estate_tech/common/custom_button_widget.dart';
import 'package:crypto_estate_tech/common/widgetConstants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PostCompleteCongratulationScreen extends StatefulWidget {
  const PostCompleteCongratulationScreen({super.key});

  @override
  State<PostCompleteCongratulationScreen> createState() =>
      _PostCompleteCongratulationScreenState();
}

class _PostCompleteCongratulationScreenState
    extends State<PostCompleteCongratulationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.only(left: 20.h, right: 20.h),
        decoration: const BoxDecoration(
            gradient: LinearGradient(
              stops: [0.0, 1.0],
              begin: FractionalOffset.topCenter,
              end: FractionalOffset.bottomCenter,
              colors: [
                Colors.white,
                mainAppColor,
              ],
            ),
            image: DecorationImage(
                image: AssetImage("assets/images/walkthrough_background.png"))),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Center(
              child: Text(
                'You’re amazing !\nYour just made your first listing',
                textAlign: TextAlign.center,
                style: style.copyWith(
                    fontSize: 22.sp,
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(
              height: 20.h,
            ),
            Image.asset(
              'assets/images/gold_medal.png',
              fit: BoxFit.cover,
            ),
            SizedBox(
              height: 20.h,
            ),
            Center(
              child: Text(
                'Congratulations!',
                textAlign: TextAlign.center,
                style: style.copyWith(
                    fontSize: 22.sp,
                    color: Colors.white,
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
                  'Your property has been \nlisted succesfully!',
                  textAlign: TextAlign.center,
                  style: style.copyWith(
                      fontSize: 18.sp,
                      color: Colors.white,
                      fontWeight: FontWeight.w500),
                ),
              ),
            ),
            SizedBox(
              height: 60.h,
            ),
            CustomButton(
              onPressed: () {
                Navigator.pushNamed(context, homeScreenRoute);
              },
              textStyle: style.copyWith(
                color: Colors.white,
                fontSize: 19.sp,
                letterSpacing: 2.w,
                fontWeight: FontWeight.w500,
              ),
              borderColor: Colors.black,
              text: ' To homePage',
              fillColor: const LinearGradient(
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
    );
  }
}
