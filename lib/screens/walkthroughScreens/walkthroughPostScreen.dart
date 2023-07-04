import 'package:crypto_estate_tech/common/ColorConstants.dart';
import 'package:crypto_estate_tech/common/custom_button_widget.dart';
import 'package:crypto_estate_tech/common/widgetConstants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class WalkthroughPostScreen extends StatefulWidget {
  const WalkthroughPostScreen({super.key});

  @override
  State<WalkthroughPostScreen> createState() => _WalkthroughPostScreenState();
}

class _WalkthroughPostScreenState extends State<WalkthroughPostScreen> {
  List data = [
    {
      'title': 'Tell us about your property',
      'subTitle':
          'Share some basic info about your property, like its location, surface ...'
    },
    {
      'title': 'Make it stand out',
      'subTitle':
          'Add photos and videos of your property, and make a unique description.'
    },
    {
      'title': 'Finish up and publish',
      'subTitle':
          'Choose between listing your property for sale or for rent, set a prices & currencies, and publish it'
    },
  ];
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Scaffold(
      body: Container(
        padding: EdgeInsets.only(top: 50.h, left: 10.h),
        height: size.height,
        width: size.width,
        decoration: const BoxDecoration(
            gradient: LinearGradient(
              stops: [0.0, 1.0],
              begin: FractionalOffset.topCenter,
              end: FractionalOffset.bottomCenter,
              colors: [
                Colors.white,
                mainAppColor,
              ],
            ),
            image: DecorationImage(
                image: AssetImage("assets/images/walkthrough_background.png"))),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(child: SizedBox()),
                Container(
                  alignment: Alignment.center,
                  margin: EdgeInsets.only(right: 12.h),
                  height: 40.h,
                  width: 100.w,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20.r)),
                  child: Text(
                    "Save & exit",
                    style: style.copyWith(color: mainAppColor, fontSize: 15.sp),
                  ),
                )
              ],
            ),
            SizedBox(
              height: 18.h,
            ),
            Text(
              "It’s easy to get started on CET",
              style: style.copyWith(
                  fontSize: 30.sp,
                  color: textwalktrough,
                  fontWeight: FontWeight.w600),
            ),
            SizedBox(
              height: 20.h,
            ),
            Column(
              children: data.asMap().entries.map((entry) {
                int index = entry.key;
                Map<String, String> item = entry.value;
                int number = index++;

                String title = item['title'] ?? '';
                String subTitle = item['subTitle'] ?? '';
                return descriptionContainer(
                    context, title, subTitle, number.toString());
              }).toList(),
            ),
            Padding(
              padding: EdgeInsets.only(left: 10.h, right: 10.h, top: 20.h),
              child: CustomButton(
                text: "Get started",
                fillColor: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [mainAppColor, Colors.black]),
                borderColor: Colors.black,
                textStyle: style.copyWith(
                  color: Colors.white,
                  fontSize: 19.sp,
                  fontWeight: FontWeight.w500,
                ),
                onPressed: () {
                  Navigator.pushNamed(context, walkThroughPostScreenRoute2);
                },
              ),
            )
          ],
        ),
      ),
    );
  }

  Container descriptionContainer(
      BuildContext context, String title, String description, String number) {
    return Container(
      margin: EdgeInsets.only(
        left: 8.h,
        right: 8.h,
      ),
      padding: EdgeInsets.only(left: 20.h, right: 20.h),
      height: 150.h,
      width: MediaQuery.of(context).size.width,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "${number}    ${title}",
            style: style.copyWith(
                fontWeight: FontWeight.w700,
                color: textwalktrough,
                fontSize: 18.sp),
          ),
          SizedBox(
            height: 10.h,
          ),
          Padding(
            padding: EdgeInsets.only(left: 35.h),
            child: Text(
              description,
              style: style.copyWith(color: textwalktrough, fontSize: 18.sp),
            ),
          ),
        ],
      ),
    );
  }
}
