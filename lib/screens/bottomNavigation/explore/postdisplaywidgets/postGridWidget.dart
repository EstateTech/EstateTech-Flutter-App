import 'package:cached_network_image/cached_network_image.dart';
import 'package:crypto_estate_tech/common/ColorConstants.dart';
import 'package:crypto_estate_tech/common/rangeUtils.dart';
import 'package:crypto_estate_tech/common/widgetConstants.dart';
import 'package:crypto_estate_tech/helperclass/dataFromFirestore.dart';
import 'package:crypto_estate_tech/model/postModel.dart';
import 'package:crypto_estate_tech/provider/XfileProvider.dart';
import 'package:crypto_estate_tech/provider/authProvider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:crypto_estate_tech/provider/cryptoProvider.dart';
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
  @override
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
    final cryptoProvider = Provider.of<CryptoProvider>(context, listen: false);

    cryptoProvider.fetchEthPrice();
    cryptoProvider.fetchBtcPrice();
  }

  @override
  Widget build(BuildContext context) {
    final filterProvider =
        Provider.of<PostLikesProvider>(context, listen: true);
    final authProvider = Provider.of<AuthProviderr>(context, listen: true);
    final cryptoProvider = Provider.of<CryptoProvider>(context, listen: false);
    String currentUserId =
        FirebaseAuth.instance.currentUser!.uid; // Replace with actual user ID
    filterProvider.initializeLikedPostIds(currentUserId);

    final fileProvider = Provider.of<XFileProvider>(context, listen: true);
    return Container(
      height: 330.h,
      margin: EdgeInsets.symmetric(horizontal: 10.h),

      // width: 150.w,

      decoration: const BoxDecoration(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.transparent)),
                  height: 130.h,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(14.r),
                    child: CachedNetworkImage(
                      key: UniqueKey(),
                      imageUrl: widget.postModel.propertyPhotos![0]!,
                      fit: BoxFit.fill,
                      placeholder: (context, url) => Container(
                        child: Lottie.asset(
                          'assets/images/loading_animation.json',
                          fit: BoxFit
                              .fill, // Replace with your animation file path

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
                  right: 10.w,
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
                        size: 30.h,
                      );
                    },
                  ))),
            ],
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
                      TextSpan(
                          text: Utils.convertCurrency(
                              widget.postModel.amount == null
                                  ? "300000"
                                  : widget.postModel.amount.toString(),
                              fileProvider.currency,
                              cryptoProvider.ethPrice,
                              cryptoProvider.btcPrice,
                              1.00,
                              1.00,
                              1.00)),
                      //  TextSpan( text: "300 "),

                      // TextSpan(text: "${fileProvider.currency}"),
                      TextSpan(
                        text: widget.postModel.rentalType == 'Rent'
                            ? ""
                            : " / year",
                        style: style2.copyWith(
                            color: Colors.black,
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w600),
                      ),
                    ])),
              ),
            ],
          ),
          SizedBox(
            height: 5.h,
          ),
          Row(
            children: [
              RichText(
                text: TextSpan(
                  style: style.copyWith(
                    color: greyShadeColor,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                  ),
                  children: [
                    TextSpan(
                        text: Utils.convertCurrency(
                            widget.postModel.amount == null
                                ? "300000"
                                : widget.postModel.amount.toString(),
                            fileProvider.currency1,
                            cryptoProvider.ethPrice,
                            cryptoProvider.btcPrice,
                            1.00,
                            1.00,
                            1.00)),
                  ],
                ),
              ),
              SizedBox(
                width: 5.w,
              ),
              Image.network(
                fileProvider.currency1 == 'Eth'
                    ? "https://firebasestorage.googleapis.com/v0/b/grocers-c9010.appspot.com/o/cryptocoins%2Feth.png?alt=media&token=2f5df3fc-48ae-476c-89ec-90afecd907fe"
                    : fileProvider.currency1 == 'Btc'
                        ? 'https://firebasestorage.googleapis.com/v0/b/grocers-c9010.appspot.com/o/cryptocoins%2Fbtc.png?alt=media&token=2f5df3fc-48ae-476c-89ec-90afecd907fe'
                        : fileProvider.currency1 == 'Guds'
                            ? 'https://firebasestorage.googleapis.com/v0/b/estatetech.appspot.com/o/imgonline-com-ua-shape-RxSZsO60yN.png?alt=media&token=d2e74534-636e-46b2-9411-4fb94bd5e197'
                            : fileProvider.currency1 == 'Usdc'
                                ? 'https://firebasestorage.googleapis.com/v0/b/estatetech.appspot.com/o/usd-coin-usdc-logo.png?alt=media&token=0869ea89-b23b-46c5-80e2-0af59d49b9eb'
                                : "",
                width: 25.w,
                height: 25.h,
              ),
              Text(
                widget.postModel.rentalType == 'Rent' ? "" : " / year",
                style: style.copyWith(
                    fontSize: 14.sp,
                    color: Shade2purple,
                    fontWeight: FontWeight
                        .normal // Specify your desired color for "/ year"
                    ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
