import 'package:crypto_estate_tech/common/widgetConstants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomButton extends StatelessWidget {
  const CustomButton(
      {super.key,
      required this.text,
      required this.fillColor,
      required this.borderColor,
      required this.textStyle,
      this.onPressed});

  final String text;
  final Gradient fillColor;

  final TextStyle textStyle;
  final Color borderColor;
  final Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16.r),
            border: Border.all(width: 0.7, color: borderColor),
            gradient: fillColor),
        width: double.infinity,
        height: 55.h,
        child: Text(
          text,
          style: textStyle,
        ),
      ),
    );
  }
}
