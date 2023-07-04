import 'package:crypto_estate_tech/common/ColorConstants.dart';
import 'package:crypto_estate_tech/common/custom_create_post_header.dart';
import 'package:crypto_estate_tech/common/custom_post_create_bottom.dart';
import 'package:crypto_estate_tech/common/widgetConstants.dart';
import 'package:crypto_estate_tech/components/custom_white_box.dart';
import 'package:crypto_estate_tech/screens/bottomNavigation/profile/propertyMappedScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PropertyTextAddressScreen extends StatefulWidget {
  const PropertyTextAddressScreen({super.key});

  @override
  State<PropertyTextAddressScreen> createState() =>
      _PropertyTextAddressScreenState();
}

class _PropertyTextAddressScreenState extends State<PropertyTextAddressScreen> {
  final List<String> hintTexts = [
    "Address line 1",
    "Address line 2 (if applicable)",
    "Address line 3 (if applicable)",
    "City / Village (if applicable)",
    "State/Province/District (if applicable)",
    "Postal Code (if applicable)",
  ];

  final List<TextEditingController> controllers = List.generate(
    6,
    (index) => TextEditingController(),
  );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.only(left: 20.h, right: 20.h, top: 25.h),
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(gradient: appBackgroundGradient),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            CustomCreatePostHeader(),
            // SizedBox(
            //   height: 20.h,
            // ),
            Column(
              children: [
                Text(
                  "Confirm is the address of your property",
                  style: style.copyWith(
                      fontSize: 25.sp,
                      color: textwalktrough,
                      fontWeight: FontWeight.w600),
                ),
                SizedBox(
                  height: 10.h,
                ),
                Text(
                  "Your address is only shared with users after they’ve made a reservation",
                  style: style.copyWith(
                      fontSize: 15.sp,
                      color: textwalktrough,
                      fontWeight: FontWeight.w600),
                ),
              ],
            ),

            AddressInTextFields(),

            Padding(
              padding: EdgeInsets.only(right: 12.h, left: 12.h, bottom: 30.h),
              child: customPostCreateBottomWidget(
                OnPressedNextButton: () {
                  Navigator.pushNamed(context, propertyMappedwithPinScreen);
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

  Widget AddressInTextFields() {
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            height: 50.h,
            margin: EdgeInsets.all(5.h),
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.only(left: 24.h, right: 24.h),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15.r),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "United Arab Emirates(+971)",
                  style: style.copyWith(color: Colors.black, fontSize: 14.sp),
                ),
                Icon(
                  Icons.keyboard_arrow_down_outlined,
                  size: 25.h,
                )
              ],
            ),
          ),
          Column(
            children: List.generate(
              hintTexts.length,
              (index) => CustomWhiteTextField(
                  hintText: hintTexts[index], controller: controllers[index]),
            ),
          )
        ],
      ),
    );
  }

  Container CustomWhiteTextField(
      {required String hintText, required TextEditingController controller}) {
    return Container(
        height: 50.h,
        margin: EdgeInsets.all(5.h),
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.only(left: 24.h, right: 24.h),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15.r),
        ),
        child: TextField(
          controller: controller,
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: style.copyWith(color: textwalktrough, fontSize: 14.sp),
            border: InputBorder.none,
          ),
        ));
  }
}
