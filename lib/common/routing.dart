import 'package:crypto_estate_tech/common/ColorConstants.dart';
import 'package:crypto_estate_tech/screens/AuthScreens/SplashScreen.dart';
import 'package:crypto_estate_tech/screens/AuthScreens/WelcomeScreen.dart';
import 'package:crypto_estate_tech/screens/AuthScreens/congratulations_screen.dart';
import 'package:crypto_estate_tech/screens/bottomNavigation/profile/addPhotosScreen.dart';
import 'package:crypto_estate_tech/screens/bottomNavigation/profile/additionalinfoScreen.dart';
import 'package:crypto_estate_tech/screens/bottomNavigation/profile/featuresScreen.dart';
import 'package:crypto_estate_tech/screens/bottomNavigation/profile/offeredSpaceScreen.dart';
import 'package:crypto_estate_tech/screens/bottomNavigation/profile/postCompleteCongratulationsScreen.dart';
import 'package:crypto_estate_tech/screens/bottomNavigation/profile/propertyDescription.dart';
import 'package:crypto_estate_tech/screens/bottomNavigation/profile/propertyMappedScreen.dart';
import 'package:crypto_estate_tech/screens/homeScreen/home_screen.dart';
import 'package:crypto_estate_tech/screens/walkthroughScreens/walkthrough.dart';
import 'package:crypto_estate_tech/screens/walkthroughScreens/walkthroughPostScreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../screens/AuthScreens/user_info_developer.dart';
import '../screens/AuthScreens/user_info_developer_agency_info2.dart';
import '../screens/bottomNavigation/profile/propertyTextAdressScreen.dart';
import '../screens/bottomNavigation/profile/propertyTypeScreen.dart';
import '../screens/walkthroughScreens/walkthroughPostScreen2.dart';
import '../screens/walkthroughScreens/walkthroughStep3.dart';

class Router {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    Object? args = settings.arguments;
    return MaterialPageRoute(builder: (context) {
      switch (settings.name) {
        case splashScreenRoute:
          return SplashScreen();
        case welcomeScreenRoute:
          return WelcomeScreen();
        case userinfodeveloperscreenroute:
          return UserInfoDeveloper(
            email: '',
          );

        case successScreenRoute:
          return CongratulationScreen();

        case walkThroughScreenRoute:
          return WalkThroughScreen();

        case walkThroughPostScreenRoute:
          return WalkthroughPostScreen();

        case walkThroughPostScreenRoute2:
          return WalkThroughScreenPost2();

        case propertyTypeScreen:
          return PropertyTypeScreen();

        case offeredSpaceScreen:
          return OfferedSpaceScreen();

        case propertyMappedScreen:
          return PropertyMappedScreen();

        case propertyMappedwithPinScreen:
          return PropertyMappedScreen(
            isConfirmPinScreen: true,
          );

        case propertyTextAddressScreen:
          return PropertyTextAddressScreen();

        case MorePropertyScreen:
          return PropertyTypeScreen(
            isMorePropertyScreen: true,
          );

        case postCompletedCongratulationsScreen:
          return PostCompleteCongratulationScreen();

        case productDescriptionScreen:
          return PropertyDescriptionScreen();

        case additionalInfoScreen:
          return AdditionalInfoScreen();

        case addPhotoScreen:
          return AddPhotoScreen();

        case walkthroughStep3:
          return WalkthroughStep3();

        case walkthroughStep2:
          return WalkThroughScreenPost2(
            isStep2: true,
          );

        case featuresScreen:
          return FeatureScreen();

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
