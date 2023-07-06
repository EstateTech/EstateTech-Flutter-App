// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:carousel_slider/carousel_slider.dart';
import 'package:crypto_estate_tech/common/ColorConstants.dart';
import 'package:crypto_estate_tech/common/widgetConstants.dart';
import 'package:crypto_estate_tech/helperclass/dataFromFirestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:crypto_estate_tech/common/list_constants.dart';
import 'package:crypto_estate_tech/model/postModel.dart';
import 'package:crypto_estate_tech/screens/bottomNavigation/explore/demy.dart';

class Post extends StatefulWidget {
  final PostModel postModel;

  const Post({
    Key? key,
    required this.postModel,
  }) : super(key: key);

  @override
  State<Post> createState() => _PostState();
}

class _PostState extends State<Post> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 330.h,
      padding: EdgeInsets.symmetric(horizontal: 10.w),
      margin: EdgeInsets.only(top: 10.h),
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
          color: Colors.transparent, borderRadius: BorderRadius.circular(10.r)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              CarouselSlider.builder(
                carouselController: CarouselController(),
                options: CarouselOptions(
                    height: 180.h,
                    // aspectRatio: MediaQuery.of(context).size.width / 380,
                    padEnds: false,
                    viewportFraction: 1,
                    clipBehavior: Clip.none,
                    onPageChanged: (index, reason) {}),
                itemCount: widget.postModel.propertyPhotos!.length,
                itemBuilder: (context, index, realIndex) {
                  final urlImage = widget.postModel.propertyPhotos![index];
                  return ClipRRect(
                      borderRadius: BorderRadius.circular(10.r),
                      child: buildImage(urlImage!, index, context));
                },
              ),
              Positioned(
                  top: 1.h,
                  right: 5.h,
                  child: IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.favorite_border,
                      color: Colors.white,
                      size: 30.h,
                    ),
                  )),
              FutureBuilder<String>(
                future: getMemberType(widget.postModel.userid!),
                builder:
                    (BuildContext context, AsyncSnapshot<String> snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    // While the future is resolving, you can show a loading indicator
                    return Container();
                  } else if (snapshot.hasError || snapshot.data == null) {
                    // If there was an error in the future or the data is null, show an error message
                    return Text('Error: ${snapshot.error}');
                  } else {
                    // Once the future completes successfully and the data is not null, display it

                    final owner = snapshot.data!;

                    print("1${owner}");
                    return Positioned(
                        top: 10.h,
                        left: 10.w,
                        child: Text(
                          '$owner',
                          style: style.copyWith(
                              color: blueColor,
                              fontSize: 16.sp,
                              fontWeight: FontWeight.bold),
                        ));
                  }
                },
              )
            ],
          ),
          SizedBox(
            height: 10.h,
          ),
          Padding(
            padding: EdgeInsets.only(left: 2.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  getFirstThreeWords(widget.postModel.propertyDescription!),
                  style: style.copyWith(
                    color: Shade2purple,
                    fontSize: 20.sp,
                  ),
                ),
                Text(
                  widget.postModel.additionalInfo!,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: style2.copyWith(
                    color: greyShadeColor,
                    fontSize: 16.sp,
                  ),
                ),
                Text(
                  joinWithComma(widget.postModel.utilities!),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: style2.copyWith(
                    color: greyShadeColor,
                    fontSize: 16.sp,
                  ),
                ),
                Text(
                  Convertdate(widget.postModel.datePosted),
                  style: style2.copyWith(
                    color: greyShadeColor,
                    fontSize: 16.sp,
                  ),
                ),
                RichText(
                  text: TextSpan(
                    style: style.copyWith(
                      color: greyShadeColor,
                      fontSize: 20.sp,
                      fontWeight: FontWeight.w600,
                    ),
                    children: [
                      TextSpan(text: "300,000 AED"),
                      TextSpan(
                        text: " / year",
                        style: style.copyWith(
                            fontSize: 20.sp,
                            color: Shade2purple,
                            fontWeight: FontWeight
                                .normal // Specify your desired color for "/ year"
                            ),
                      ),
                    ],
                  ),
                ),
                RichText(
                  text: TextSpan(
                    style: style.copyWith(
                      color: greyShadeColor,
                      fontSize: 20.sp,
                      fontWeight: FontWeight.w600,
                    ),
                    children: [
                      TextSpan(text: "24 BTC"),
                      TextSpan(
                        text: " / year",
                        style: style.copyWith(
                            fontSize: 20.sp,
                            color: Shade2purple,
                            fontWeight: FontWeight
                                .normal // Specify your desired color for "/ year"
                            ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
