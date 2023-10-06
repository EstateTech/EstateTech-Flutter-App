import 'package:crypto_estate_tech/common/ColorConstants.dart';
import 'package:crypto_estate_tech/screens/AuthScreens/SplashScreen.dart';
import 'package:crypto_estate_tech/screens/AuthScreens/WelcomeScreen.dart';
import 'package:crypto_estate_tech/screens/AuthScreens/congratulations_screen.dart';

import 'package:crypto_estate_tech/screens/bottomNavigation/profile/AddPropertyScreens/postCompleteCongratulationsScreen.dart';

import 'package:crypto_estate_tech/screens/homeScreen/home_screen.dart';
import 'package:crypto_estate_tech/screens/bottomNavigation/explore/search_pages/search_screen.dart';
import 'package:crypto_estate_tech/screens/walkthroughScreens/walkthrough.dart';
import 'package:crypto_estate_tech/screens/walkthroughScreens/walkthroughPostScreen.dart';
import 'package:flutter/material.dart';

import '../screens/AuthScreens/user_info_developer.dart';
import '../screens/bottomNavigation/profile/AddPropertyScreens/propertyTypeScreen.dart';

class Router {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    Object? args = settings.arguments;
    return MaterialPageRoute(builder: (context) {
      switch (settings.name) {
        case splashScreenRoute:
          return const SplashScreen();
        case welcomeScreenRoute:
          return const WelcomeScreen();
        case userinfodeveloperscreenroute:
          return const UserInfoDeveloper(
            email: '',
          );

        case successScreenRoute:
          return const CongratulationScreen();

        case walkThroughScreenRoute:
          return const WalkThroughScreen();

        case walkThroughPostScreenRoute:
          return const WalkthroughPostScreen();

        // case walkThroughPostScreenRoute2:
        //   return WalkThroughScreenPost2();

        case propertyTypeScreen:
          return const PropertyTypeScreen();

        // case offeredSpaceScreen:
        //   return OfferedSpaceScreen(
        //     propertyType: '',
        //   );

        // case propertyMappedScreen:
        //   return PropertyMappedScreen(
        //     propertyPortion: '',
        //     propertyType: '',
        //     isConfirmPinScreen: false,
        //   );

        // case propertyMappedwithPinScreen:
        //   return PropertyMappedScreen(
        //     propertyPortion: '',
        //     propertyType: '',
        //     isConfirmPinScreen: true,
        //   );

        // case propertyTextAddressScreen:
        //   return PropertyTextAddressScreen();

        case searchScreen:
          return const SearchScreen();

        case MorePropertyScreen:
          return const PropertyTypeScreen(
            isMorePropertyScreen: true,
          );

        case postCompletedCongratulationsScreen:
          return const PostCompleteCongratulationScreen();

        // case productDescriptionScreen:
        //   return PropertyDescriptionScreen();

        // case additionalInfoScreen:
        //   return AdditionalInfoScreen();

        // case addPhotoScreen:
        //   return AddPhotoScreen();

        // case walkthroughStep3:
        //   return WalkthroughStep3();

        // case walkthroughStep2:
        //   return WalkThroughScreenPost2(
        //     isStep2: true,
        //   );

        // case featuresScreen:
        //   return FeatureScreen();

        case homeScreenRoute:
          return const HomeScreen();
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
