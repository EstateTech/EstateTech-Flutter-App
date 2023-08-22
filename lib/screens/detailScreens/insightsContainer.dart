import 'package:crypto_estate_tech/common/ColorConstants.dart';
import 'package:crypto_estate_tech/common/widgetConstants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../model/postModel.dart';

class InsightsContainer extends StatefulWidget {
  final PostModel postModel;
  const InsightsContainer({super.key, required this.postModel});

  @override
  State<InsightsContainer> createState() => _InsightsContainerState();
}

class _InsightsContainerState extends State<InsightsContainer> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 600.h,
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.only(left: 20.h, right: 20.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Insights",
            style: style.copyWith(
              fontSize: 20.sp,
              color: Shade2purple,
            ),
          ),
          SizedBox(
            height: 10.h,
          ),
          Text(
            "5 bedrooms villas rented in Jumeirah Palm, Dubai",
            style: style.copyWith(
              fontSize: 18,
              fontWeight: FontWeight.w400,
              color: const Color(0xff4e4a59),
            ),
            textAlign: TextAlign.left,
          ),
          SizedBox(
            height: 15.h,
          ),
          Container(
            height: 150.h,
            decoration: const BoxDecoration(
                color: Colors.white,
                image: DecorationImage(
                    image: AssetImage("assets/images/chart.png"))),
          ),
          SizedBox(
            height: 15.h,
          ),
          GestureDetector(
            onTap: () {
              print("gesture dector clicked");
            },
            child: ProperttyinsightsInformationContainer(),
          ),
          SizedBox(
            height: 20.h,
          ),
          GestureDetector(
            onTap: () {
              print("gesture dector clicked");
            },
            child: ProperttyinsightsInformationContainer(),
          ),
          SizedBox(
            height: 15.h,
          ),
          GestureDetector(
            onTap: () {},
            child: Container(
              width: double.infinity,
              height: 55.h,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  color: Shade2purple,
                  borderRadius: BorderRadius.circular(25.r),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5), // Shadow color
                      spreadRadius: 2, // Spread radius
                      blurRadius: 5, // Blur radius
                      offset: const Offset(0, 3), // Offset in x and y direction
                    ),
                  ]),
              child: Text(
                "Find More Insights",
                style: style.copyWith(color: Colors.white, fontSize: 18.sp),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Container ProperttyinsightsInformationContainer() {
    return Container(
        width: double.infinity,
        height: 100.h,
        alignment: Alignment.center,
        padding: EdgeInsets.only(left: 10.h, right: 10.h),
        margin: EdgeInsets.only(right: 10.h),
        decoration: BoxDecoration(
            color: Shade2purple, borderRadius: BorderRadius.circular(20.r)),
        child: Row(
          children: [
            Icon(
              Icons.home_outlined,
              color: Colors.white,
              size: 50.h,
            ),
            SizedBox(
              width: 20.h,
            ),
            Text(
              "This property cost 13% less \nthan the average size of \nvillas in the same area.",
              style: style.copyWith(
                fontSize: 16.sp,
                color: Colors.white,
              ),
              textAlign: TextAlign.left,
            ),
          ],
        ));
  }
}
