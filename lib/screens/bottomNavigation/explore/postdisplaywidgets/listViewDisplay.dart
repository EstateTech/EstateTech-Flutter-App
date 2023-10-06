import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crypto_estate_tech/common/ColorConstants.dart';
import 'package:crypto_estate_tech/helperclass/dataFromFirestore.dart';
import 'package:crypto_estate_tech/model/postModel.dart';
import 'package:crypto_estate_tech/provider/filterProvider.dart';
import 'package:crypto_estate_tech/screens/bottomNavigation/explore/postdisplaywidgets/postListWidget.dart';
import 'package:crypto_estate_tech/screens/detailScreens/postDetailScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../../../common/widgetConstants.dart';

class ListViewWidget extends StatefulWidget {
  const ListViewWidget({
    super.key,
    required this.postFeature,
  });

  final String postFeature;

  @override
  State<ListViewWidget> createState() => _ListViewWidgetState();
}

class _ListViewWidgetState extends State<ListViewWidget> {
  late Stream<QuerySnapshot<Map<String, dynamic>>> postsStream;
  late Stream<QuerySnapshot> queryStream;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    postsStream = getPostsStream(widget.postFeature);
  }

  @override
  Widget build(BuildContext context) {
    FilterProvider filterProvider = Provider.of<FilterProvider>(context);
    queryStream = getQueryStream(filterProvider.propertyType ?? "",
        filterProvider.bedrooms ?? 0, filterProvider.bathrooms ?? 0);

    return Expanded(
      child: filterProvider.isFilterApplied
          ? StreamBuilder<QuerySnapshot>(
              stream: queryStream,
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                }

                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator();
                }

                if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                  return const Text('No posts found.');
                }

                // Process the data from snapshot
                List<DocumentSnapshot<Map<String, dynamic>>> documents =
                    snapshot.data!.docs
                        .cast<DocumentSnapshot<Map<String, dynamic>>>();

                return ListView.builder(
                  itemCount: documents.length,
                  itemBuilder: (context, index) {
                    // Build your UI with the post data from the document
                    PostModel post =
                        PostModel.fromJson(documents[index].data()!);

                    List<String> likes = [];
                    if (post.likes != null) {
                      likes = post.likes!;
                    }

                    return Hero(
                      tag: "image_tag",
                      child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => postDetailScreen(
                                  postModel: post,
                                  postId: documents[index].id,
                                ),
                              ),
                            );
                          },
                          child: Post(
                            postModel: post,
                            userId: post.userid,
                            id: documents[index].id,
                            likes: likes,
                          )),
                    );
                  },
                );
              },
            )
          : StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
              stream: postsStream,
              builder: (context, snapshot) {
                // if (!snapshot.hasData) {
                //   return Center(
                //     child: CircularProgressIndicator(),
                //   );
                // }
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
                          //navigate to other screen
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => postDetailScreen(
                                postModel: post,
                                postId: documents[index].id,
                              ),
                            ),
                          );
                        },
                        child: Post(
                          postModel: post,
                          userId: post.userid,
                          id: documents[index].id,
                          likes: likes,
                        ),
                      );
                    },
                  );
                } else if (snapshot.hasError) {
                  return Center(
                      child: Text(
                    "No Network Connection\n Error Occured",
                    style: style.copyWith(fontSize: 20.sp, color: mainAppColor),
                    textAlign: TextAlign.center,
                  ));
                } else {
                  print(snapshot.error);
                  return Center(child: Container());
                }
              }),
    );
  }
}
