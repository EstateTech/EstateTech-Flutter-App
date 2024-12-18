import 'package:crypto_estate_tech/common/ColorConstants.dart';
import 'package:crypto_estate_tech/common/custom_create_post_header.dart';
import 'package:crypto_estate_tech/common/custom_post_create_bottom.dart';
import 'package:crypto_estate_tech/common/widgetConstants.dart';
import 'package:crypto_estate_tech/model/postModel.dart';
import 'package:crypto_estate_tech/screens/bottomNavigation/profile/AddPropertyScreens/propertyTypeScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../bottomNavigation/profile/AddPropertyScreens/amenitiesScreen.dart';

class WalkThroughScreenPost2 extends StatefulWidget {
  final bool isStep2;
  final PostModel postmodel;
  final  bool  isEdited ;
  const WalkThroughScreenPost2(
      {super.key, this.isStep2 = false, required this.postmodel, required this.isEdited});

  @override
  State<WalkThroughScreenPost2> createState() => _WalkThroughScreenPost2State();
}

class _WalkThroughScreenPost2State extends State<WalkThroughScreenPost2> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        height: size.height,
        width: size.width,
        padding: EdgeInsets.only(top: 50.h, left: 20.h),
        decoration: const BoxDecoration(
          gradient: appBackgroundGradient,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            const CustomCreatePostHeader(),
            Text(
              "It’s easy to get started on CET",
              style: style.copyWith(
                  fontSize: 30.sp,
                  color: textwalktrough,
                  fontWeight: FontWeight.w600),
            ),
            Center(
              child: Container(
                height: 250.h,
                width: 250.h,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: widget.isStep2
                            ? const AssetImage("assets/images/living_room2.png")
                            : const AssetImage("assets/images/living_room.png"),
                        fit: BoxFit.contain)),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.isStep2 ? "Step 2" : "Step 1",
                  style: style.copyWith(color: textwalktrough),
                ),
                Text(
                  widget.isStep2
                      ? "Make your property stand out"
                      : "Tell us about your property",
                  style: style.copyWith(
                      color: textwalktrough,
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w700),
                ),
                SizedBox(
                  height: 10.h,
                ),
                SizedBox(
                  height: 150.h,
                  width: 250.h,
                  child: Text(
                    widget.isStep2
                        ? "In this step, you’ll add some amenities your property offers, photos of it, then a title and description."
                        : "In this step, we’ll ask you which type of property you have, where it is located, and some technical info about it.",
                    style:
                        style.copyWith(color: textwalktrough, fontSize: 18.sp),
                  ),
                ),
                Padding(
                  padding:
                      EdgeInsets.only(right: 12.h, left: 12.h, bottom: 30.h),
                  child: customPostCreateBottomWidget(
                    OnPressedNextButton: () {
                      widget.isStep2
                          ? Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => AmenitiesScreen(
                                        postmodel: widget.postmodel,
                                        isEdited : widget.isEdited
                                      )))
                          : Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                       PropertyTypeScreen(
                                        postModel:  PostModel(),


                                       )));
                    },
                    OnPressedbackButton: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
