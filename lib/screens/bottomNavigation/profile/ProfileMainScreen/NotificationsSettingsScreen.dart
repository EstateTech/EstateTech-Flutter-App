import 'package:crypto_estate_tech/common/ColorConstants.dart';
import 'package:crypto_estate_tech/common/widgetConstants.dart';
import 'package:crypto_estate_tech/screens/bottomNavigation/profile/ProfileMainScreen/loginSecurityScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class NotificationSettingsScreen extends StatefulWidget {
  const NotificationSettingsScreen({super.key});

  @override
  State<NotificationSettingsScreen> createState() =>
      _NotificationSettingsScreenState();
}

class _NotificationSettingsScreenState
    extends State<NotificationSettingsScreen> {
  bool switchNewPost = false;
  bool switchNewPropertyUpdates = false;
  bool switchNewfollowers = false;
  bool switchNewbestSellers = false;
  bool switchNewbestOffers = false;
  bool switchmessages = false;
  bool switchlikes = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(left: 20.h),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 70.h,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Icon(
                  Icons.arrow_back,
                  size: 40.h,
                  color: Colors.black54,
                ),
              ),
              SizedBox(
                height: 30.h,
              ),
              Padding(
                padding: EdgeInsets.only(left: 10.h),
                child: Text(
                  "Notifications Settings",
                  style: style.copyWith(
                      fontSize: 25.sp,
                      color: Shade2purple,
                      fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(
                height: 30.h,
              ),
              Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "On Login",
                        style: style.copyWith(
                            fontSize: 20.sp,
                            color: Shade2purple,
                            fontWeight: FontWeight.bold),
                      ),
                      Text(
                        "Activated",
                        style: numberStyle.copyWith(
                            color: Colors.grey, fontSize: 15.sp),
                      ),
                    ],
                  )
                ],
              ),
              SizedBox(
                height: 20.h,
              ),
              VerifyOptions(
                  "On new posts",
                  switchNewPost ? "Activated" : "Deactivated",
                  switchNewPost, (p0) {
                setState(() {
                  switchNewPost = p0;
                });
              }),
              VerifyOptions(
                  "On property updates",
                  switchNewPropertyUpdates ? "Activated" : "Deactivated",
                  switchNewPropertyUpdates, (p0) {
                setState(() {
                  switchNewPropertyUpdates = p0;
                });
              }),
              VerifyOptions(
                  "On new followers",
                  switchNewfollowers ? "Activated" : "Deactivated",
                  switchNewfollowers, (p0) {
                setState(() {
                  switchNewfollowers = p0;
                });
              }),
              VerifyOptions(
                  "On new bestsellers",
                  switchNewbestSellers ? "Activated" : "Deactivated",
                  switchNewbestSellers, (p0) {
                setState(() {
                  switchNewbestSellers = p0;
                });
              }),
              VerifyOptions(
                  "On new best offers",
                  switchNewbestOffers ? "Activated" : "Deactivated",
                  switchNewbestOffers, (p0) {
                setState(() {
                  switchNewbestOffers = p0;
                });
              }),
              VerifyOptions(
                  "On messages",
                  switchmessages ? "Activated" : "Deactivated",
                  switchmessages, (p0) {
                setState(() {
                  switchmessages = p0;
                });
              }),
              VerifyOptions("On likes",
                  switchlikes ? "Activated" : "Deactivated", switchlikes, (p0) {
                setState(() {
                  switchlikes = p0;
                });
              }),
            ],
          ),
        ),
      ),
    );
  }

  Widget VerifyOptions(String heading, String verifyStatus, bool switchvalue,
      void Function(bool) onChanged) {
    return Padding(
      padding: EdgeInsets.only(right: 30.h, bottom: 20.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  heading,
                  style: style.copyWith(
                      fontSize: 20.sp,
                      color: Shade2purple,
                      fontWeight: FontWeight.bold),
                ),
                Text(
                  verifyStatus,
                  style:
                      numberStyle.copyWith(color: Colors.grey, fontSize: 15.sp),
                )
              ],
            ),
          ),
          CustomSwitch2(
            value: switchvalue,
            onChanged: onChanged,
          ),
        ],
      ),
    );
  }
}
