import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../common/ColorConstants.dart';
import '../common/widgetConstants.dart';

class OwnTextfield extends StatelessWidget {
  const OwnTextfield({super.key, required this.label, required this.hint});

  final String label;
  final String hint;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: mainAppColor.withOpacity(0.2), // shadow color
            spreadRadius: 1, // spread radius
            blurRadius: 4, // blur radius
            offset: Offset(0, 3), // changes position of shadow
          )
        ],
      ),
      child: TextFormField(
        autofocus: true,
        cursorColor: Color(0xFF444444),
        decoration: InputDecoration(
          contentPadding:
              EdgeInsets.symmetric(vertical: 20.h, horizontal: 20.w),
          isDense: true,
          filled: true,
          fillColor: Colors.white,
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16.r),
              borderSide: BorderSide(
                width: 1,
                color: Color(0xFF444444),
              )),

          //enabledBorder: InputBorder.none,
          border: OutlineInputBorder(
              borderSide: BorderSide(
                width: 2,
                color: Colors.black,
              ),
              borderRadius: BorderRadius.circular(16.r)),
          labelText: '$label',
          floatingLabelAlignment: FloatingLabelAlignment.start,
          hintText: '$hint',
          hintStyle: style.copyWith(
              letterSpacing: 1.1.w,
              color: Color(0xFF444444),
              fontSize: 15.sp,
              fontWeight: FontWeight.w700),

          labelStyle: style.copyWith(
              color: Color(0xFF444444),
              fontSize: 16.sp,
              fontWeight: FontWeight.w500),

          floatingLabelBehavior: FloatingLabelBehavior.always,
        ),
      ),
    );
  }
}
