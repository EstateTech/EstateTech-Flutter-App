import 'package:crypto_estate_tech/common/ColorConstants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../common/widgetConstants.dart';

class SocialLoginButton extends StatelessWidget {
  const SocialLoginButton(
      {super.key,
      required this.boxShadowContainer,
      required this.imagePath,
      required this.title,
      required this.onPressed});

  final bool boxShadowContainer;
  final String imagePath;
  final String title;
  final Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        height: 60.h,
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.only(left: 24.h, right: 24.h),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15.r),
          boxShadow: [
            boxShadowContainer
                ? BoxShadow(
                    color: Colors.white.withOpacity(0.4), // shadow color
                    spreadRadius: 1, // spread radius
                    blurRadius: 4, // blur radius
                    offset: Offset(0, 3), // changes position of shadow
                  )
                : BoxShadow(),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(imagePath),
            SizedBox(
              width: 30.w,
            ),
            Container(
              width: 220.w,
              decoration:
                  BoxDecoration(border: Border.all(color: Colors.transparent)),
              child: Text(
                "$title",
                style: style.copyWith(
                    color: mainAppColor,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w500),
              ),
            )
          ],
        ),
      ),
    );
  }
}
