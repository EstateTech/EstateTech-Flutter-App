import 'package:crypto_estate_tech/common/widgetConstants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'ColorConstants.dart';

class CustomCreatePostHeader extends StatelessWidget {
  const CustomCreatePostHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          alignment: Alignment.center,
          margin: EdgeInsets.only(right: 12.h),
          height: 40.h,
          width: 100.w,
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(20.r)),
          child: Text(
            "FAQ",
            style: style.copyWith(
                color: mainAppColor,
                fontSize: 15.sp,
                fontWeight: FontWeight.w500),
          ),
        ),
        Expanded(child: SizedBox()),
        Container(
          alignment: Alignment.center,
          margin: EdgeInsets.only(right: 12.h),
          height: 40.h,
          width: 100.w,
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(20.r)),
          child: Text(
            "Save & exit",
            style: style.copyWith(color: mainAppColor, fontSize: 15.sp),
          ),
        )
      ],
    );
  }
}
