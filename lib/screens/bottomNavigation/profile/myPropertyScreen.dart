import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crypto_estate_tech/common/ColorConstants.dart';
import 'package:crypto_estate_tech/common/widgetConstants.dart';
import 'package:crypto_estate_tech/helperclass/dataFromFirestore.dart';
import 'package:crypto_estate_tech/model/postModel.dart';
import 'package:crypto_estate_tech/provider/XfileProvider.dart';
import 'package:crypto_estate_tech/screens/bottomNavigation/explore/postdisplaywidgets/postListWidget.dart';
import 'package:crypto_estate_tech/screens/bottomNavigation/profile/AddPropertyScreens/propertyTypeScreen.dart';
import 'package:crypto_estate_tech/screens/detailScreens/postDetailScreen.dart';
import 'package:crypto_estate_tech/screens/walkthroughScreens/walkthroughPostScreen2.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class MyPropertyScreen extends StatefulWidget {
  const MyPropertyScreen({super.key});

  @override
  State<MyPropertyScreen> createState() => _MyPropertyScreenState();
}

class _MyPropertyScreenState extends State<MyPropertyScreen> {
  final user = FirebaseAuth.instance.currentUser!.uid;

  @override
  Widget build(BuildContext context) {
    final xFileProvider = Provider.of<XFileProvider>(context, listen: true);

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          "My Property",
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                stream: getPostsForCurrentUser(
                    FirebaseAuth.instance.currentUser!.uid),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    List<DocumentSnapshot<Map<String, dynamic>>> documents =
                        snapshot.data!.docs;
                    int postCount = documents.length;
                    return postCount == 0
                        ? Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Image.asset(
                                'assets/images/nothing.png',
                                color: mainAppColor,
                                width: 100.w,
                                height: 100.h,
                              ),
                              SizedBox(
                                height: 20.h,
                              ),
                              Center(
                                child: Text(
                                  'You haven\'t publish any profile yet!',
                                  style: GoogleFonts.dmSans(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 16.sp,
                                      color: Colors.black),
                                ),
                              ),
                              SizedBox(
                                height: 20.h,
                              ),
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              WalkThroughScreenPost2(
                                                postmodel: PostModel(),
                                                isEdited: false,
                                              )));
                                },
                                child: Container(
                                  height: 50.h,
                                  width: 240.w,
                                  padding: EdgeInsets.all(10.w),
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10.r),
                                    gradient: LinearGradient(
                                        begin: Alignment.topCenter,
                                        end: Alignment.bottomCenter,
                                        colors: [mainAppColor, Colors.black]),
                                  ),
                                  child: Text(
                                    'Advertise your property',
                                    style: GoogleFonts.dmSans(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 16.sp,
                                        color: Colors.white),
                                  ),
                                ),
                              )
                            ],
                          )
                        : ListView.builder(
                            padding: EdgeInsets.zero,
                            itemCount: postCount,
                            itemBuilder: (context, index) {
                              PostModel post =
                                  PostModel.fromJson(documents[index].data()!);
                              List<String> likes = [];
                              if (post.likes != null) {
                                likes = post.likes!;
                              }

                              return GestureDetector(
                                onTap: () {
                                  xFileProvider
                                      .setEditedpostId(documents[index].id);

                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => PropertyTypeScreen(
                                        isEdited: true,
                                        postModel: post,
                                      ),
                                    ),
                                  );
                                },
                                child: Post(
                                  postModel: post,
                                  userId: post.userid,
                                  id: documents[index].id,
                                  likes: likes,
                                  isMyProperty: true,
                                  onDeleteTap: () {
                                    print(documents[index].id);
                                    // Handle post deletion when Dismissible is dismissed.
                                    deletePost(documents[index]
                                        .id); // Implement this function.
                                  },
                                ),
                              );
                            },
                          );
                  } else if (snapshot.hasError) {
                    return Center(
                        child: Text(
                      "No Network Connection\n Error Occured",
                      style:
                          style.copyWith(fontSize: 20.sp, color: mainAppColor),
                      textAlign: TextAlign.center,
                    ));
                  } else {
                    print(snapshot.error);
                    return Center(
                        child: Container(
                      child: Text('data'),
                    ));
                  }
                }),
          )
        ],
      ),
    );
  }
}
