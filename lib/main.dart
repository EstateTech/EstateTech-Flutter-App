import 'package:crypto_estate_tech/common/ColorConstants.dart';
import 'package:crypto_estate_tech/provider/authProvider.dart';
import 'package:crypto_estate_tech/provider/chatProvider.dart';
import 'package:crypto_estate_tech/provider/filterProvider.dart';
import 'package:crypto_estate_tech/provider/firebaseStorageProvider.dart';
import 'package:crypto_estate_tech/provider/likesProvider.dart';
import 'package:crypto_estate_tech/provider/postImagesProvider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'common/routing.dart' as route;
import 'package:flutter_screenutil/flutter_screenutil.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<FirebaseStorageProvider>(
          create: (context) => FirebaseStorageProvider(),
        ),
        ChangeNotifierProvider<AuthProvider>(
          create: (context) => AuthProvider(),
        ),

        ChangeNotifierProvider(
          create: (context) => XFileProvider(),
        ),

        ChangeNotifierProvider(
          create: (context) => FilterProvider(),
        ),

        ChangeNotifierProvider(
          create: (context) => PostLikesProvider(),
        ),
        // Add more providers if needed
         ChangeNotifierProvider(
          create: (context) => ChatProvider(),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(builder: (context, child) {
      return ScreenUtilInit(
        designSize: const Size(360, 800),
        minTextAdapt: true,
        rebuildFactor: RebuildFactors.all,
        splitScreenMode: true,
        builder: (context, child) => MaterialApp(
          builder: (context, child) {
            return MediaQuery(
                data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
                child: child!);
          },

          debugShowCheckedModeBanner: false,
          title: 'Crypto Estate Tech',

          //home: WelcomeScreen(),
          // darkTheme: ThemeData.dark(),
          onGenerateRoute: route.Router.generateRoute,
          initialRoute: splashScreenRoute,
        ),
      );
    });
  }
}
