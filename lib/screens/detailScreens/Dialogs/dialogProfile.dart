// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cached_network_image/cached_network_image.dart';
import 'package:crypto_estate_tech/helperclass/dataFromFirestore.dart';
import 'package:crypto_estate_tech/screens/detailScreens/userProfileDetailedScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:crypto_estate_tech/common/widgetConstants.dart';
import 'package:crypto_estate_tech/model/signupSaveDataFirebase.dart';
import 'package:lottie/lottie.dart';

import '../../../common/ColorConstants.dart';

class CustomDialog extends StatefulWidget {
  final SignupSavepDataFirebase userdata;
  const CustomDialog({
    Key? key,
    required this.userdata,
  }) : super(key: key);

  @override
  State<CustomDialog> createState() => _CustomDialogState();
}

class _CustomDialogState extends State<CustomDialog> {
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

    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      backgroundColor: Colors.transparent,
      child: Container(
        decoration: BoxDecoration(
            gradient: const LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [mainAppColor, Colors.black]),
            borderRadius: BorderRadius.circular(30.r)),
        height:
            MediaQuery.of(context).size.height * 0.6, // Set height as needed
        width: MediaQuery.of(context).size.height * 0.7,
        child: Padding(
          padding: EdgeInsets.only(left: 10.h, right: 10.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.pop(context); // Close the dialog
                },
                child: Align(
                  alignment: Alignment.topRight,
                  child: Container(
                    margin: EdgeInsets.only(top: 10.h),
                    height: 35.h,
                    width: 35.h,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.white)),
                    child: const Icon(
                      Icons.close,
                      size: 30,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              Row(
                children: [
                  Container(
                    height: 80.h,
                    width: 80.h,

                    child:  ClipRRect(
                      borderRadius: BorderRadius.circular(50.r),
                      child: CachedNetworkImage(
                      key: UniqueKey(),
                      imageUrl: widget.userdata.photoUrl ??
                          "https://images.unsplash.com/photo-1494790108377-be9c29b29330?auto=format&fit=crop&q=80&w=2187&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
                      fit: BoxFit.cover,
                      placeholder: (context, url) => Container(
                        child: Lottie.asset(
                          'assets/images/loading_animation.json', // Replace with your animation file path
                          width: 200,
                          height: 200,
                          // Other properties you can customize
                        ),
                      ),
                                      ),
                    ),
                  
                  ),
                  SizedBox(
                    width: 10.h,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                       widget.userdata.firstName ??  "Andera Biscotti",
                        style: style.copyWith(
                          fontFamily: "Circular Std",
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                          color: Colors.white,
                        ),
                        textAlign: TextAlign.left,
                      ),
                      Container(
                        width: 170.w,
                        margin: EdgeInsets.only(top: 5.h),
                        child: Wrap(
                          alignment: WrapAlignment.start,
                          children: [
                            Text(
                            widget.userdata.about ??"Area Manager at White & Co Real Estate",
                              style: style.copyWith(
                                fontSize: 15.sp,
                                fontWeight: FontWeight.w300,
                                color: const Color(0xffC8C8C8),
                              ),
                              textAlign: TextAlign.left,
                            ),
                          ],
                        ),
                      ),
                   
                    ],
                  ),
                ],
              ),
              SizedBox(
                height: 10.h,
              ),
              RichText(
                text: TextSpan(
                  style: style.copyWith(
                    fontSize: 15.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                  children: <TextSpan>[
                    const TextSpan(
                      text: 'Response time: ',
                    ),
                    TextSpan(
                      text: 'Within 7 minutes',
                      style: numberStyle.copyWith(
                        fontWeight: FontWeight.normal,
                        color: Colors.white,
                        fontSize: 15.sp,
                      ),
                    ),
                  ],
                ),
              ),
              RichText(
                text: TextSpan(
                  style: style.copyWith(
                    fontSize: 15.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                  children: <TextSpan>[
                    const TextSpan(
                      text: "Experience: ",
                    ),
                    TextSpan(
                      text: '3 years',
                      style: numberStyle.copyWith(
                        fontWeight: FontWeight.normal,
                        color: Colors.white,
                        fontSize: 15.sp,
                      ),
                    ),
                  ],
                ),
              ),
              RichText(
                text: TextSpan(
                  style: style.copyWith(
                    fontSize: 15.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                  children: <TextSpan>[
                    const TextSpan(
                      text: "Languages: ",
                    ),
                    TextSpan(
                      text: "English, Italian",
                      style: style.copyWith(
                        fontWeight: FontWeight.normal,
                        color: Colors.white,
                        fontSize: 15.sp,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 50.h,
              ),
              // Text(
              //   "Bio:",
              //   style: style.copyWith(color: Colors.white, fontSize: 15.sp),
              // ),
              // SizedBox(
              //   height: 5.h,
              // ),
              // Wrap(
              //   children: [
              //     Text(
              //       "Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremque laudantium, totam rem aperiam, eaque ipsa quae ab illo inventore veritatis et quasi architecto beatae vitae dicta sunt explicabo.",
              //       style: style.copyWith(color: Colors.white),
              //     )
              //   ],
              // ),
              // SizedBox(
              //   height: 35.h,
              // ),
              Align(
                alignment: Alignment.center,
                child: Text(
                  "163 users rated this account:",
                  style: style.copyWith(
                      color: Colors.white,
                      fontSize: 15.sp,
                      fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(
                height: 15.h,
              ),
              Align(
                alignment: Alignment.center,
                child: RichText(
                  text: TextSpan(
                    style: numberStyle.copyWith(
                      fontSize: 30.sp,
                      fontWeight: FontWeight.w400,
                      color: Colors.white,
                    ),
                    children: <TextSpan>[
                      TextSpan(
                        text: "${averageRating.floor().toString()}/5",
                      ),
                      TextSpan(
                        text:
                            '(${calculatePercentageRated(20, ratings).floor()}%)',
                        style: numberStyle.copyWith(
                          fontWeight: FontWeight.normal,
                          color: Colors.white,
                          fontSize: 15.sp,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 5.h,
              ),
              Align(
                alignment: Alignment.center,
                child: RatingBar.builder(
                  initialRating: averageRating,
                  ignoreGestures: true,
                  minRating: 1,
                  itemSize: 30.0,
                  unratedColor: Colors.white,
                  allowHalfRating: true,
                  itemBuilder: (context, index) {
                    bool isFullStar = index < averageRating.floor();
                    Color color =
                        isFullStar ? const Color(0xffFFF858) : Colors.white;
                    IconData starIcon =
                        isFullStar ? Icons.star : Icons.star_border;

                    return Icon(
                      starIcon,
                      color: color,
                    );
                  },
                  onRatingUpdate: (double value) {},
                ),
              ),
              SizedBox(height: 70.h,),
              Align(
                alignment: Alignment.bottomCenter,
                child: GestureDetector(
                  onTap: (){

                    // full profile page
                
                    

                     Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => UserProfileDetailedScreen(
                userdata: widget.userdata,
              )),
            );
                   
                    
              
                  },
                  child: Container(
                    height: 45.h,
                    width: 180.w,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50.r),
                      color: Colors.white
                    ),
                    child: Text(
                      "View Full Profile",
                      style: style.copyWith(
                        fontSize: 18.sp,
                        color: Shade2purple
                      ),
                    ),
                  ),
                ),
              )

             
            ],
          ),
        ),
      ),
    );
  }
}
