import 'package:crypto_estate_tech/common/ColorConstants.dart';
import 'package:crypto_estate_tech/common/widgetConstants.dart';
import 'package:crypto_estate_tech/screens/bottomNavigation/explore/ExplorePage.dart';
import 'package:crypto_estate_tech/screens/bottomNavigation/profile/profile_screen.dart';
import 'package:crypto_estate_tech/screens/bottomNavigation/wishlist/wishlist.dart';
import 'package:crypto_estate_tech/screens/detailScreens/Dialogs/insightsScreen.dart';
import 'package:crypto_estate_tech/screens/inbox/inbox_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:web3modal_flutter/services/w3m_service/w3m_service.dart';
import 'package:web3modal_flutter/web3modal_flutter.dart';

class HomeScreen extends StatefulWidget {
  final bool isInsightsScreen;
  const HomeScreen({super.key, this.isInsightsScreen = false});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentindex = 0;

  @override
  Widget build(BuildContext context) {
    final tabs = [
      widget.isInsightsScreen ? const InsightsScreen() : const ExplorePage(),
      WishlistPage(),
      InboxScreen(),
      const ProfileScreen(),
    ];

    return Scaffold(
      backgroundColor: Colors.white,
      body: tabs[_currentindex],
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
