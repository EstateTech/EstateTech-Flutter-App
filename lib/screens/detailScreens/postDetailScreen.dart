import 'package:carousel_slider/carousel_slider.dart';
import 'package:crypto_estate_tech/common/ColorConstants.dart';
import 'package:crypto_estate_tech/common/custom_button_widget.dart';
import 'package:crypto_estate_tech/common/widgetConstants.dart';
import 'package:crypto_estate_tech/helperclass/dataFromFirestore.dart';
import 'package:crypto_estate_tech/model/postModel.dart';
import 'package:crypto_estate_tech/screens/bottomNavigation/explore/demy.dart';
import 'package:crypto_estate_tech/screens/detailScreens/detailsContainer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class postDetailScreen extends StatefulWidget {
  final PostModel postModel;
  const postDetailScreen({super.key, required this.postModel});

  @override
  State<postDetailScreen> createState() => _postDetailScreenState();
}

class _postDetailScreenState extends State<postDetailScreen> {
  final CarouselController carouselController = CarouselController();
  int currentIndex = 0;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Hero(
                tag: "image_tag",
                child: Container(
                  height: MediaQuery.sizeOf(context).height,
                 
                  child: Stack(
                    children: [
                      CarouselSlider.builder(
                        carouselController: carouselController,
                        options: CarouselOptions(
                            height: MediaQuery.of(context).size.height * 0.45,
                            // aspectRatio: MediaQuery.of(context).size.width / 380,
                            padEnds: false,
                            viewportFraction: 1,
                            clipBehavior: Clip.none,
                            onPageChanged: (index, reason) {
                              setState(() {
                                currentIndex = index;
                              });
                            }),
                        itemCount: widget.postModel.propertyPhotos!.length,
                        itemBuilder: (context, index, realIndex) {
                          final urlImage =
                              widget.postModel.propertyPhotos![index];
                          return Container(
                            width: MediaQuery.of(context).size.width,
                            height: MediaQuery.of(context).size.height * 0.4,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: NetworkImage(urlImage!),
                                fit: BoxFit.fill,
                              ),
                            ),
                          );
                        },
                      ),
      
                      Align(
                        alignment: Alignment.topCenter,
                        child: Padding(
                          padding: EdgeInsets.only(top: MediaQuery.sizeOf(context).height * 0.35),
                          child: buildIndicator(currentIndex, widget.postModel.propertyPhotos!.length)),
                        
                      ),
                      Align(
                        alignment: Alignment.topLeft,
                        child: Padding(
                          padding: EdgeInsets.only(
                              top: 35.h, left: 10.h, right: 10.h),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  Navigator.pop(context);
                                },
                                child: Container(
                                  height: 40.h,
                                  width: 40.h,
                                  alignment: Alignment.center,
                                  decoration: const BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.white,
                                  ),
                                  child: Icon(
                                    Icons.arrow_back_outlined,
                                    color: Color(0xff444444),
                                    size: 25.h,
                                  ),
                                ),
                              ),
                              Row(
                                children: [
                                  Container(
                                    height: 40.h,
                                    width: 40.h,
                                    alignment: Alignment.center,
                                    decoration: const BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Colors.white),
                                    child: Icon(
                                      Icons.share_rounded,
                                      color: Color(0xff444444),
                                      size: 25.h,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 10.w,
                                  ),
                                  Container(
                                    height: 40.h,
                                    width: 40.h,
                                    alignment: Alignment.center,
                                    decoration: const BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Colors.white),
                                    child: Icon(
                                      Icons.favorite,
                                      color: Color(0xff444444),
                                      size: 25.h,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            top: MediaQuery.sizeOf(context).height * 0.3,
                            right: 10.h),
                        child: Align(
                          alignment: Alignment.topRight,
                          child: Container(
                            width: 80.h,
                            height: 60.h,
                            decoration: BoxDecoration(),
                            child: Column(
                              children: [
                                Container(
                                  width: 60.h,
                                  height: 25.h,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius:
                                          BorderRadius.circular(10.r)),
                                  child: Text(
                                    "360°",
                                    style: style.copyWith(
                                        color: Colors.black, fontSize: 14.sp),
                                  ),
                                ),
                                SizedBox(
                                  height: 5.0,
                                ),
                                Container(
                                  width: 60.h,
                                  height: 25.h,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius:
                                          BorderRadius.circular(10.r)),
                                  child: Text(
                                    "Meta",
                                    style: style.copyWith(
                                        color: Colors.black, fontSize: 14.sp),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: DetailsContainer(
                            postModel:widget.postModel)
                      )
                    ],
                  ),
                )),
          
          ],
        ),
      ),
      bottomNavigationBar: Container(
        height: 60.h,
       decoration: BoxDecoration(
         boxShadow: [
      BoxShadow(
        color: Colors.black.withOpacity(0.2),  // Shadow color
        spreadRadius: 1,  // Spread radius
        blurRadius: 5,    // Blur radius
        offset: Offset(0, -4),  // Offset to move the shadow up
      ),

    ],
    color: Colors.white,
       ),
        padding: EdgeInsets.only(left: 20.h,right:20.h,top: 10.h,bottom: 10.h),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                RichText(
                  text: TextSpan(
                    style: style2.copyWith(
                        fontSize: 16.sp,
                        color: const Color(0xff3A3153),
                        fontWeight: FontWeight.bold),
                    children: <TextSpan>[
                      TextSpan(text: '300,0000 '),
                      TextSpan(
                        text: 'AED',
                      ),
                      TextSpan(
                        text: ' / year',
                        style: style2.copyWith(
                          fontSize: 15.sp,
                          color: const Color(0xff3A3153),
                        ),
                      ),
                    ],
                  ),
                ),
                Text(
                  "*Prices may very",
                  style: style2.copyWith(
                      fontSize: 12.sp, color: Color(0xff4E4A59)),
                )
              ],
            ),
            Container(
              height: 40.h,
              width: 150.h,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [mainAppColor, Colors.black]),
                    borderRadius: BorderRadius.circular(15.r)
              ),
              child: Text("I'm interested",
              style: style2.copyWith(
                color: Colors.white,
                fontSize: 15.sp
              ),

              
              ),
            )
          ],
        ),
      ),
    );
  }
}
