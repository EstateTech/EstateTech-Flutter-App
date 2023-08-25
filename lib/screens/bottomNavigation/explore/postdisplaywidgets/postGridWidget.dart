import 'package:cached_network_image/cached_network_image.dart';
import 'package:crypto_estate_tech/common/widgetConstants.dart';
import 'package:crypto_estate_tech/helperclass/dataFromFirestore.dart';
import 'package:crypto_estate_tech/model/postModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';

class GridPost extends StatefulWidget {
  final PostModel postModel;
  final String userId;
  final bool isRecomendationPage;
  const GridPost({
    super.key,
    required this.postModel,
    required this.userId,
    this.isRecomendationPage = false,
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
    return Container(
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
                  // decoration: BoxDecoration(
                  //     color: Colors.grey.shade200,
                  //     borderRadius: BorderRadius.circular(25.r),
                  //     image: DecorationImage(
                  //         image:
                  //             NetworkImage(widget.postModel.propertyPhotos![0]!),
                  //         fit: BoxFit.fitHeight)),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(25.r),
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
                  child: memberType == "Loading"
                      ? const Text("Loading..")
                      : Text(
                          memberType,
                          style: style.copyWith(
                              color: const Color(0xff0D2769),
                              fontSize: 14.sp,
                              fontWeight: FontWeight.bold),
                        )),
              Positioned(
                  right: 4.h,
                  child: IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.favorite_border,
                      color: Colors.white,
                      size: 30.h,
                    ),
                  )),
            ],
          ),
          SizedBox(
            height: 5.h,
          ),
          FittedBox(
            fit: BoxFit.scaleDown,
            alignment: Alignment.center,
            child: Text(
              getFirstThreeWords(widget.postModel.propertyDescription!),
              style: style.copyWith(
                  fontSize: 20.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
              maxLines: 1,
            ),
          ),
          widget.isRecomendationPage
              ? Container()
              : Wrap(
                  alignment: WrapAlignment.start,
                  children: [
                    Text(
                      widget.postModel.additionalInfo!,
                      style: style2.copyWith(
                          color: const Color(0xff717171), fontSize: 18.sp),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                    ),
                  ],
                ),
          FittedBox(
            fit: BoxFit.scaleDown,
            alignment: Alignment.center,
            child: RichText(
                text: TextSpan(
                    style: style.copyWith(
                        color: Colors.black,
                        fontSize: 20.sp,
                        fontWeight: FontWeight.bold),
                    children: <TextSpan>[
                  const TextSpan(text: "300,0000 AED"),
                  TextSpan(
                    text: ' / year',
                    style: style2.copyWith(
                      color: Colors.black,
                      fontSize: 18.sp,
                    ),
                  ),
                ])),
          )
        ],
      ),
    );
  }
}
