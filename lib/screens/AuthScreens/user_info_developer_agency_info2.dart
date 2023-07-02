import 'package:crypto_estate_tech/components/own_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../common/ColorConstants.dart';
import '../../common/custom_button_widget.dart';
import '../../common/widgetConstants.dart';

class DeveloperAgencyInfo2 extends StatelessWidget {
  const DeveloperAgencyInfo2({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 10.h,
              ),
              Container(
                child: Icon(Icons.arrow_back_rounded),
              ),
              SizedBox(
                height: 30.h,
              ),
              Text(
                'Add your info 2/2',
                style: style.copyWith(
                    color: Color(0xFF3A3153),
                    fontSize: 22.sp,
                    fontWeight: FontWeight.w700),
              ),
              SizedBox(
                height: 50.h,
              ),
              Text(
                'Profile picture',
                style: style.copyWith(
                    color: Color(0xFF3A3153),
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w500),
              ),
              SizedBox(
                height: 10.h,
              ),
              Container(
                width: double.infinity,
                height: 220.h,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16.r),
                    border: Border.all(color: Colors.black)),
                alignment: Alignment.center,
                child: SvgPicture.asset('assets/images/photo_gallery.svg'),
              ),
              SizedBox(
                height: 20.h,
              ),
              Text.rich(TextSpan(
                  text: 'By selecting ',
                  style: style.copyWith(
                      height: 1.5,
                      color: Color(
                        0xFF717171,
                      ),
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w300),
                  children: <InlineSpan>[
                    TextSpan(
                      text: 'Agree & continue',
                      style: style.copyWith(
                          height: 1.5,
                          color: Color(
                            0xFF020202,
                          ),
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w500),
                    ),
                    TextSpan(
                      text: ', I agree to the ',
                      style: style.copyWith(
                          color: Color(
                            0xFF717171,
                          ),
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w300),
                    ),
                    TextSpan(
                      text: 'Terms of service',
                      style: style.copyWith(
                          decoration: TextDecoration.underline,
                          height: 1.5,
                          color: Color(
                            0xFF717171,
                          ),
                          fontSize: 17.sp,
                          fontWeight: FontWeight.w400),
                    ),
                    TextSpan(
                      text: ', ',
                      style: style.copyWith(
                          height: 1.5,
                          color: Color(
                            0xFF717171,
                          ),
                          fontSize: 17.sp,
                          fontWeight: FontWeight.w400),
                    ),
                    TextSpan(
                      text: 'Payment terms',
                      style: style.copyWith(
                          height: 1.5,
                          decoration: TextDecoration.underline,
                          color: Color(
                            0xFF717171,
                          ),
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w300),
                    ),
                    TextSpan(
                      text: ' and acknowledge the ',
                      style: style.copyWith(
                          color: Color(
                            0xFF717171,
                          ),
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w300),
                    ),
                    TextSpan(
                      text: 'Privacy policy.',
                      style: style.copyWith(
                          decoration: TextDecoration.underline,
                          color: Color(
                            0xFF717171,
                          ),
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w300),
                    )
                  ])),
              SizedBox(
                height: 20.h,
              ),
              CustomButton(
                onPressed: () {
                  showModalBottomSheet(
                      context: context,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18.r)),
                      builder: (context) {
                        return Container(
                          padding: EdgeInsets.symmetric(horizontal: 22.w),
                          width: double.infinity,
                          height: 340.h,
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
                                      borderRadius: BorderRadius.circular(6.r)),
                                ),
                              ),
                              SizedBox(
                                height: 30.h,
                              ),
                              Text(
                                'Our cookies & data policy',
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
                                          decoration: TextDecoration.underline,
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
                                          decoration: TextDecoration.underline,
                                          color: Colors.black,
                                          fontSize: 14.sp,
                                          fontWeight: FontWeight.w300),
                                    ),
                                  ])),
                              SizedBox(
                                height: 20.h,
                              ),
                              CustomButton(
                                textStyle: style.copyWith(
                                  color: Colors.white,
                                  fontSize: 19.sp,
                                  fontWeight: FontWeight.w500,
                                ),
                                borderColor: Colors.black,
                                text: 'Agree & continue',
                                fillColor: LinearGradient(
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter,
                                    colors: [mainAppColor, Colors.black]),
                              ),
                              SizedBox(
                                height: 10.h,
                              ),
                              CustomButton(
                                textStyle: style.copyWith(
                                  color: Colors.grey,
                                  fontSize: 19.sp,
                                  fontWeight: FontWeight.w500,
                                ),
                                borderColor: Colors.black,
                                text: 'Decline',
                                fillColor: LinearGradient(
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter,
                                    colors: [Colors.white, Colors.white]),
                              )
                            ],
                          ),
                        );
                      });
                },
                textStyle: style.copyWith(
                  color: Colors.white,
                  fontSize: 19.sp,
                  fontWeight: FontWeight.w500,
                ),
                borderColor: Colors.black,
                text: 'Agree & continue',
                fillColor: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [mainAppColor, Colors.black]),
              ),
              SizedBox(
                height: 11.h,
              ),
              CustomButton(
                textStyle: style.copyWith(
                  color: Colors.grey,
                  fontSize: 19.sp,
                  fontWeight: FontWeight.w500,
                ),
                borderColor: Colors.black,
                text: 'Skip for later',
                fillColor: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Colors.white, Colors.white]),
              )
            ],
          ),
        ),
      ),
    );
  }
}
