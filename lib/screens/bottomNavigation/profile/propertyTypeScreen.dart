// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import 'package:crypto_estate_tech/common/ColorConstants.dart';
import 'package:crypto_estate_tech/common/custom_create_post_header.dart';
import 'package:crypto_estate_tech/common/custom_post_create_bottom.dart';
import 'package:crypto_estate_tech/common/list_constants.dart';
import 'package:crypto_estate_tech/screens/bottomNavigation/profile/propertyTypeGridWidget.dart';

import '../../../common/widgetConstants.dart';

class PropertyTypeScreen extends StatefulWidget {
  final bool isMorePropertyScreen;
  const PropertyTypeScreen({
    Key? key,
    this.isMorePropertyScreen = false,
  }) : super(key: key);

  @override
  State<PropertyTypeScreen> createState() => _PropertyTypeScreenState();
}

class _PropertyTypeScreenState extends State<PropertyTypeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.only(left: 20.h, right: 20.h),
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(gradient: appBackgroundGradient),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            CustomCreatePostHeader(),
            Text(
              "Which of these best describes your property?",
              style: style.copyWith(
                  fontSize: 25.sp,
                  color: textwalktrough,
                  fontWeight: FontWeight.w500),
            ),
            Container(
                height: 400.h,
                width: double.infinity,
                child: PropertyTypeGridWidget(
                  widgetMap: widget.isMorePropertyScreen
                      ? selectPropertyFeaturesMap
                      : selectPropertyTypeMap,
                )),
            Padding(
              padding: EdgeInsets.only(right: 12.h, left: 12.h, bottom: 30.h),
              child: customPostCreateBottomWidget(
                OnPressedNextButton: () {
                  widget.isMorePropertyScreen
                      ? Navigator.pushNamed(context, addPhotoScreen)
                      : Navigator.pushNamed(context, offeredSpaceScreen);
                },
                OnPressedbackButton: () {
                  Navigator.pop(context);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
