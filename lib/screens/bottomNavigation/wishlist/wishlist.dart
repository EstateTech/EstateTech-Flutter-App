import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crypto_estate_tech/model/postModel.dart';
import 'package:crypto_estate_tech/screens/bottomNavigation/explore/postdisplaywidgets/postListWidget.dart';
import 'package:crypto_estate_tech/screens/detailScreens/postDetailScreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class WishlistPage extends StatefulWidget {
  const WishlistPage({super.key});

  @override
  State<WishlistPage> createState() => _WishlistPageState();
}

class _WishlistPageState extends State<WishlistPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          title: Text(
            'WishList',
            style: TextStyle(
                color: Colors.black,
                fontSize: 16.sp,
                fontWeight: FontWeight.w700),
          ),
        ),
        body: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('posts')
              .where('likes',
                  arrayContains: FirebaseAuth.instance.currentUser!.uid)
              .snapshots(),
          builder: ((context, snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: CupertinoActivityIndicator(),
              );
            }
            return snapshot.data!.docs.length == 0
                ? Center(
                    child: Image.asset(
                      'assets/images/noitemfound.gif',
                      width: 300.w,
                      height: 400.h,
                      //   fit: BoxFit.fill,
                    ),
                  )
                : ListView.builder(
                    padding: EdgeInsets.zero,
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, index) {
                      PostModel post = PostModel.fromJson(
                          snapshot.data!.docs[index].data()!);
                      List<String> likes = [];
                      if (post.likes != null) {
                        likes = post.likes!;
                      }

                      return GestureDetector(
                        onTap: () {
                          //navigate to other screen
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => postDetailScreen(
                                postModel: post,
                                postId: snapshot.data!.docs[index].id,
                              ),
                            ),
                          );
                        },
                        child: Post(
                          postModel: post,
                          userId: post.userid,
                          id: snapshot.data!.docs[index].id,
                          likes: likes,
                          onDeleteTap: () {},
                        ),
                      );
                    },
                  );
          }),
        ));
  }
}
