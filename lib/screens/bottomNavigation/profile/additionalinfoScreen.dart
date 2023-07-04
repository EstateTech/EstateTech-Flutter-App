import 'package:crypto_estate_tech/common/ColorConstants.dart';
import 'package:crypto_estate_tech/common/custom_create_post_header.dart';
import 'package:crypto_estate_tech/common/custom_post_create_bottom.dart';
import 'package:crypto_estate_tech/common/widgetConstants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AdditionalInfoScreen extends StatefulWidget {
  const AdditionalInfoScreen({super.key});

  @override
  State<AdditionalInfoScreen> createState() => _AdditionalInfoScreenState();
}

class _AdditionalInfoScreenState extends State<AdditionalInfoScreen> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        height: size.height,
        width: size.width,
        padding: EdgeInsets.only(top: 50.h, left: 20.h, right: 20.h),
        decoration: BoxDecoration(
          gradient: appBackgroundGradient,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                CustomCreatePostHeader(),
                SizedBox(
                  height: 20.h,
                ),
                Text(
                  "Additional Info",
                  style: style.copyWith(
                      fontSize: 30.sp,
                      color: textwalktrough,
                      fontWeight: FontWeight.w600),
                ),
                SizedBox(
                  height: 10.h,
                ),
                Text(
                  "You may also want to give additional info or details for the users who might be interested in your property:",
                  style: style.copyWith(fontSize: 15.sp, color: textwalktrough),
                ),
                SizedBox(
                  height: 10.h,
                ),
                Container(
                  alignment: Alignment.topLeft,
                  height: 200.h,
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15.r)),
                  child: TextField(
                    maxLines: null,
                    decoration: InputDecoration(
                      hintText: 'Additional info',
                      border: InputBorder.none,
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.only(right: 12.h, left: 12.h, bottom: 30.h),
              child: customPostCreateBottomWidget(
                OnPressedNextButton: () {
                  Navigator.pushNamed(
                      context, postCompletedCongratulationsScreen);
                },
                OnPressedbackButton: () {
                  Navigator.pop(context);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
