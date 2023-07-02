import 'package:crypto_estate_tech/common/widgetConstants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../common/ColorConstants.dart';
import '../../common/custom_button_widget.dart';

class WalkThroughScreen extends StatefulWidget {
  WalkThroughScreen({super.key});

  @override
  State<WalkThroughScreen> createState() => _WalkThroughScreenState();
}

class _WalkThroughScreenState extends State<WalkThroughScreen> {
  List item = [0, 1];

  int currentIndex = 0;

  List data = [
    {
      'title': 'Use CET !',
      'subTitle':
          'By paying in CET, the native token of our platform, all your transactions will be free of all fees!',
    },
    {
      'title': 'What is CET ?',
      'subTitle':
          'Ut enim ad minima veniam, quis nostrum exercitationem ullam corporis suscipit laboriosam, nisi ut aliquid ex ea commodi consequatu',
    }
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xFF5F43B2),
        body: Stack(
          children: [
            Image.asset(
              'assets/images/walkthrough_background.png',
              fit: BoxFit.cover,
            ),
            Positioned(
              left: 14.w,
              right: 14.w,
              top: 0.h,
              bottom: 0,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 18.w),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        '${data[currentIndex]['title']}',
                        style: style.copyWith(
                            color: Colors.white,
                            fontSize: 32.sp,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      Center(
                        child: Text(
                          '${data[currentIndex]['subTitle']}',
                          textAlign: TextAlign.center,
                          style: style.copyWith(
                              color: Colors.white,
                              fontSize: 18.sp,
                              letterSpacing: 1.7.w,
                              height: 1.5,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                      SizedBox(
                        height: 120.h,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          IconButton(
                              onPressed: () {
                                if (currentIndex != 0) {
                                  setState(() {
                                    currentIndex--;
                                  });
                                }
                              },
                              icon: Icon(
                                Icons.arrow_back_rounded,
                                color: currentIndex == 0
                                    ? Colors.grey
                                    : Colors.white,
                              )),
                          Row(
                            children: item.map((e) {
                              return Column(
                                children: [
                                  Container(
                                    width: 10.w,
                                    height: 10.h,
                                    margin:
                                        EdgeInsets.symmetric(horizontal: 5.w),
                                    decoration: BoxDecoration(
                                        color: e == currentIndex
                                            ? Colors.white
                                            : Colors.grey,
                                        shape: BoxShape.circle),
                                  ),
                                ],
                              );
                            }).toList(),
                          ),
                          IconButton(
                              onPressed: () {
                                if (currentIndex != 1) {
                                  setState(() {
                                    currentIndex++;
                                  });
                                }
                              },
                              icon: Icon(
                                Icons.arrow_forward_rounded,
                                color: currentIndex == 1
                                    ? Colors.grey
                                    : Colors.white,
                              )),
                        ],
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      CustomButton(
                        onPressed: () {
                          Navigator.pushNamed(context, homeScreenRoute);
                        },
                        textStyle: style.copyWith(
                          color: Colors.white,
                          fontSize: 19.sp,
                          fontWeight: FontWeight.w500,
                        ),
                        borderColor: Color(0xFFDDDDDD),
                        text: 'Explore',
                        fillColor: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [mainAppColor, Colors.black]),
                      ),
                      SizedBox(
                        height: 80.h,
                      ),
                    ]),
              ),
            ),
            Positioned(
                right: 20.w,
                top: 50.h,
                child: GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, homeScreenRoute);
                  },
                  child: Container(
                    width: 100.w,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20.r),
                        color: Colors.white),
                    padding: EdgeInsets.all(10.w),
                    child: Text(
                      'Skip',
                      style: style.copyWith(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w600,
                          color: mainAppColor),
                    ),
                  ),
                ))
          ],
        ));
  }
}