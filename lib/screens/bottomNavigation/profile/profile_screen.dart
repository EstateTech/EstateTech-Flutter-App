import 'package:crypto_estate_tech/common/ColorConstants.dart';
import 'package:crypto_estate_tech/common/widgetConstants.dart';
import 'package:crypto_estate_tech/model/postModel.dart';
import 'package:crypto_estate_tech/provider/authProvider.dart';
import 'package:crypto_estate_tech/screens/walkthroughScreens/walkthroughPostScreen2.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  // final PostModel postModel;
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: Text('Profile'),
      ),
      body: Container(
        height: size.height,
        width: size.width,
        margin: EdgeInsets.symmetric(horizontal: 20.w),
        decoration: BoxDecoration(color: Colors.white),
        child: Column(
          children: [
            SizedBox(
              height: 20.h,
            ),
            ElevatedButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              WalkThroughScreenPost2(postmodel: PostModel())));
                },
                child: Container(
                    alignment: Alignment.center,
                    height: 60.h,
                    width: double.infinity,
                    child: Text(
                      "Upload Property",
                      style: style.copyWith(
                          fontSize: 16.sp, fontWeight: FontWeight.w600),
                    ))),
            SizedBox(
              height: 20.h,
            ),
            ElevatedButton(
                onPressed: () {
                  final ap = Provider.of<AuthProvider>(context, listen: false);
                  ap.LogOut();
                  Navigator.pushNamed(context, welcomeScreenRoute);
                },
                child: Container(
                    alignment: Alignment.center,
                    height: 60.h,
                    width: double.infinity,
                    child: Text(
                      "Logout",
                      style: style.copyWith(
                          fontSize: 16.sp, fontWeight: FontWeight.w600),
                    )))
          ],
        ),
      ),
    );
  }
}
