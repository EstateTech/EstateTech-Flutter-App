import 'package:carousel_slider/carousel_slider.dart';
import 'package:crypto_estate_tech/common/list_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

List<CarouselController> listcarourselController = [];
List<int> listindexs = [];
List<bool> filterSelected = [];

Widget CourselBuilder() {
  return Container(
    height: 800.h,
    width: double.infinity,
    child: ListView.builder(
      itemCount: listhomeviews.length,
      itemBuilder: (BuildContext context, int listindex) {
        listcarourselController.add(CarouselController());
        listindexs.add(0);
        return Column(
          children: [
            Stack(
              children: [
                CarouselSlider.builder(
                  carouselController: listcarourselController[listindex],
                  options: CarouselOptions(
                      padEnds: false,
                      height: 190,
                      viewportFraction: 1,
                      onPageChanged: (index, reason) {}),
                  itemCount: listhomeviews[listindex].homeimages.length,
                  itemBuilder: (context, index, realIndex) {
                    final urlImage = listhomeviews[listindex].homeimages[index];
                    return buildImage(urlImage, index, context);
                  },
                ),
                Align(
                    alignment: Alignment.bottomCenter,
                    heightFactor: 12.h,
                    child: buildIndicator(listindex, listindexs[listindex])),
                Positioned(
                  top: 70.h,
                  left: 20.h,
                  child: GestureDetector(
                    onTap: () {
                      print("not clickable");
                      listcarourselController[listindex].previousPage();
                    },
                    child: backButton(Icons.arrow_back_ios_new_rounded),
                  ),
                ),
                Positioned(
                  top: 70.h,
                  right: 20.h,
                  child: GestureDetector(
                      onTap: () {
                        print(" clickable");
                        listcarourselController[listindex].nextPage(
                            duration: const Duration(milliseconds: 500));
                      },
                      child: backButton(Icons.arrow_forward_ios_rounded)),
                ),
                Positioned(
                    top: 1.h,
                    right: 5.h,
                    child: IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.favorite_border,
                        color: Colors.white,
                      ),
                    ))
              ],
            ),
            SizedBox(
              height: 5.h,
            ),
            Container(
              padding: EdgeInsets.only(
                  left: MediaQuery.of(context).size.width * 0.07,
                  right: MediaQuery.of(context).size.width * 0.03),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "AED 340,000",
                    style: GoogleFonts.lato(
                        fontSize: 20.sp, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  Row(
                    children: [
                      Row(
                        children: [
                          const Icon(
                            Icons.bed,
                            size: 20,
                            color: Colors.grey,
                          ),
                          SizedBox(
                            width: 10.w,
                          ),
                          Text(
                            "3",
                            style: GoogleFonts.lato(
                                fontSize: 15.sp,
                                fontWeight: FontWeight.bold,
                                color: Colors.grey),
                          )
                        ],
                      ),
                      SizedBox(
                        width: 12.w,
                      ),
                      Row(
                        children: [
                          const Icon(
                            Icons.baby_changing_station,
                            size: 20,
                            color: Colors.grey,
                          ),
                          SizedBox(
                            width: 10.w,
                          ),
                          Text(
                            "4",
                            style: GoogleFonts.lato(
                                fontSize: 15.sp,
                                fontWeight: FontWeight.bold,
                                color: Colors.grey),
                          )
                        ],
                      ),
                      SizedBox(
                        width: 10.w,
                      ),
                      Row(
                        children: [
                          const Icon(
                            Icons.access_alarm,
                            size: 20,
                            color: Colors.grey,
                          ),
                          SizedBox(
                            width: 10.w,
                          ),
                          Text(
                            "2,288 sqft",
                            style: GoogleFonts.lato(
                                fontSize: 15.sp,
                                fontWeight: FontWeight.bold,
                                color: Colors.grey),
                          )
                        ],
                      )
                    ],
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  Text(
                    "Amber,Tiara Residences , palm jumeirah Dubai United States",
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.lato(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey.shade500),
                  ),
                  // SizedBox(
                  //   height: 20.h,
                  // ),
                ],
              ),
            ),
          ],
        );
      },
    ),
  );
}

Widget buildImage(String urlImage, int index, BuildContext context) {
  return Container(
    width: MediaQuery.of(context).size.width,
    height: MediaQuery.of(context).size.height,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(25.r),
      image: DecorationImage(
        image: NetworkImage(urlImage),
        fit: BoxFit.cover,
      ),
    ),
  );
}

Container backButton(IconData iconData) {
  return Container(
    alignment: Alignment.center,
    height: 22.h,
    width: 22.w,
    decoration:
        const BoxDecoration(color: Colors.white, shape: BoxShape.circle),
    child: Icon(
      iconData,
      size: 20,
      color: Colors.grey,
    ),
  );
}

Widget buildIndicator(index, activeindexbuild) {
  return AnimatedSmoothIndicator(
    activeIndex: activeindexbuild,
    count: listhomeviews[index].homeimages.length,
    effect: const ScrollingDotsEffect(
        dotWidth: 10, dotHeight: 10, activeDotColor: Colors.white),
  );
}
