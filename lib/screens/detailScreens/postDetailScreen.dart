import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:crypto_estate_tech/common/ColorConstants.dart';
import 'package:crypto_estate_tech/common/own_methods.dart';
import 'package:crypto_estate_tech/common/rangeUtils.dart';
import 'package:crypto_estate_tech/common/widgetConstants.dart';
import 'package:crypto_estate_tech/model/postModel.dart';
import 'package:crypto_estate_tech/provider/authProvider.dart';
import 'package:crypto_estate_tech/provider/likesProvider.dart';
import 'package:crypto_estate_tech/provider/XfileProvider.dart';
import 'package:crypto_estate_tech/screens/bottomNavigation/explore/demy.dart';
import 'package:crypto_estate_tech/screens/detailScreens/detailsContainer.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'package:crypto_estate_tech/provider/authProvider.dart';
import 'package:crypto_estate_tech/provider/walletProvider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class postDetailScreen extends StatefulWidget {
  final PostModel postModel;
  final String postId;
  const postDetailScreen(
      {super.key, required this.postModel, required this.postId});

  @override
  State<postDetailScreen> createState() => _postDetailScreenState();
}

class _postDetailScreenState extends State<postDetailScreen> {
  final CarouselController carouselController = CarouselController();
  bool _isOfferSubmitted = false;
  bool _isOfferAccepted =
      false; // This should be set based on your logic when the offer is accepted

