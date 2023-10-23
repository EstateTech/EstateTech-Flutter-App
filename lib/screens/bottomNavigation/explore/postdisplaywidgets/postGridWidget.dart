import 'package:cached_network_image/cached_network_image.dart';
import 'package:crypto_estate_tech/common/rangeUtils.dart';
import 'package:crypto_estate_tech/common/widgetConstants.dart';
import 'package:crypto_estate_tech/helperclass/dataFromFirestore.dart';
import 'package:crypto_estate_tech/model/postModel.dart';
import 'package:crypto_estate_tech/provider/XfileProvider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

import '../../../../provider/likesProvider.dart';

class GridPost extends StatefulWidget {
  final PostModel postModel;
  final String userId;
  final bool isRecomendationPage;
  final List<String> likes;
  final String id;
  const GridPost({
    super.key,
    required this.postModel,
    required this.userId,
    this.isRecomendationPage = false,
    required this.likes,
    required this.id,
  });

  @override
  State<GridPost> createState() => _GridPostState();
}

class _GridPostState extends State<GridPost> {
  String memberType = 'Loading';

  void fetchMemberType() async {
    print("the user id is ${widget.userId}");
    String type = await getMemberType(widget.userId);
    if (mounted) {
      setState(() {
        memberType = type;
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchMemberType();
  }

  @override
  Widget build(BuildContext context) {
    final filterProvider =
        Provider.of<PostLikesProvider>(context, listen: true);

    String currentUserId =
        FirebaseAuth.instance.currentUser!.uid; // Replace with actual user ID
    filterProvider.initializeLikedPostIds(currentUserId);

    final fileProvider = Provider.of<XFileProvider>(context, listen: true);
    return Container(
      height: 330.h ,
      margin: EdgeInsets.symmetric(horizontal: 10.h),
      width: 150.w,
      decoration: const BoxDecoration(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              SizedBox(
                  height: 150.h,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(14.r),
                    child: CachedNetworkImage(
                      key: UniqueKey(),
                      imageUrl: widget.postModel.propertyPhotos![0]!,
                      fit: BoxFit.fitHeight,
                      placeholder: (context, url) => Container(
                        child: Lottie.asset(
                          'assets/images/loading_animation.json', // Replace with your animation file path
                          width: 200,
                          height: 200,
                          // Other properties you can customize
                        ),
                      ),
                    ),
                  )),
              Container(
                height: 30.h,
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
              ),
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
                                fontSize: 11.sp,
                                fontWeight: FontWeight.bold),
                          ),
                  )),
              Positioned(
                  right: 4.h,
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
            ],
          ),
          SizedBox(
            height: 5.h,
          ),
          Text(
            Utils.getFirstThreeWords(widget.postModel.propertyDescription!),
            // "${widget.postModel}",
            overflow: TextOverflow.ellipsis,
            style: style.copyWith(
                fontSize: 16.sp,
                fontWeight: FontWeight.w600,
                color: Colors.black),
            maxLines: 1,
          ),
          SizedBox(
            height: 3.h,
          ),
          widget.isRecomendationPage
              ? Container()
              : Wrap(
                  alignment: WrapAlignment.start,
                  children: [
                    Text(
                      widget.postModel.additionalInfo!,
                      style: style2.copyWith(
                          color: const Color(0xff717171), fontSize: 14.sp),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                  ],
                ),
          SizedBox(
            height: 4.h,
          ),
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
                    
                     TextSpan(text: Utils.convertCurrency("300000", fileProvider.currency)),
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
    );
  }
}
