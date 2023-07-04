import 'package:crypto_estate_tech/common/ColorConstants.dart';
import 'package:crypto_estate_tech/common/widgetConstants.dart';
import 'package:crypto_estate_tech/screens/bottomNavigation/explore/ExplorePage.dart';
import 'package:crypto_estate_tech/screens/bottomNavigation/profile/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentindex = 0;

  final tabs = [
    ExplorePage(),
    Center(
      child: Text("Search"),
    ),
    Center(
      child: Text("Camera"),
    ),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: tabs[_currentindex],
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        elevation: 1.5,
        onTap: (index) {
          setState(() {
            _currentindex = index;
          });
        },
        currentIndex: _currentindex,
        type: BottomNavigationBarType.fixed,
        unselectedLabelStyle: style,
        selectedLabelStyle: style,
        fixedColor: textColor,
        items: [
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              "assets/images/search_icon.svg",
              color: _currentindex == 0 ? textColor : unselectedBoNaBColor,
              height: 22.h,
              width: 22.h,
            ),
            label: 'Explore',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.favorite_border,
              color: _currentindex == 1 ? textColor : unselectedBoNaBColor,
              size: 25.h,
            ),
            label: 'Wishlist',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.messenger_outline_outlined,
              color: _currentindex == 2 ? textColor : unselectedBoNaBColor,
            ),
            label: 'Inbox',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              "assets/images/profile_icon.svg",
              color: _currentindex == 3 ? textColor : unselectedBoNaBColor,
            ),
            label: 'Profile',
          )
        ],
      ),
    );
  }
}
