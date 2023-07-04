import 'package:crypto_estate_tech/common/ColorConstants.dart';
import 'package:crypto_estate_tech/screens/bottomNavigation/explore/PostWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class BestOffers extends StatefulWidget {
  const BestOffers({super.key});

  @override
  State<BestOffers> createState() => _BestOffersState();
}

class _BestOffersState extends State<BestOffers> {
  int currentViewIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              children: [
                ViewIconContainer(
                    isSelected: currentViewIndex == 0 ? true : false,
                    child: SvgPicture.asset("assets/images/grid_icon.svg",
                        color: currentViewIndex == 0
                            ? Shade2purple
                            : unselectedTabcolor),
                    onTap: () {
                      setState(() {
                        currentViewIndex = 0;
                      });
                    }),
                SizedBox(
                  width: 10.w,
                ),
                ViewIconContainer(
                    isSelected: currentViewIndex == 1 ? true : false,
                    child: SvgPicture.asset(
                        "assets/images/horizontal_lines_icon.svg",
                        color: currentViewIndex == 1
                            ? Shade2purple
                            : unselectedTabcolor),
                    onTap: () {
                      setState(() {
                        currentViewIndex = 1;
                      });
                    }),
                Expanded(child: SizedBox()),
                Container(
                    padding: EdgeInsets.all(7.h),
                    height: 50.h,
                    width: 60.h,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: unselectedTabcolor,
                            blurRadius: 4,
                            offset: Offset(0, 5), // Shadow position
                          ),
                        ],
                        border: Border.all(color: Shade2purple),
                        borderRadius: BorderRadius.circular(10.r)),
                    child: SvgPicture.asset("assets/images/dollar_icon.svg"))
              ],
            ),
            Post(),
          ],
        ),
      ),
    );
  }

  Widget ViewIconContainer(
      {required Widget child,
      required VoidCallback onTap,
      required bool isSelected}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
          padding: EdgeInsets.all(5.h),
          height: 50.h,
          width: 60.h,
          decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: unselectedTabcolor,
                  blurRadius: 4,
                  offset: Offset(0, 5), // Shadow position
                ),
              ],
              color: Colors.white,
              border: Border.all(
                  color: isSelected ? Shade2purple : unselectedTabcolor),
              borderRadius: BorderRadius.circular(10.r)),
          child: child),
    );
  }
}
