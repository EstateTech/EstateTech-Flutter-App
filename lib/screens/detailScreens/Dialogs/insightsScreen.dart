import 'package:crypto_estate_tech/common/ColorConstants.dart';
import 'package:crypto_estate_tech/common/widgetConstants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class InsightsScreen extends StatefulWidget {
  const InsightsScreen({super.key});

  @override
  State<InsightsScreen> createState() => _InsightsScreenState();
}

class _InsightsScreenState extends State<InsightsScreen> {
  List<int> ratings = [
    3,
    2,
    5,
    5,
    5,
    5,
  ];

  double calculateAverageRating(List<int> ratings) {
    if (ratings.isEmpty) return 0.0;
    int totalRatings = ratings.reduce((a, b) => a + b);
    return totalRatings / ratings.length;
  }

  double calculatePercentageRated(int totalUsers, List<int> ratings) {
    if (totalUsers == 0) return 0.0;
    int usersWithRatings = ratings.length;
    double percentageRated = (usersWithRatings / totalUsers) * 100;
    return percentageRated;
  }

  @override
  Widget build(BuildContext context) {
    double averageRating = calculateAverageRating(ratings);
    print("Average Rating: $averageRating");
    return SingleChildScrollView(
      child: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: MediaQuery.of(context).size.height * 0.35,
              width: MediaQuery.of(context).size.width,
              decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage("assets/images/insight_image.png"))),
            ),
            const SizedBox(
              height: 20.0,
            ),
            Padding(
              padding: EdgeInsets.only(left: 20.h, right: 20.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Insights",
                    style: style.copyWith(
                        color: Shade2purple,
                        fontSize: 25.sp,
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "Jumeirah Palms",
                    style: style.copyWith(
                      fontSize: 24,
                      color: const Color(0xff4e4a59),
                    ),
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  Text(
                    "125 reviews",
                    style: style.copyWith(
                      fontSize: 20,
                      color: const Color(0xff4e4a59),
                    ),
                  ),
                  SizedBox(
                    height: 4.h,
                  ),
                  Row(
                    children: [
                      RatingBar.builder(
                        initialRating: averageRating,
                        ignoreGestures: true,
                        minRating: 1,
                        itemSize: 17.0,
                        unratedColor: Colors.black,
                        allowHalfRating: true,
                        itemBuilder: (context, index) {
                          bool isFullStar = index < averageRating.floor();
                          Color color =
                              isFullStar ? Shade2purple : Colors.black;
                          IconData starIcon =
                              isFullStar ? Icons.star : Icons.star_border;

                          return Icon(
                            starIcon,
                            color: color,
                          );
                        },
                        onRatingUpdate: (double value) {},
                      ),
                      Text(
                        "3/5",
                        style: numberStyle.copyWith(
                            fontSize: 20,
                            color: const Color(0xff4e4a59),
                            fontWeight: FontWeight.bold),
                      ),
                      Text(
                        "(60%)",
                        style: numberStyle.copyWith(
                          fontSize: 18,
                          color: const Color(0xff4e4a59),
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 30.h,
                  ),
                  Text(
                    "Key information",
                    style: style.copyWith(
                        fontSize: 20,
                        color: const Color(0xff3a3153),
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Row(
                          children: [
                            SizedBox(
                              height: 20.h,
                              width: 20.h,
                              child: SvgPicture.asset(
                                  "assets/images/flat_icon.svg"),
                            ),
                            SizedBox(
                              width: 10.h,
                            ),
                            Text(
                              "Building age:",
                              style: style.copyWith(
                                fontSize: 18.sp,
                                color: const Color(0xff3a3153),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Row(
                        children: [
                          Text(
                            "Not avaiable",
                            style: style.copyWith(
                              fontSize: 18.sp,
                              color: const Color(0xff3a3153),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                  SizedBox(
                    height: 30.h,
                  ),
                  Text(
                    "Key information",
                    style: style.copyWith(
                        fontSize: 20,
                        color: const Color(0xff3a3153),
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: 30.w,
                        height: 2.h,
                        decoration:
                            const BoxDecoration(color: Color(0xffC0E394)),
                      ),
                      SizedBox(
                        width: 10.h,
                      ),
                      Text(
                        "Dubai",
                        style: style.copyWith(
                            fontSize: 18.sp,
                            color: const Color(0xffC0E394),
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        width: 20.h,
                      ),
                      Container(
                        width: 30.w,
                        height: 2.h,
                        decoration:
                            const BoxDecoration(color: Color(0xff5B8427)),
                      ),
                      Text(
                        "Jumeirah Palms",
                        style: style.copyWith(
                            fontSize: 18.sp,
                            color: const Color(0xff5B8427),
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  Container(
                    height: 150.h,
                    decoration: const BoxDecoration(
                        color: Colors.white,
                        image: DecorationImage(
                            image: AssetImage("assets/images/chart.png"))),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
