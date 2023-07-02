import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../common/ColorConstants.dart';
import '../../common/custom_button_widget.dart';
import '../../common/fixedvalues.dart';
import '../../common/widgetConstants.dart';
import '../../components/own_textfield.dart';

class UserInfoDeveloper extends StatelessWidget {
  const UserInfoDeveloper({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 50.h,
              ),
              Container(
                child: Icon(Icons.arrow_back_rounded),
              ),
              SizedBox(
                height: 30.h,
              ),
              Text(
                'Add your info 1/2',
                style: style.copyWith(
                    color: Color(0xFF3A3153),
                    fontSize: 22.sp,
                    fontWeight: FontWeight.w700),
              ),
              Container(
                width: double.infinity,
                alignment: Alignment.centerRight,
                child: Text(
                  'Agent info',
                  style: style.copyWith(
                      color: Color(0xFF3A3153),
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w600),
                ),
              ),
              SizedBox(
                height: 20.h,
              ),
              OwnTextfield(
                label: 'First Name',
                hint: 'Scott',
              ),
              SizedBox(
                height: 20.h,
              ),
              OwnTextfield(
                label: 'Last Name',
                hint: 'Brown',
              ),
              SizedBox(
                height: 10.h,
              ),
              Text(
                'Make sure it matches on your governement issued ID',
                style: style.copyWith(
                  color: Colors.black.withOpacity(0.8),
                ),
              ),
              SizedBox(
                height: 30.h,
              ),
              Row(
                children: [
                  Flexible(
                    child: OwnTextfield(
                      label: 'ID Card',
                      hint: 'FI21515',
                    ),
                  ),
                  SizedBox(
                    width: 14.w,
                  ),
                  Container(
                    width: 60.w,
                    height: 55.h,
                    padding: EdgeInsets.all(10.w),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(13.r),
                        border: Border.all(color: Colors.black)),
                    child: SvgPicture.asset(
                      'assets/images/add_gallery.svg',
                      alignment: Alignment.center,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 20.h,
              ),
              OwnTextfield(
                label: 'Date of birth',
                hint: '24/04/1993',
              ),
              SizedBox(
                height: 10.h,
              ),
              Text(
                'To sign up, you need to be at least 18. Other users won’t see you date of birth.',
                style: style.copyWith(
                  fontSize: 14,
                  height: 1.2.h,
                  color: Colors.black.withOpacity(0.8),
                ),
              ),
              SizedBox(
                height: 30.h,
              ),
              OwnTextfield(
                label: 'Email',
                hint: 'scott.brown@gmail.com',
              ),
              SizedBox(
                height: 20.h,
              ),
              CustomButton(
                onPressed: () {
                  Navigator.pushNamed(context, userinfodeveloperscreenroute2);
                },
                textStyle: style.copyWith(
                  color: Colors.white,
                  fontSize: 19.sp,
                  fontWeight: FontWeight.w500,
                ),
                borderColor: Colors.black,
                text: 'Continue',
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
