// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cached_network_image/cached_network_image.dart';
import 'package:crypto_estate_tech/common/own_methods.dart';
import 'package:crypto_estate_tech/notification/notification_screen.dart';
import 'package:crypto_estate_tech/provider/XfileProvider.dart';
import 'package:crypto_estate_tech/provider/authProvider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import 'package:crypto_estate_tech/common/ColorConstants.dart';
import 'package:crypto_estate_tech/common/widgetConstants.dart';
import 'package:crypto_estate_tech/screens/bottomNavigation/explore/BestOffer.dart';
import 'package:provider/provider.dart';

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
  String? selectedValue;
  String? selectedValue1;

  final List<Map> _list = [
    {
      'id': '1',
      'image':
          'https://firebasestorage.googleapis.com/v0/b/estatetech.appspot.com/o/euro-currency-symbol-for-graphic-and-web-design-vector-removebg-preview.png?alt=media&token=293d2c88-d832-488f-97ae-64c159cb59a8',
      'name': 'EUR'
    },
    {
      'id': '2',
      'image':
          'https://firebasestorage.googleapis.com/v0/b/estatetech.appspot.com/o/united-arab-emirates-dirham-coins-icon-uae-money-currency-clipart-vector-money-free-download-business-finance-web-site-254733725.webp?alt=media&token=b633c13e-d884-46f1-b1d0-0508dca7bef1',
      'name': 'AED'
    },
    {
      'id': '3',
      'image':
          'https://firebasestorage.googleapis.com/v0/b/crypto-estate-tech---app.appspot.com/o/dirham%20(1).png?alt=media&token=bc107daf-79ae-438f-bb38-b5dcf25feb5f&_gl=1*1c13du2*_ga*MzQ5NzczNzQxLjE2OTUzMTUzOTU.*_ga_CW55HF8NVT*MTY5ODMyMDA1OS4xMDUuMS4xNjk4MzIwMDk0LjI1LjAuMA..',
      'name': 'REBL'
    },
  ];

  final List<Map> list1 = [
    {
      'id': '1',
      'image':
          'https://firebasestorage.googleapis.com/v0/b/estatetech.appspot.com/o/imgonline-com-ua-shape-RxSZsO60yN.png?alt=media&token=d2e74534-636e-46b2-9411-4fb94bd5e197',
      'name': 'Guds'
    },
    {
      'id': '2',
      'image':
          'https://firebasestorage.googleapis.com/v0/b/grocers-c9010.appspot.com/o/cryptocoins%2Fbtc.png?alt=media&token=2f5df3fc-48ae-476c-89ec-90afecd907fe',
      'name': 'Btc'
    },
    {
      'id': '3',
      'image':
          'https://firebasestorage.googleapis.com/v0/b/grocers-c9010.appspot.com/o/cryptocoins%2Feth.png?alt=media&token=2f5df3fc-48ae-476c-89ec-90afecd907fe',
      'name': 'Eth'
    },
    {
      'id': '4',
      'image':
          'https://firebasestorage.googleapis.com/v0/b/estatetech.appspot.com/o/usd-coin-usdc-logo.png?alt=media&token=0869ea89-b23b-46c5-80e2-0af59d49b9eb',
      'name': 'Usdc'
    },
  ];

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final fileProvider = Provider.of<XFileProvider>(context, listen: true);
    final authProvider = Provider.of<AuthProviderr>(context, listen: true);
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
                GestureDetector(
                  onTap: () {
                    // Navigator.push(
                    //     context,
                    //     MaterialPageRoute(
                    //         builder: (context) => NotificationScreen()))

                    print(authProvider.eth);
                  },
                  child: Container(
                    height: size.width * 0.10,
                    width: size.width * 0.10,
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
                GestureDetector(
                    onTap: () {
                      showModalBottomSheet(
                          context: context,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.r)),
                          builder: (context) {
                            return StatefulBuilder(
                                builder: (context, setstate1) {
                              return Column(
                                children: [
                                  SizedBox(
                                    height: 20.h,
                                  ),
                                  Text(
                                    'Select Currency Type',
                                    style: style.copyWith(
                                        color: const Color(0xff0D2769),
                                        fontSize: 24.sp,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(
                                    height: 20.h,
                                  ),
                                  Container(
                                    margin:
                                        EdgeInsets.symmetric(horizontal: 22.w),
                                    width: MediaQuery.of(context)
                                        .size
                                        .width, // Set the width of the dropdown as needed
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(
                                          10), // Adjust border radius as needed
                                      border: Border.all(
                                        color: Colors.black, // Border color
                                        width: 0.5, // Border width
                                      ),
                                    ),

                                    child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 8.0),
                                        child: DropdownButtonHideUnderline(
                                          child: ButtonTheme(
                                            alignedDropdown: true,
                                            child: DropdownButton(
                                              hint:
                                                  const Text("Select currency"),
                                              value: selectedValue,
                                              onChanged: (newValue) {
                                                fileProvider.updateCurrency(
                                                    newValue! as String);

                                                fileProvider.updateCurrencySign(fileProvider
                                                            .currency ==
                                                        'USD'
                                                    ? _list[0]['image']
                                                    : fileProvider.currency ==
                                                            'Guds'
                                                        ? _list[0]['image']
                                                        : fileProvider
                                                                    .currency ==
                                                                'Btc'
                                                            ? _list[1]['image']
                                                            : fileProvider
                                                                        .currency ==
                                                                    'Eth'
                                                                ? _list[2]
                                                                    ['image']
                                                                : fileProvider
                                                                            .currency ==
                                                                        'Usdc'
                                                                    ? _list[3][
                                                                        'image']
                                                                    : '');

                                                print(newValue);
                                                setstate1(() {
                                                  selectedValue =
                                                      newValue! as String?;
                                                });
                                              },
                                              items: _list.map((bankItem) {
                                                return DropdownMenuItem(
                                                  value: bankItem['name'],
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: Row(
                                                      children: [
                                                        CachedNetworkImage(
                                                          imageUrl:
                                                              bankItem['image'],
                                                        ),
                                                        Container(
                                                          margin:
                                                              const EdgeInsets
                                                                  .only(
                                                                  left: 10),
                                                          child: Text(
                                                              bankItem['name']),
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                );
                                              }).toList(),
                                            ),
                                          ),
                                        )),
                                  )
                                ],
                              );
                            });
                          });
                    },
                    child: Container(
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
                        child: Image.network(fileProvider.currency == 'USD'
                            ? _list[0]['image']
                            : fileProvider.currency == 'AED'
                                ? _list[1]['image']
                                : fileProvider.currency == 'EUR'
                                    ? _list[2]['image']
                                    : fileProvider.currency == 'RUBL'
                                        ? _list[3]['image']
                                        : ''))),
                SizedBox(
                  width: 5.w,
                ),
                GestureDetector(
                    onTap: () {
                      showModalBottomSheet(
                        context: context,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.r)),
                        builder: (context) {
                          return StatefulBuilder(
                            builder: (context, setstate1) {
                              return Column(
                                children: [
                                  SizedBox(
                                    height: 20.h,
                                  ),
                                  Text(
                                    'Select Crypto Currency Type',
                                    style: style.copyWith(
                                        color: const Color(0xff0D2769),
                                        fontSize: 24.sp,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(
                                    height: 20.h,
                                  ),
                                  Container(
                                    margin:
                                        EdgeInsets.symmetric(horizontal: 22.w),
                                    width: MediaQuery.of(context)
                                        .size
                                        .width, // Set the width of the dropdown as needed
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(
                                          10), // Adjust border radius as needed
                                      border: Border.all(
                                        color: Colors.black, // Border color
                                        width: 0.5, // Border width
                                      ),
                                    ),

                                    child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 8.0),
                                        child: DropdownButtonHideUnderline(
                                          child: ButtonTheme(
                                            alignedDropdown: true,
                                            child: DropdownButton(
                                              hint: const Text(
                                                  "Select crypto currency"),
                                              value: selectedValue1,
                                              onChanged: (newValue) {
                                                fileProvider.updateCurrency1(
                                                    newValue! as String);

                                                fileProvider.updateCurrencySign1(
                                                    newValue! as String == 'USD'
                                                        ? '\$'
                                                        : newValue! as String ==
                                                                'Usdc'
                                                            ? "\د.إ."
                                                            : ""
                                                    // : newValue! as String ==
                                                    //         'Eth'
                                                    //     ? ''
                                                    //     : newValue! as String ==
                                                    //             'Guds'
                                                    //         ? ''
                                                    //         : ''
                                                    // fileProvider.currencySign ==
                                                    //         "\$"
                                                    //     ? "\د.إ."
                                                    //     : '\$'

                                                    //to do here

                                                    );

                                                print(newValue);
                                                setstate1(() {
                                                  selectedValue1 =
                                                      newValue! as String?;
                                                });
                                              },
                                              items: list1.map((bankItem) {
                                                return DropdownMenuItem(
                                                  value: bankItem['name'],
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: Row(
                                                      children: [
                                                        CachedNetworkImage(
                                                          imageUrl:
                                                              bankItem['image'],
                                                        ),
                                                        Container(
                                                          margin:
                                                              const EdgeInsets
                                                                  .only(
                                                                  left: 10),
                                                          child: Text(
                                                              bankItem['name']),
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                );
                                              }).toList(),
                                            ),
                                          ),
                                        )),
                                  )
                                ],
                              );
                            },
                          );
                        },
                      );
                    },
                    child: Container(
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
                        child: Image.network(fileProvider.currency1 == 'Btc'
                            ? list1[0]['image']
                            : list1[1]['image'])))
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
                    postFeature: offPlanPf, currentViewIndex: currentViewIndex),
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
