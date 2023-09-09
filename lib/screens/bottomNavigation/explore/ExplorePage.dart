// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import 'package:crypto_estate_tech/common/ColorConstants.dart';
import 'package:crypto_estate_tech/common/widgetConstants.dart';
import 'package:crypto_estate_tech/screens/bottomNavigation/explore/BestOffer.dart';

class ExplorePage extends StatefulWidget {
  const ExplorePage({
    Key? key,
  }) : super(key: key);

  @override
  State<ExplorePage> createState() => _ExplorePageState();
}

class _ExplorePageState extends State<ExplorePage>
    with TickerProviderStateMixin {
  TabController? _tabController;
  int currentIndex = 0;
  @override
  void initState() {
    super.initState();
    _tabController = TabController(
        length: 4, vsync: this); // Change the length to 4 if you want four tabs

    _tabController!.addListener(_handleTabChange);
  }

  @override
  void dispose() {
    _tabController?.dispose();
    super.dispose();
  }

  void _handleTabChange() {
    setState(() {
      currentIndex = _tabController!.index;
    });
  }

  int currentViewIndex = 0;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return SafeArea(
      child: Column(
        children: [
          SizedBox(
            height: 10.h,
          ),
          Container(
            padding: EdgeInsets.only(left: 10.w, right: 20.w),
            child: Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, searchScreen);
                    },
                    child: Container(
                      padding: EdgeInsets.only(left: 10.w, right: 20.h),
                      height: size.height * 0.08,
                      decoration: BoxDecoration(
                          border: Border.all(color: Shade2purple),
                          borderRadius: BorderRadius.circular(30.r)),
                      child: Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            GestureDetector(
                              onTap: () {
                                print("moving to search page");
                                Navigator.pushNamed(context, searchScreen);
                              },
                              child: SvgPicture.asset(
                                "assets/images/search_icon.svg",
                                height: 25.h,
                                width: 25.h,
                                color: unselectedBoNaBColor,
                              ),
                            ),
                            SizedBox(
                              width: 10.w,
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "I'm looking for",
                                    style: style.copyWith(
                                        color: Shade2purple,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 15.sp),
                                  ),
                                  Text(
                                    "Appartment,Studio,Office",
                                    style: style.copyWith(
                                        color: Shade2purple.withOpacity(0.7),
                                        fontWeight: FontWeight.w200,
                                        fontSize: 12.sp),
                                  )
                                ],
                              ),
                            ),
                            SvgPicture.asset(
                              "assets/images/menu_icon.svg",
                              color: Shade2purple,
                              height: 18.h,
                              width: 18.h,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 10.h,
                ),
                Container(
                  height: size.width * 0.12,
                  width: size.width * 0.12,
                  padding: EdgeInsets.all(10.h),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: Shade2purple,
                    ),
                  ),
                  child: SvgPicture.asset(
                    "assets/images/bell_line_icon.svg",
                    color: Shade2purple,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 7.h,
          ),
          Container(
            child: Stack(
              alignment: Alignment.bottomCenter,
              children: [
                Divider(
                  // Add the divider widget here
                  color: Colors.grey,
                  height: 2,
                  thickness: 2,
                ),
                Padding(
                  padding: EdgeInsets.only(left: 10.h, right: 10.h),
                  child: TabBar(
                    indicatorColor: Shade2purple,

                    onTap: (index) {
                      setState(() {
                        currentIndex = index;
                      });
                    },
                    labelStyle: style.copyWith(fontSize: 14.sp),
                    padding: EdgeInsets.zero,
                    labelColor:
                        Shade2purple, // Set the text color of the selected tab
                    unselectedLabelColor:
                        unselectedTabcolor, // Set the text color of unselected tabs
                    controller: _tabController,
                    indicatorWeight: 3.0,
                    labelPadding: EdgeInsets.zero,

                    tabs: [
                      Tab(
                        text: 'Best offers',
                        icon: SvgPicture.asset(
                          "assets/images/bxs_offer_icon.svg",
                          height: 30.h,
                          width: 30.h,
                          color: currentIndex == 0
                              ? Shade2purple
                              : unselectedTabcolor,
                        ),
                        iconMargin: EdgeInsets.zero,
                      ),
                      Tab(
                        text: 'Trending',
                        icon: SvgPicture.asset(
                          "assets/images/trending_icon.svg",
                          height: 30.h,
                          width: 30.h,
                          color: currentIndex == 1
                              ? Shade2purple
                              : unselectedTabcolor,
                        ),
                        iconMargin: EdgeInsets.zero,
                      ),
                      Tab(
                        text: 'Latest',
                        icon: SvgPicture.asset(
                          "assets/images/time_icon.svg",
                          height: 30.h,
                          width: 30.h,
                          color: currentIndex == 2
                              ? Shade2purple
                              : unselectedTabcolor,
                        ),
                        iconMargin: EdgeInsets.zero,
                      ),
                      Tab(
                        text: 'Off-plan',
                        icon: SvgPicture.asset(
                          "assets/images/plan_icon.svg",
                          height: 30.h,
                          width: 30.h,
                          color: currentIndex == 3
                              ? Shade2purple
                              : unselectedTabcolor,
                        ),
                        iconMargin: EdgeInsets.zero,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 8.h,
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10.w),
            child: Row(
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
          ),
          SizedBox(
            height: 10.h,
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                // Widget for Explore tab
                BestOffers(
                  postFeature: bestofferPf,
                  currentViewIndex: currentViewIndex,
                ),
                // Widget for Wishlist tab
                BestOffers(
                    postFeature: trendingPf,
                    currentViewIndex: currentViewIndex),
                // Widget for Inbox tab
                BestOffers(
                    postFeature: latestPf, currentViewIndex: currentViewIndex),

                BestOffers(
                    postFeature: offPlan, currentViewIndex: currentViewIndex),
              ],
            ),
          ),
        ],
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
