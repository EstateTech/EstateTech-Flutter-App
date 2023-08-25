import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

Widget buildImage(String urlImage, int index, BuildContext context) {
  return SizedBox(
    width: MediaQuery.of(context).size.width,
    height: MediaQuery.of(context).size.height,
    child: CachedNetworkImage(
      key: UniqueKey(),
      imageUrl: urlImage,
      fit: BoxFit.fill,
      placeholder: (context, url) => Container(
        child: Lottie.asset(
          'assets/images/loading_animation.json', // Replace with your animation file path
          width: 200,
          height: 200,
          // Other properties you can customize
        ),
      ),
    ),
  );
}

Widget buildIndicator(index, int length) {
  return AnimatedSmoothIndicator(
    activeIndex: index,
    count: length,
    effect: const ScrollingDotsEffect(
        dotWidth: 10, dotHeight: 10, activeDotColor: Colors.white),
  );
}
