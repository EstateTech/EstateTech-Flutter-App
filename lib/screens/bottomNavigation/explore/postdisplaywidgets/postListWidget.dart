// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:carousel_slider/carousel_slider.dart';
import 'package:crypto_estate_tech/common/ColorConstants.dart';
import 'package:crypto_estate_tech/common/rangeUtils.dart';
import 'package:crypto_estate_tech/common/widgetConstants.dart';
import 'package:crypto_estate_tech/helperclass/dataFromFirestore.dart';
import 'package:crypto_estate_tech/provider/authProvider.dart';
import 'package:crypto_estate_tech/provider/likesProvider.dart';
import 'package:crypto_estate_tech/provider/XfileProvider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:crypto_estate_tech/model/postModel.dart';
import 'package:crypto_estate_tech/screens/bottomNavigation/explore/demy.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class Post extends StatefulWidget {
  final PostModel postModel;
  final userId;
  final String id;
  final List<String> likes;

  const Post({
    Key? key,
    required this.postModel,
    this.userId,
    required this.id,
    required this.likes,
  }) : super(key: key);

  @override
  State<Post> createState() => _PostState();
}

class _PostState extends State<Post> {
  String memberType = 'Loading';

  void fetchMemberType() async {
    print("the user id is ${widget.userId}");
    String type = await getMemberType(widget.userId);
    setState(() {
      memberType = type;
    });
  }

  List<String> abc = [
    "https://plus.unsplash.com/premium_photo-1661964475795-f0cb85767a88?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8N3x8aG91c2V8ZW58MHx8MHx8fDA%3D&auto=format&fit=crop&w=600&q=60",
    "https://images.unsplash.com/photo-1583608205776-bfd35f0d9f83?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MTF8fGhvdXNlfGVufDB8fDB8fHww&auto=format&fit=crop&w=600&q=60"
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchMemberType();
  }

  final CarouselController carouselController = CarouselController();
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    final filterProvider =
        Provider.of<PostLikesProvider>(context, listen: true);

    // Fetch the liked post IDs for the current user
    String currentUserId =
        FirebaseAuth.instance.currentUser!.uid; // Replace with actual user ID
    filterProvider.initializeLikedPostIds(currentUserId);
    final fileProvider = Provider.of<XFileProvider>(context, listen: true);
    final authProvider = Provider.of<AuthProvider>(context, listen: true);

