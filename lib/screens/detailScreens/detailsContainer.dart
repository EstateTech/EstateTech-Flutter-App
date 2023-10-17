import 'package:crypto_estate_tech/common/divider.dart';
import 'package:crypto_estate_tech/common/rangeUtils.dart';
import 'package:crypto_estate_tech/common/widgetConstants.dart';
import 'package:crypto_estate_tech/helperclass/dataFromFirestore.dart';
import 'package:crypto_estate_tech/model/postModel.dart';
import 'package:crypto_estate_tech/screens/detailScreens/AnimetiesContainer.dart';
import 'package:crypto_estate_tech/screens/detailScreens/insightsContainer.dart';
import 'package:crypto_estate_tech/screens/detailScreens/mapContainer.dart';
import 'package:crypto_estate_tech/screens/detailScreens/profileContainer.dart';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class DetailsContainer extends StatelessWidget {
  const DetailsContainer({
    super.key,
    required this.postModel,
  });
  final PostModel postModel;

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
        initialChildSize: 0.6,
        maxChildSize: 1.0,
        minChildSize: 0.6,
        builder: (context, scrollController) {
          return Container(
            clipBehavior: Clip.hardEdge,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(25.r),
                    topRight: Radius.circular(25.r))),
            child: SingleChildScrollView(
              controller: scrollController,
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 20.h, right: 20.h),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 20.h,
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  postModel.propertyType!,
                                  style: style2.copyWith(
                                      fontSize: 15.sp,
                                      color: Color(0xff4E4A59)),
                                ),
                              ),
                              Container(
                                height: 25.h,
                                width: 25.h,
                                child: SvgPicture.asset(
                                  'assets/images/star_icon.svg', // Replace with your SVG asset path
                                  width: 100, // Set your desired width
                                  height: 100, // Set your desired height
                                ),
                              ),
                              RichText(
                                text: TextSpan(
                                  style: style.copyWith(
                                      fontSize: 15.sp,
                                      color: Color(0xff4E4A59)),
                                  children: <TextSpan>[
                                    TextSpan(text: '4.21'),
                                    TextSpan(
                                      text: '(135)',
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 10.h,
                          ),
                          Text(
                        Utils.   getFirstThreeWords(postModel.propertyDescription!),
                            style: style2.copyWith(
                                fontSize: 20.sp,
                                fontWeight: FontWeight.w900,
                                color: Color(0xff3A3153)),
                          ),
                          SizedBox(
                            height: 5.h,
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width * 0.8,
                            child: Text(
                              postModel.propertyAddressLine2!,
                              style: style2.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xff4e4a59),
                                  fontSize: 14.sp),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          SizedBox(
                            height: 15.h,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                children: [
                                  Container(
                                    height: 25.h,
                                    width: 25.h,
                                    child: SvgPicture.asset(
                                      'assets/images/bedroom_icon.svg', // Replace with your SVG asset path
                                      width: 100, // Set your desired width
                                      height: 100, // Set your desired height
                                    ),
                                  ),
                                  RichText(
                                    text: TextSpan(
                                      style: style.copyWith(
                                        fontSize: 16.sp,
                                        color: const Color(0xff3a3153),
                                      ),
                                      children: <TextSpan>[
                                        TextSpan(
                                            text:
                                                postModel.bedrooms!.toString()),
                                        TextSpan(
                                          text: ' bedrooms',
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),

                              //bathroom column
                              Column(
                                children: [
                                  Container(
                                    height: 25.h,
                                    width: 25.h,
                                    child: SvgPicture.asset(
                                      'assets/images/bathroom_icon.svg', // Replace with your SVG asset path
                                      width: 100, // Set your desired width
                                      height: 100, // Set your desired height
                                    ),
                                  ),
                                  RichText(
                                    text: TextSpan(
                                      style: style.copyWith(
                                        fontSize: 16.sp,
                                        color: const Color(0xff3a3153),
                                      ),
                                      children: <TextSpan>[
                                        TextSpan(
                                            text: postModel.bathrooms!
                                                .toString()),
                                        TextSpan(
                                          text: ' bathroom',
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              // area column
                              Column(
                                children: [
                                  Container(
                                    height: 25.h,
                                    width: 25.h,
                                    child: SvgPicture.asset(
                                      'assets/images/area_icon.svg', // Replace with your SVG asset path
                                      width: 100, // Set your desired width
                                      height: 100, // Set your desired height
                                    ),
                                  ),
                                  RichText(
                                    text: TextSpan(
                                      style: style.copyWith(
                                        fontSize: 16.sp,
                                        color: const Color(0xff3a3153),
                                      ),
                                      children: <TextSpan>[
                                        TextSpan(
                                            text: postModel.propertyArea!
                                                .toString()),
                                        TextSpan(
                                          text: ' m²',
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                          SizedBox(
                            height: 15.h,
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width,
                            child: Text(
                              postModel.additionalInfo!,
                              style: style.copyWith(
                                fontSize: 13.sp,
                                color: Color(0xff4e4a59),
                              ),
                              maxLines: 5,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          SizedBox(
                            height: 20.h,
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                height: 30.h,
                                width: 30.h,
                                child: SvgPicture.asset(
                                  'assets/images/pool_icon.svg', // Replace with your SVG asset path
                                  width: 100, // Set your desired width
                                  height: 100, // Set your desired height
                                ),
                              ),
                              SizedBox(
                                width: 10.w,
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Enjoy the water!",
                                    style: style.copyWith(
                                        fontSize: 17.sp,
                                        color: Color(0xff3a3153)),
                                  ),
                                  SizedBox(
                                    height: 5.h,
                                  ),
                                  Container(
                                    height: 50.h,
                                    width:
                                        MediaQuery.of(context).size.width * 0.7,
                                    child: Text(
                                      "This location is one of the few places in area with two pools.",
                                      style: style.copyWith(
                                        fontSize: 14.sp,
                                        color: Color(0xff4e4a59),
                                      ),
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                          SizedBox(
                            height: 10.h,
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                height: 30.h,
                                width: 30.h,
                                child: SvgPicture.asset(
                                  'assets/images/door_icon.svg', // Replace with your SVG asset path
                                  width: 100, // Set your desired width
                                  height: 100, // Set your desired height
                                ),
                              ),
                              SizedBox(
                                width: 10.w,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Self Check-in",
                                    style: style.copyWith(
                                        fontSize: 17.sp,
                                        color: Color(0xff3a3153)),
                                  ),
                                  SizedBox(
                                    height: 5.h,
                                  ),
                                  Container(
                                    height: 50.h,
                                    width:
                                        MediaQuery.of(context).size.width * 0.7,
                                    child: Text(
                                      "This location is one of the few places in area with two pools.",
                                      style: style.copyWith(
                                        fontSize: 14.sp,
                                        color: Color(0xff4e4a59),
                                      ),
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ],
                              )
                            ],
                          )
                        ]),
                  ),
                  DividerContainer(context),
                  SizedBox(
                    height: 10.h,
                  ),
                  AnimetiesContainer(postModel: postModel),
                  SizedBox(
                    height: 10.h,
                  ),
                  DividerContainer(context),
                  SizedBox(
                    height: 10.h,
                  ),
                  MapContainer(postModel: postModel),
                  SizedBox(
                    height: 10.h,
                  ),
                  DividerContainer(context),
                  SizedBox(
                    height: 10.h,
                  ),
                  InsightsContainer(postModel: postModel),
                  SizedBox(
                    height: 10.h,
                  ),
                  DividerContainer(context),
                  SizedBox(
                    height: 10.h,
                  ),
                  profileContainer(),
                  SizedBox(
                    height: 60.h,
                  ),
                  // DividerContainer(context),
                  // SizedBox(
                  //   height: 10.h,
                  // ),
                  // RecomendationContainer(
                  //   postModel: postModel,
                  // )
                ],
              ),
            ),
          );
        });
  }
}
