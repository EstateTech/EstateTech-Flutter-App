import 'package:crypto_estate_tech/common/ColorConstants.dart';
import 'package:crypto_estate_tech/common/list_constants.dart';
import 'package:crypto_estate_tech/common/widgetConstants.dart';
import 'package:crypto_estate_tech/provider/filterProvider.dart';
import 'package:crypto_estate_tech/screens/bottomNavigation/explore/search_pages/buy.dart';
import 'package:crypto_estate_tech/screens/bottomNavigation/explore/search_pages/rent.dart';
import 'package:crypto_estate_tech/screens/bottomNavigation/explore/search_pages/sell.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen>
    with TickerProviderStateMixin {
  TabController? _tabController;
  @override
  void initState() {
    super.initState();
    _tabController = TabController(
        length: 3, vsync: this); // Change the length to 4 if you want four tabs

    //_tabController!.addListener(_handleTabChange);
  }

  @override
  Widget build(BuildContext context) {
    final filterProvider = Provider.of<FilterProvider>(context);
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(left: 10.h, right: 10.h),
              child: TabBar(
                indicatorColor: Shade2purple,

                onTap: (index) {
                  setState(() {
                    //  currentIndex = index;
                    print(" the currentt indexx ${index}");
                    if(index == 0) {
                      filterProvider.updateRentalProperties(YEARLY, RENT, LONG_TERM);
                    }else if(index == 1) {
                      filterProvider.updateRentalProperties("NoPeriod", BUY, READY_TO_MOVE);
                    }else if(index == 2) {
                      filterProvider.updateRentalProperties("NoPeriod", SELL, OFFER_TO_SELL);
                    }




                  });
                },
                labelStyle: style.copyWith(fontSize: 20.sp),
                padding: EdgeInsets.zero,
                labelColor:
                    Shade2purple, // Set the text color of the selected tab
                unselectedLabelColor:
                    greyShade2, // Set the text color of unselected tabs
                controller: _tabController,
                indicatorWeight: 3.0,
                labelPadding: EdgeInsets.zero,

                tabs: [
                  Tab(
                    text: 'Rent',
                    iconMargin: EdgeInsets.zero,
                  ),
                  Tab(
                    text: 'Buy',
                    iconMargin: EdgeInsets.zero,
                  ),
                  Tab(
                    text: 'Sell',
                    iconMargin: EdgeInsets.zero,
                  ),
                ],
              ),
            ),
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  Rent(),
                  // Widget for Wishlist tab
                  BuyScreen(),
                  // Widget for Inbox tab
                  SellScreen(),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.only(left: 20.h, right: 20.h),
        margin: EdgeInsets.only(bottom: 10.h),
        height: 50.h,
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 2,
              blurRadius: 4,
              offset: Offset(0, -2), // Controls the position of the shadow
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GestureDetector(
              
              onTap: () {
                 filterProvider.updateFilterAppliedField(false);
                Navigator.pushReplacementNamed(
                  context,
                  homeScreenRoute,
                );
               
              },
              child: Container(
                  width: 40.w,
                  height: 40.h,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: Color(
                          0xFF3A3153,
                        ),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.1),
                          spreadRadius: 2,
                          blurRadius: 4,
                          offset: Offset(
                              0, -2), // Controls the position of the shadow
                        ),
                      ]),
                  child: Icon(
                    color: Color(
                      0xFF3A3153,
                    ),
                    Icons.arrow_back_rounded,
                  )),
            ),

          
            GestureDetector(
              onTap: () {
                // search clicked
                print("onSearchTapppeddd");

              
                  filterProvider.updateFilterAppliedField(true);
                
                Navigator.pushNamed(
                  context,
                  homeScreenRoute,
                );

                print(
                    " the filtered property is ${filterProvider.propertyType}");
                print(" the filtered bedrooms are ${filterProvider.bedrooms}");
                print(
                    " the filtered bathrooms are ${filterProvider.bathrooms}");
            
                print(
                    " the filtered rental period is ${filterProvider.rentalPeriod}");
                print(
                    "the filtered rental subPeriod is ${filterProvider.rentalSubtype}");
                print(
                    "the filtered rentaltype is ${filterProvider.rentalType}");

                print("the filtered postFeature is ${filterProvider.postFeature}");
              },
              child: Container(
                width: 100.w,
                height: 40.w,
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [mainAppColor, Colors.black]),
                    border: Border.all(color: Colors.black),
                    borderRadius: BorderRadius.circular(15.r)),
                child: Row(
                  // crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.search,
                      color: Colors.white,
                    ),
                    Text(
                      "Search",
                      style: style.copyWith(fontSize: 15.sp),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
