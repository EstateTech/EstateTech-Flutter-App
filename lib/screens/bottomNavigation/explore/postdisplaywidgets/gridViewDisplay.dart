import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crypto_estate_tech/common/ColorConstants.dart';
import 'package:crypto_estate_tech/common/widgetConstants.dart';
import 'package:crypto_estate_tech/helperclass/dataFromFirestore.dart';
import 'package:crypto_estate_tech/model/postModel.dart';
import 'package:crypto_estate_tech/provider/filterProvider.dart';
import 'package:crypto_estate_tech/screens/bottomNavigation/explore/postdisplaywidgets/postGridWidget.dart';
import 'package:crypto_estate_tech/screens/detailScreens/postDetailScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class GridViewWidget extends StatefulWidget {
  const GridViewWidget({
    super.key,
    required this.postFeature,
  });

  final String postFeature;

  @override
  State<GridViewWidget> createState() => _GridViewWidgetState();
}

class _GridViewWidgetState extends State<GridViewWidget> {
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
                  return Center(
                      child: Text(
                    'No posts found',
                    style: style.copyWith(fontSize: 18.sp, color: mainAppColor),
                  ));
                }

                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                  return Center(
                      child: Text(
                    'No posts foundy.',
                    style: style.copyWith(fontSize: 18.sp, color: mainAppColor),
                  ));
                }

                // Process the data from snapshot
                List<DocumentSnapshot<Map<String, dynamic>>> documents =
                    snapshot.data!.docs
                        .cast<DocumentSnapshot<Map<String, dynamic>>>();

                return GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 25.0,
                      crossAxisSpacing: 2.0,
                    ),
                    itemCount: documents.length,
                    itemBuilder: (context, index) {
                      PostModel post =
                          PostModel.fromJson(documents[index].data()!);
                      List<String> likes = [];
                      if (post.likes != null) {
                        likes = post.likes!;
                      }
                      return GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => postDetailScreen(
                                  postModel: post,
                                ),
                              ),
                            );
                          },
                          child: GridPost(
                            postModel: post,
                            userId: post.userid!,
                            id: documents[index].id,
                            likes: likes,
                          ));
                    });
              },
            )
          : StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
              stream: postsStream,
              builder: (context, snapshot) {
                // if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                //   return Center(child: CircularProgressIndicator());
                // }

                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasData) {
                  List<DocumentSnapshot<Map<String, dynamic>>> documents =
                      snapshot.data!.docs;
                  int postCount = documents.length;

                  return GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              mainAxisSpacing: 20.0,
                              crossAxisSpacing: 2.0,
                              childAspectRatio: 0.7),
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
                            //navigate to details page
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => postDetailScreen(
                                  postModel: post,
                                ),
                              ),
                            );
                          },
                          child: GridPost(
                            postModel: post,
                            userId: post.userid!,
                            id: documents[index].id,
                            likes: likes,
                          ),
                        );
                      });
                } else if (snapshot.hasError) {
                  return Center(
                      child: Text(
                    'No posts found. \n Error Occured \n TryAgain',
                    style: style.copyWith(fontSize: 18.sp, color: mainAppColor),
                  ));
                } else {
                  return Center(
                      child: Text(
                    '',
                    style: style.copyWith(fontSize: 18.sp, color: mainAppColor),
                  ));
                }
              }),
    );
  }
}