  int currentIndex = 0;
  void _showThirdModalBottomSheet(BuildContext context) {
    TextEditingController offerController = TextEditingController();

    showModalBottomSheet(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(25.0),
        ),
      ),
      context: context,
      builder: (context) {
        return Container(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(height: 20.h),
              Center(
                child: Container(
                  width: 50.w,
                  height: 5,
                  decoration: BoxDecoration(
                    color: Color(0xFFD9D9D9),
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                ),
              ),
              SizedBox(height: 20.h),
              if (!_isOfferSubmitted) ...[
                TextField(
                  controller: offerController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: 'Enter your offer',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15.r),
                    ),
                  ),
                ),
                SizedBox(height: 20.h),
                GestureDetector(
                  onTap: () async {
                    String offer = offerController.text.trim();
                    if (offer.isNotEmpty) {
                      await _saveOfferToDatabase(widget.postId, offer);
                      setState(() {
                        _isOfferSubmitted = true;
                      });
                      Navigator.pop(context);
                    } else {
                      Fluttertoast.showToast(
                          msg: "Please enter an offer amount");
                    }
                  },
                  child: Container(
                    height: 50.h,
                    padding: EdgeInsets.symmetric(horizontal: 20.w),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [mainAppColor, Colors.black],
                      ),
                      borderRadius: BorderRadius.circular(15.r),
                    ),
                    child: Text(
                      "Make Offer",
                      style: style2.copyWith(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: 16.sp,
                      ),
                    ),
                  ),
                ),
              ] else if (_isOfferAccepted) ...[
                SizedBox(height: 20.h),
                GestureDetector(
                  onTap: () {
                    // Handle buy action
                  },
                  child: Container(
                    height: 50.h,
                    padding: EdgeInsets.symmetric(horizontal: 20.w),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [mainAppColor, Colors.black],
                      ),
                      borderRadius: BorderRadius.circular(15.r),
                    ),
                    child: Text(
                      "Buy",
                      style: style2.copyWith(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: 16.sp,
                      ),
                    ),
                  ),
                ),
              ] else ...[
                SizedBox(height: 20.h),
                Text(
                  "Your offer has been submitted, please wait for acceptance.",
                  style: TextStyle(color: Colors.green, fontSize: 16.sp),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 20.h),
              ],
            ],
          ),
        );
      },
    );
  }

  Future<void> _saveOfferToDatabase(String postId, String offer) async {
    String userId = FirebaseAuth.instance.currentUser!.uid;
    Map<String, dynamic> offerData = {
      'userId': userId,
      'status': 'pending',
      'offer': offer,
    };

    try {
      await FirebaseFirestore.instance.collection('posts').doc(postId).update({
        'offers': FieldValue.arrayUnion([offerData]),
      }).then((_) {
        Fluttertoast.showToast(
            msg: "Your offer has been submitted, please wait for acceptance.");
        setState(() {
          _isOfferSubmitted = true;
        });
      }).catchError((error) {
        Fluttertoast.showToast(msg: "Failed to submit offer: $error");
      });
    } catch (e) {
      Fluttertoast.showToast(msg: "An error occurred: $e");
    }
  }

  void _showSecondModalBottomSheet(BuildContext context) {
    showModalBottomSheet(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(25.0),
        ),
      ),
      context: context,
      builder: (context) {
        return Container(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Column(
            children: [
              SizedBox(height: 20.h),
              Center(
                child: Container(
                  width: 50.w,
                  height: 5,
                  decoration: BoxDecoration(
                    color: Color(0xFFD9D9D9),
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                ),
              ),
              SizedBox(height: 20.h),
              GestureDetector(
                onTap: () {
                  try {
                    launchUrlString(
                        'whatsapp://send?phone=+11111&text=${Uri.encodeFull('testApp')}');
                  } catch (e) {
                    print('Error Launching WhatsApp');
                  }
                },
                child: Container(
                  height: 50.h,
                  padding: EdgeInsets.symmetric(horizontal: 24.w),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [mainAppColor, Colors.black],
                    ),
                    borderRadius: BorderRadius.circular(15.r),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: 30.w,
                        height: 30.h,
                        child: Image.asset('assets/images/whatsapp.png'),
                      ),
                      SizedBox(width: 20.w),
                      Expanded(
                        child: Text(
                          "Contact via Whatsapp",
                          style: style2.copyWith(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontSize: 16.sp,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 20.h),
              GestureDetector(
                onTap: () {
                  OwnMethods().openMail('test@gmail.com');
                },
                child: Container(
                  height: 50.h,
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [mainAppColor, Colors.black],
                    ),
                    borderRadius: BorderRadius.circular(15.r),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: 30.w,
                        height: 30.h,
                        child: Icon(
                          Icons.email_outlined,
                          color: Colors.white,
                          size: 32.h,
                        ),
                      ),
                      SizedBox(width: 20.w),
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.transparent),
                          ),
                          child: Text(
                            "Connect via Email",
                            style: style2.copyWith(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              fontSize: 16.sp,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 20.h),
              GestureDetector(
                onTap: () {
                  OwnMethods().makePhoneCall('+1111111');
                },
                child: Container(
                  height: 50.h,
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [mainAppColor, Colors.black],
                    ),
                    borderRadius: BorderRadius.circular(15.r),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: 30.w,
                        height: 30.h,
                        child: Icon(
                          Icons.phone,
                          color: Colors.white,
                          size: 32.h,
                        ),
                      ),
                      SizedBox(width: 20.w),
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.transparent),
                          ),
                          child: Text(
                            "Make a Phone Call",
                            style: style2.copyWith(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              fontSize: 16.sp,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) =>
      OrientationBuilder(builder: (context, orientation) {
        final filterProvider =
            Provider.of<PostLikesProvider>(context, listen: true);

        String currentUserId = FirebaseAuth
            .instance.currentUser!.uid; // Replace with actual user ID
        final fileProvider = Provider.of<XFileProvider>(context, listen: true);
        final authProvider = Provider.of<AuthProviderr>(context, listen: true);
        final w3mServiceProvider = Provider.of<W3MServiceProvider>(context);
        return Scaffold(
          body: SingleChildScrollView(
            child: Column(
              children: [
                Hero(
                    tag: "image_tag",
                    child: SizedBox(
                      height: MediaQuery.of(context).size.height,
                      child: Stack(
                        children: [
                          CarouselSlider.builder(
                            carouselController: carouselController,
                            options: CarouselOptions(
                                height:
                                    MediaQuery.of(context).size.height * 0.45,
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
                              final urlImage =
                                  widget.postModel.propertyPhotos![index];
                              return SizedBox(
                                width: MediaQuery.of(context).size.width,
                                height: MediaQuery.of(context).orientation ==
                                        Orientation.portrait
                                    ? MediaQuery.of(context).size.height * 0.4
                                    : MediaQuery.of(context).size.height * 0.7,
                                child: CachedNetworkImage(
                                  key: UniqueKey(),
                                  imageUrl: urlImage!,
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
                            },
                          ),
                          Align(
                            alignment: Alignment.topCenter,
                            child: Padding(
                                padding: EdgeInsets.only(
                                    top: MediaQuery.of(context).size.height *
                                        0.35),
                                child: buildIndicator(currentIndex,
                                    widget.postModel.propertyPhotos!.length)),
                          ),
                          Align(
                            alignment: Alignment.topLeft,
                            child: Padding(
                              padding: EdgeInsets.only(
                                  top: 35.h, left: 10.h, right: 10.h),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.pop(context);
                                    },
                                    child: Container(
                                      height: 40.h,
                                      width: 40.h,
                                      alignment: Alignment.center,
                                      decoration: const BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Colors.white,
                                      ),
                                      child: Icon(
                                        Icons.arrow_back_outlined,
                                        color: const Color(0xff444444),
                                        size: 25.h,
                                      ),
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      Container(
                                        height: 40.h,
                                        width: 40.h,
                                        alignment: Alignment.center,
                                        decoration: const BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: Colors.white),
                                        child: IconButton(
                                            padding: EdgeInsets.zero,
                                            onPressed: () {
                                              Share.share('${widget.postId}');
                                            },
                                            icon: Icon(
                                              Icons.share_rounded,
                                              color: const Color(0xff444444),
                                              size: 25.h,
                                            )),
                                      ),
                                      SizedBox(
                                        width: 10.w,
                                      ),
                                      Container(
                                          height: 40.h,
                                          width: 40.h,
                                          alignment: Alignment.center,
                                          decoration: const BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: Colors.white),
                                          child: IconButton(
                                              padding: EdgeInsets.zero,
                                              onPressed: () {
                                                filterProvider.toggleLike(
                                                    widget.postId,
                                                    currentUserId);
                                              },
                                              icon: Consumer<PostLikesProvider>(
                                                builder:
                                                    (context, provider, _) {
                                                  return Icon(
                                                    provider.likedPostIds
                                                            .contains(
                                                                widget.postId)
                                                        ? Icons.favorite
                                                        : Icons.favorite_border,
                                                    color: provider.likedPostIds
                                                            .contains(
                                                                widget.postId)
                                                        ? Colors.red
                                                        : Colors.grey,
                                                    size: 30.0,
                                                  );
                                                },
                                              )))
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                                top: MediaQuery.of(context).size.height * 0.3,
                                right: 10.h),
                            child: Align(
                              alignment: Alignment.topRight,
                              child: Container(
                                width: 120.w,
                                height: 60.h,
                                decoration: const BoxDecoration(
                                    // color: Colors.amber
                                    ),
                                child: Column(
                                  children: [
                                    Container(
                                      height: 25.h,
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(10.r)),
                                      child: Text(
                                        "360° Virtual Tour",
                                        style: style.copyWith(
                                          color: Colors.black,
                                          fontSize: MediaQuery.of(context)
                                                      .orientation ==
                                                  Orientation.portrait
                                              ? 12.sp
                                              : 8.sp,
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 10.h,
                                    ),
                                    Container(
                                      // width: 60.h,
                                      height: 25.h,
                                      margin: EdgeInsets.only(
                                          left: 25.w, right: 15.w),
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(10.r)),
                                      child: Text(
                                        "MetaVerse",
                                        style: style.copyWith(
                                            color: Colors.black,
                                            fontSize: 12.sp),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Align(
                              alignment: Alignment.bottomCenter,
                              child:
                                  DetailsContainer(postModel: widget.postModel))
                        ],
                      ),
                    )),
              ],
            ),
          ),
          bottomNavigationBar: Container(
            height: MediaQuery.of(context).orientation == Orientation.portrait
                ? 60.h
                : 90.h,
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2), // Shadow color
                  spreadRadius: 1, // Spread radius
                  blurRadius: 5, // Blur radius
                  offset: const Offset(0, -4), // Offset to move the shadow up
                ),
              ],
              color: Colors.white,
            ),
            padding: EdgeInsets.only(
                left: 20.h, right: 20.h, top: 10.h, bottom: 10.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    RichText(
                      text: TextSpan(
                        style: style2.copyWith(
                            fontSize: 16.sp,
                            color: const Color(0xff3A3153),
                            fontWeight: FontWeight.bold),
                        children: <TextSpan>[
                          // TextSpan(
                          //     text: Utils.convertCurrency(
                          //         "${widget.postModel.amount}",
                          //         fileProvider.currency,
                          //         authProvider.eth,
                          //         authProvider.btc)),
                          // TextSpan(
                          //   text: '${fileProvider.currency}',
                          // ),
                          TextSpan(
                            text: ' / year',
                            style: style2.copyWith(
                              fontSize: MediaQuery.of(context).orientation ==
                                      Orientation.portrait
                                  ? 15.sp
                                  : 8.sp,
                              color: const Color(0xff3A3153),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Text(
                      "*Prices may very",
                      style: style2.copyWith(
                          fontSize: MediaQuery.of(context).orientation ==
                                  Orientation.portrait
                              ? 12.sp
                              : 8.sp,
                          color: const Color(0xff4E4A59)),
                    )
                  ],
                ),
                GestureDetector(
                  onTap: () {
                    showModalBottomSheet(
                        shape: const RoundedRectangleBorder(
                            // <-- SEE HERE
                            borderRadius: BorderRadius.vertical(
                          top: Radius.circular(25.0),
                        )),
                        context: context,
                        builder: ((context) {
                          return Container(
                            padding: EdgeInsets.symmetric(horizontal: 20.w),
                            child: Column(
                              children: [
                                SizedBox(
                                  height: MediaQuery.of(context).orientation ==
                                          Orientation.portrait
                                      ? 20.h
                                      : 10.h,
                                ),
                                Center(
                                  child: Container(
                                    width: 50.w,
                                    height:
                                        MediaQuery.of(context).orientation ==
                                                Orientation.portrait
                                            ? 5
                                            : 10,
                                    decoration: BoxDecoration(
                                        color: Color(0xFFD9D9D9),
                                        borderRadius:
                                            BorderRadius.circular(10.r)),
                                  ),
                                ),
                                SizedBox(
                                  height: 20.h,
                                ),
                                GestureDetector(
                                  onTap: () {
                                    _showSecondModalBottomSheet(context);
                                  },
                                  child: Container(
                                    height: 50.h,
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 20.w),
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                        gradient: const LinearGradient(
                                            begin: Alignment.topCenter,
                                            end: Alignment.bottomCenter,
                                            colors: [
                                              mainAppColor,
                                              Colors.black
                                            ]),
                                        borderRadius:
                                            BorderRadius.circular(15.r)),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Container(
                                            width: 30.w,
                                            height: 30.h,
                                            child: Icon(
                                              Icons.phone,
                                              color: Colors.white,
                                              size: 32.h,
                                            )),
                                        SizedBox(
                                          width: 20.w,
                                        ),
                                        Expanded(
                                          child: Container(
                                            //  width: 175.w,
                                            decoration: BoxDecoration(
                                                border: Border.all(
                                                    color: Colors.transparent)),
                                            child: Text(
                                              "Contact",
                                              style: style2.copyWith(
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.white,
                                                  fontSize: MediaQuery.of(
                                                                  context)
                                                              .orientation ==
                                                          Orientation.portrait
                                                      ? 16.sp
                                                      : 8.sp),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 20.h,
                                ),
                                GestureDetector(
                                  onTap: () {
                                    Navigator.pop(context);
                                    Fluttertoast.showToast(
                                        msg: 'You booked Successfully');
                                  },
                                  child: Container(
                                    height: 50.h,
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 20.w),
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                        gradient: const LinearGradient(
                                            begin: Alignment.topCenter,
                                            end: Alignment.bottomCenter,
                                            colors: [
                                              mainAppColor,
                                              Colors.black
                                            ]),
                                        borderRadius:
                                            BorderRadius.circular(15.r)),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Container(
                                            width: 30.w,
                                            height: 30.h,
                                            child: Icon(
                                              Icons.edit_calendar_outlined,
                                              color: Colors.white,
                                              size: 32.h,
                                            )),
                                        SizedBox(
                                          width: 20.w,
                                        ),
                                        Expanded(
                                          child: Container(
                                            //  width: 175.w,
                                            decoration: BoxDecoration(
                                                border: Border.all(
                                                    color: Colors.transparent)),
                                            child: Text(
                                              "Book a visit to the location",
                                              style: style2.copyWith(
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.white,
                                                  fontSize: MediaQuery.of(
                                                                  context)
                                                              .orientation ==
                                                          Orientation.portrait
                                                      ? 16.sp
                                                      : 8.sp),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 20.h,
                                ),
                                GestureDetector(
                                  onTap: () {
                                    // w3mServiceProvider.connect(context);

                                    _showThirdModalBottomSheet(context);
                                  },
                                  child: Container(
                                    height: 50.h,
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 20.w),
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                        gradient: const LinearGradient(
                                            begin: Alignment.topCenter,
                                            end: Alignment.bottomCenter,
                                            colors: [
                                              mainAppColor,
                                              Colors.black
                                            ]),
                                        borderRadius:
                                            BorderRadius.circular(15.r)),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Container(
                                            width: 30.w,
                                            height: 30.h,
                                            child: Icon(
                                              Icons.edit_calendar_outlined,
                                              color: Colors.white,
                                              size: 32.h,
                                            )),
                                        SizedBox(
                                          width: 20.w,
                                        ),
                                        Expanded(
                                          child: Container(
                                            //  width: 175.w,
                                            decoration: BoxDecoration(
                                                border: Border.all(
                                                    color: Colors.transparent)),
                                            child: Text(
                                              "Buy ",
                                              style: style2.copyWith(
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.white,
                                                  fontSize: MediaQuery.of(
                                                                  context)
                                                              .orientation ==
                                                          Orientation.portrait
                                                      ? 16.sp
                                                      : 8.sp),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 20.h,
                                ),
                                Container(
                                  height: 50.h,
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 20.w),
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                      gradient: const LinearGradient(
                                          begin: Alignment.topCenter,
                                          end: Alignment.bottomCenter,
                                          colors: [mainAppColor, Colors.black]),
                                      borderRadius:
                                          BorderRadius.circular(15.r)),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Container(
                                          width: 30.w,
                                          height: 30.h,
                                          child: Icon(
                                            Icons.person_outline,
                                            color: Colors.white,
                                            size: 32.h,
                                          )),
                                      SizedBox(
                                        width: 20.w,
                                      ),
                                      Expanded(
                                        child: Container(
                                          //  width: 175.w,
                                          decoration: BoxDecoration(
                                              border: Border.all(
                                                  color: Colors.transparent)),
                                          child: Text(
                                            "Visit the user profile",
                                            style: style2.copyWith(
                                                fontWeight: FontWeight.bold,
                                                color: Colors.white,
                                                fontSize: MediaQuery.of(context)
                                                            .orientation ==
                                                        Orientation.portrait
                                                    ? 16.sp
                                                    : 8.sp),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          );
                        }));
                  },
                  child: Container(
                    height: 40.h,
                    width: 150.h,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        gradient: const LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [mainAppColor, Colors.black]),
                        borderRadius: BorderRadius.circular(15.r)),
                    child: Text(
                      "I'm interested",
                      style: style2.copyWith(
                        color: Colors.white,
                        fontSize: MediaQuery.of(context).orientation ==
                                Orientation.portrait
                            ? 15.sp
                            : 8.sp,
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        );
      });
}
