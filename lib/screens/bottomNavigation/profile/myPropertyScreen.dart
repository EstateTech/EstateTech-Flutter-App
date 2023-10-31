import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crypto_estate_tech/common/ColorConstants.dart';
import 'package:crypto_estate_tech/common/widgetConstants.dart';
import 'package:crypto_estate_tech/helperclass/dataFromFirestore.dart';
import 'package:crypto_estate_tech/model/postModel.dart';
import 'package:crypto_estate_tech/provider/XfileProvider.dart';
import 'package:crypto_estate_tech/screens/bottomNavigation/explore/postdisplaywidgets/postListWidget.dart';
import 'package:crypto_estate_tech/screens/bottomNavigation/profile/AddPropertyScreens/propertyTypeScreen.dart';
import 'package:crypto_estate_tech/screens/detailScreens/postDetailScreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
        title: Text("My Property"),
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
                    return ListView.builder(
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
                            onDeleteTap: (){
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
                    return Center(child: Container());
                  }
                }),
          )
        ],
      ),
    );
  }
}
