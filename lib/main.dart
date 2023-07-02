import 'package:crypto_estate_tech/common/ColorConstants.dart';
import 'package:crypto_estate_tech/screens/AuthScreens/SplashScreen.dart';
import 'package:crypto_estate_tech/screens/AuthScreens/WelcomeScreen.dart';
import 'package:flutter/material.dart';
import 'common/routing.dart' as route;
import 'package:flutter_screenutil/flutter_screenutil.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(builder: (context, child) {
      return ScreenUtilInit(
        designSize: const Size(360, 800),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, child) => MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Crypto Estate Tech',

          //home: WelcomeScreen(),
          // darkTheme: ThemeData.dark(),
          onGenerateRoute: route.Router.generateRoute,
          initialRoute: welcomeScreenRoute,
        ),
      );
    });
  }
}
