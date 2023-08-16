 import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Container DividerContainer(BuildContext context) {
    return Container(
                width: MediaQuery.sizeOf(context).height * 0.5,
                
                height: 1.h,
                margin: EdgeInsets.only(left:9.h,right:9.h),
                decoration: BoxDecoration(
                  color: Color(0xff686868)
                ),
              );
  }