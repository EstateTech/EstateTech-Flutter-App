import 'package:crypto_estate_tech/common/ColorConstants.dart';
import 'package:crypto_estate_tech/common/widgetConstants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DialogMortgage3 extends StatefulWidget {
  const DialogMortgage3({super.key});

  @override
  State<DialogMortgage3> createState() => _DialogMortgage3State();
}

class _DialogMortgage3State extends State<DialogMortgage3> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      backgroundColor: Colors.transparent,
      child: Container(
        decoration: BoxDecoration(
            gradient: const LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [mainAppColor, Colors.black]),
            borderRadius: BorderRadius.circular(30.r)),
        height:
            MediaQuery.of(context).size.height * 0.40, // Set height as needed
        width: MediaQuery.of(context).size.height * 0.7,
        child: Padding(
          padding: EdgeInsets.only(left: 10.h, right: 10.h),
          child: Column(children: [
            GestureDetector(
              onTap: () {
                Navigator.pop(context); // Close the dialog
              },
              child: Align(
                alignment: Alignment.topRight,
                child: Container(
                  margin: EdgeInsets.only(top: 10.h),
                  height: 35.h,
                  width: 35.h,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white)),
                  child: const Icon(
                    Icons.close,
                    size: 30,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 15.h,
            ),
            Text(
              "Mortgage calculator",
              style: style.copyWith(
                  fontSize: 20.sp,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.5),
            ),
            SizedBox(
              height: 10.h,
            ),
            Text(
              "You can borrow:",
              style: style.copyWith(fontSize: 15.sp),
            ),
            SizedBox(
              height: 15.h,
            ),
            Text(
              "\$498,698.00",
              style: numberStyle.copyWith(
                fontSize: 25.sp,
                color: const Color(0xffDCCF5A),
              ),
            ),
            SizedBox(
              height: 20.h,
            ),
            Text(
              "Gross / net payments",
              style: style.copyWith(fontSize: 15.sp),
            ),
            SizedBox(
              height: 15.h,
            ),
            Text(
              "\$2,542 / \$1.896",
              style: numberStyle.copyWith(
                fontSize: 25.sp,
                color: const Color(0xffDCCF5A),
              ),
            )
          ]),
        ),
      ),
    );
  }
}
