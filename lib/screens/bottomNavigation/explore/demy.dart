import 'package:carousel_slider/carousel_slider.dart';
import 'package:crypto_estate_tech/common/list_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

Widget buildImage(String urlImage, int index, BuildContext context) {
  return Container(
    width: MediaQuery.of(context).size.width,
    height: MediaQuery.of(context).size.height,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(10.r),
      image: DecorationImage(
        image: NetworkImage(urlImage),
        fit: BoxFit.fill,
      ),
    ),
  );
}

Widget buildIndicator(index, activeindexbuild, List<String> list) {
  return AnimatedSmoothIndicator(
    activeIndex: activeindexbuild,
    count: list.length,
    effect: const ScrollingDotsEffect(
        dotWidth: 10, dotHeight: 10, activeDotColor: Colors.white),
  );
}