    return Container(
      height: 330.h,
      padding: EdgeInsets.symmetric(horizontal: 10.w),
      margin: EdgeInsets.only(top: 10.h),
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
          color: const Color.fromARGB(0, 68, 34, 34),
          borderRadius: BorderRadius.circular(10.r)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              CarouselSlider.builder(
                carouselController: carouselController,
                options: CarouselOptions(
                    height: 170.h,
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
                  final urlImage = widget.postModel.propertyPhotos![index];

                  return ClipRRect(
                      borderRadius: BorderRadius.circular(10.r),
                      child: buildImage(urlImage!, index, context));
                },
              ),
              Positioned(
                  child: Container(
                height: 40.h,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.white
                          .withOpacity(0.5), // Adjust opacity and color
                      spreadRadius: 10, // Adjust the spread radius
                      blurRadius: 10, // Adjust the blur radius
                    ),
                  ],
                ),
              )),
              Positioned(
                  bottom: 10.h,
                  left: MediaQuery.of(context).size.width * 0.35,
                  child: buildIndicator(
                      currentIndex, widget.postModel.propertyPhotos!.length)),
              Positioned(
                  top: 1.h,
                  right: 5.h,
                  child: IconButton(onPressed: () {
                    filterProvider.toggleLike(widget.id, currentUserId);
                  }, icon: Consumer<PostLikesProvider>(
                    builder: (context, provider, _) {
                      return Icon(
                        provider.likedPostIds.contains(widget.id)
                            ? Icons.favorite
                            : Icons.favorite_border,
                        color: provider.likedPostIds.contains(widget.id)
                            ? Colors.red
                            : Colors.white,
                        size: 30.0,
                      );
                    },
                  ))),
              Positioned(
                  top: 10.h,
                  left: 5.h,
                  child: Container(
                      padding: EdgeInsets.all(4.w),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12.r)),
                      child: memberType == "Loading"
                          ? const Text("Loading..")
                          : Text(
                              memberType,
                              style: style.copyWith(
                                  color: const Color(0xff0D2769),
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.bold),
                            ))),
            ],
          ),
          SizedBox(
            height: 5.h,
          ),
          Padding(
            padding: EdgeInsets.only(left: 2.w),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 3.h,
                ),
                Text(
                  Utils.getFirstThreeWords(
                      widget.postModel.propertyDescription!),
                  style: style.copyWith(
                    color: Shade2purple,
                    fontWeight: FontWeight.w600,
                    fontSize: 18.sp,
                  ),
                ),
                SizedBox(
                  height: 2.h,
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
                SizedBox(
                  height: 3.h,
                ),
                Text(
                  Utils.joinWithComma(widget.postModel.utilities!),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: style2.copyWith(
                    color: greyShadeColor,
                    fontSize: 16.sp,
                  ),
                ),
                SizedBox(
                  height: 3.h,
                ),
                Text(
                  Convertdate(widget.postModel.datePosted),
                  style: style2.copyWith(
                    color: greyShadeColor,
                    fontSize: 16.sp,
                  ),
                ),
                SizedBox(
                  height: 3.h,
                ),
                // Row(
                //   children: [
                //     Expanded(
                //       child: RichText(
                //         text: TextSpan(
                //           style: style.copyWith(
                //             color: greyShadeColor,
                //             fontSize: 16.sp,
                //             fontWeight: FontWeight.w600,
                //           ),
                //           children: [
                //             TextSpan(text: "${fileProvider.currencySign}300,000${fileProvider.currency}"),
                //             TextSpan(
                //               text: " / year",
                //               style: style.copyWith(
                //                   fontSize: 16.sp,
                //                   color: Shade2purple,
                //                   fontWeight: FontWeight
                //                       .normal // Specify your desired color for "/ year"
                //                   ),
                //             ),
                //           ],
                //         ),
                //       ),
                //     ),
                //     SizedBox(
                //       height: 15.h,
                //       width: 15.h,
                //       child: SvgPicture.asset(
                //         'assets/images/star_icon.svg', // Replace with your SVG asset path
                //         width: 100, // Set your desired width
                //         height: 100, // Set your desired height
                //       ),
                //     ),
                //     RichText(
                //       text: TextSpan(
                //         style: style.copyWith(
                //             fontSize: 15.sp, color: const Color(0xff4E4A59)),
                //         children: const <TextSpan>[
                //           TextSpan(text: '4.21'),
                //           TextSpan(
                //             text: '(135)',
                //           ),
                //         ],
                //       ),
                //     )
                //   ],
                // ),
                // Row(
                //   children: [
                //     RichText(
                //       text: TextSpan(
                //         style: style.copyWith(
                //           color: greyShadeColor,
                //           fontSize: 20.sp,
                //           fontWeight: FontWeight.w600,
                //         ),
                //         children: const [
                //           TextSpan(text: "24 BTC"),
                //         ],
                //       ),
                //     ),
                //     SizedBox(
                //       width: 5.w,
                //     ),
                //     Image.asset(
                //       'assets/images/bitcoin_icon.png',
                //       width: 25.w,
                //       height: 25.h,
                //     ),
                //     Text(
                //       " / year",
                //       style: style.copyWith(
                //           fontSize: 16.sp,
                //           color: Shade2purple,
                //           fontWeight: FontWeight
                //               .normal // Specify your desired color for "/ year"
                //           ),
                //     ),
                //   ],
                // ),
                Row(
                  children: [
                    Text(
                      "${fileProvider.currencySign}",
                      style: style.copyWith(
                          color: Colors.black,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w600),
                    ),
                    FittedBox(
                      fit: BoxFit.scaleDown,
                      alignment: Alignment.center,
                      child: RichText(
                          text: TextSpan(
                              style: style.copyWith(
                                  color: Colors.black,
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w600),
                              children: <TextSpan>[
                            TextSpan(
                                text: Utils.convertCurrency(
                                    "300000",
                                    fileProvider.currency,
                                    authProvider.eth,
                                    authProvider.btc)),
                            //  TextSpan( text: "300 "),

                            // TextSpan(text: "${fileProvider.currency}"),
                            TextSpan(
                              text: ' / year',
                              style: style2.copyWith(
                                  color: Colors.black,
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w600),
                            ),
                          ])),
                    ),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
