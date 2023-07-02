import 'package:crypto_estate_tech/common/ColorConstants.dart';
import 'package:crypto_estate_tech/screens/AuthScreens/WelcomeScreen.dart';
import 'package:crypto_estate_tech/screens/AuthScreens/congratulations_screen.dart';
import 'package:crypto_estate_tech/screens/homeScreen/home_screen.dart';
import 'package:crypto_estate_tech/screens/walkthroughScreens/walkthrough.dart';
import 'package:flutter/material.dart';

import '../screens/AuthScreens/user_info_developer.dart';
import '../screens/AuthScreens/user_info_developer_agency_info2.dart';

class Router {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    Object? args = settings.arguments;
    return MaterialPageRoute(builder: (context) {
      switch (settings.name) {
        case welcomeScreenRoute:
          return WelcomeScreen();
        case userinfodeveloperscreenroute:
          return UserInfoDeveloper();

        case userinfodeveloperscreenroute2:
          return DeveloperAgencyInfo2();

        case successScreenRoute:
          return CongratulationScreen();

        case WalkThroughScreenRoute:
          return WalkThroughScreen();

        case homeScreenRoute:
          return HomeScreen();
        default:
          return Scaffold(
            body: Center(
              child: Text("No route defined for ${settings.name}"),
            ),
          );
      }
    });
  }
}
