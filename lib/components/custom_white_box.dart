import 'package:crypto_estate_tech/common/widgetConstants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../common/ColorConstants.dart';

class CustomWhiteBox extends StatelessWidget {
  const CustomWhiteBox(
      {super.key, required this.boxShadowContainer, required this.widget});

  final bool boxShadowContainer;
  final Widget widget;

  @override
  Widget build(BuildContext context) {
    return Container(
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
        child: widget);
  }
}