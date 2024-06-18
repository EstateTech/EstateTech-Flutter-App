import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crypto_estate_tech/common/ColorConstants.dart';
import 'package:crypto_estate_tech/common/widgetConstants.dart';
import 'package:crypto_estate_tech/model/postModel.dart';
import 'package:crypto_estate_tech/model/signupSaveDataFirebase.dart';
import 'package:crypto_estate_tech/screens/detailScreens/Dialogs/dialogProfile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';

class profileContainer extends StatefulWidget {
  final PostModel postModel;
  const profileContainer({super.key, required this.postModel});

  @override
  State<profileContainer> createState() => _profileContainerState();
}

class _profileContainerState extends State<profileContainer> {
  SignupSavepDataFirebase userPost = SignupSavepDataFirebase();

  Future<void> fetchUserData() async {
    try {
      final DocumentSnapshot<Map<String, dynamic>> userSnapshot =
          await FirebaseFirestore.instance
              .collection('users')
              .doc(widget.postModel.userid)
              .get();

      if (userSnapshot.exists) {
        userPost = SignupSavepDataFirebase.fromJson(userSnapshot.data()!);
      }
    } catch (e) {
      print('Error fetching user data: $e');
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchUserData();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 300.h,
      padding: EdgeInsets.only(left: 20.h, right: 20.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 20.h,
          ),
          Row(
            children: [
              Container(
                height: 100.h,
                width: 100.h,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(50.r),
                  child: CachedNetworkImage(
                    key: UniqueKey(),
                    imageUrl: userPost.photoUrl ??
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
                width: 20.h,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    userPost.firstName ?? "Andera",
                    style: style.copyWith(
                      fontFamily: "Circular Std",
                      fontSize: MediaQuery.of(context).orientation ==
                              Orientation.portrait
                          ? 22
                          : 12,
                      fontWeight: FontWeight.w500,
                      color: const Color(0xff3a3153),
                    ),
                    textAlign: TextAlign.left,
                  ),
                  SizedBox(
                    width: 170.w,
                    child: Wrap(
                      alignment: WrapAlignment.start,
                      children: [
                        Text(
                          userPost.about ??
                              "Area Manager at White & Co Real Estate",
                          style: style.copyWith(
                            fontSize: MediaQuery.of(context).orientation ==
                                    Orientation.portrait
                                ? 15.sp
                                : 9.sp,
                            fontWeight: FontWeight.w300,
                            color: const Color(0xff4e4a59),
                          ),
                          textAlign: TextAlign.left,
                        ),
                      ],
                    ),
                  )
                ],
              )
            ],
          ),
          SizedBox(
            height: 10.h,
          ),
          RichText(
            text: TextSpan(
              style: style.copyWith(
                fontSize:
                    MediaQuery.of(context).orientation == Orientation.portrait
                        ? 18.sp
                        : 9.sp,
                fontWeight: FontWeight.bold,
                color: const Color(0xff3a3153),
              ),
              children: <TextSpan>[
                const TextSpan(
                  text: 'Response time :',
                ),
                TextSpan(
                  text: 'Within 7 minutes',
                  style: style.copyWith(
                    fontWeight: FontWeight.normal,
                    color: const Color(0xff4e4a59),
                    fontSize: MediaQuery.of(context).orientation ==
                            Orientation.portrait
                        ? 18.sp
                        : 9.sp,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 5.h,
          ),
          RichText(
            text: TextSpan(
              style: style.copyWith(
                fontSize:
                    MediaQuery.of(context).orientation == Orientation.portrait
                        ? 18.sp
                        : 9.sp,
                fontWeight: FontWeight.bold,
                color: const Color(0xff3a3153),
              ),
              children: <TextSpan>[
                const TextSpan(
                  text: "Experience:",
                ),
                TextSpan(
                  text: '3 years',
                  style: style.copyWith(
                    fontWeight: FontWeight.normal,
                    color: const Color(0xff4e4a59),
                    fontSize: MediaQuery.of(context).orientation ==
                            Orientation.portrait
                        ? 18.sp
                        : 9.sp,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 5.h,
          ),
          RichText(
            text: TextSpan(
              style: style.copyWith(
                fontSize: 18.sp,
                fontWeight: FontWeight.bold,
                color: const Color(0xff3a3153),
              ),
              children: <TextSpan>[
                const TextSpan(
                  text: "Languages:",
                ),
                TextSpan(
                  text: "English, Italian",
                  style: style.copyWith(
                    fontWeight: FontWeight.normal,
                    color: const Color(0xff4e4a59),
                    fontSize: MediaQuery.of(context).orientation ==
                            Orientation.portrait
                        ? 18.sp
                        : 9.sp,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 20.h,
          ),
          GestureDetector(
            onTap: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return CustomDialog(
                    userdata: userPost,
                  ); // Your custom dialog content
                },
              );
            },
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
                "User Properties",
                style: style.copyWith(
                  color: Colors.white,
                  fontSize:
                      MediaQuery.of(context).orientation == Orientation.portrait
                          ? 18.sp
                          : 9.sp,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
