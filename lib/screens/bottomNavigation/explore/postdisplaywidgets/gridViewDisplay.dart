import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crypto_estate_tech/common/ColorConstants.dart';
import 'package:crypto_estate_tech/common/list_constants.dart';
import 'package:crypto_estate_tech/common/widgetConstants.dart';
import 'package:crypto_estate_tech/helperclass/dataFromFirestore.dart';
import 'package:crypto_estate_tech/model/postModel.dart';
import 'package:crypto_estate_tech/provider/filterProvider.dart';
import 'package:crypto_estate_tech/screens/bottomNavigation/explore/postdisplaywidgets/postGridWidget.dart';
import 'package:crypto_estate_tech/screens/detailScreens/postDetailScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:responsive_builder/responsive_builder.dart';

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
  var childaspectRatio = 0;
  

  @override
  void initState() {
  
    // TODO: implement initState
    super.initState();
    postsStream = getPostsStream(widget.postFeature);
  }

  @override
  Widget build(BuildContext context) {
    final filterProvider = Provider.of<FilterProvider>(context, listen: true);
      DeviceScreenType deviceType = getDeviceType(MediaQuery.of(context).size);
    return Expanded(
      child: filterProvider.isFilterApplied
          ? StreamBuilder<QuerySnapshot>(
              stream: postsStream,
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

                List<DocumentSnapshot<Map<String, dynamic>>> filteredDocuments =
                    documents.where((document) {
                  PostModel post = PostModel.fromJson(document.data()!);

                  return post.propertyType == filterProvider.propertyType ||
                      post.bedrooms == filterProvider.bedrooms ||
                      post.bathrooms == filterProvider.bathrooms ||
                      post.rentalPeriod == filterProvider.rentalPeriod ||
                      post.rentalSubtype == filterProvider.rentalSubtype ||
                      post.rentalType == filterProvider.rentalType   
                     // widget.postFeature == filterProvider.postFeature
                      ;
                }).toList();

                print(filteredDocuments.length);

                 if(filteredDocuments.isNotEmpty){
                return GridView.builder(
                    gridDelegate:
                         SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            mainAxisSpacing: 25.0,
                            crossAxisSpacing: 2.0,
                         childAspectRatio:  deviceType == DeviceScreenType.tablet ? 1.1 : 0.8),
                    physics: ScrollPhysics(),
                    itemCount: filteredDocuments.length,
                    itemBuilder: (context, index) {
                      PostModel post =
                          PostModel.fromJson(filteredDocuments[index].data()!);
                          print("the id of the post is ${filteredDocuments[index].id}");
print(" BEDROOMS ===> ${post.bedrooms} BATHROOMS =====> ${post.bathrooms}  RENTAL PERIOD ====> ${post.rentalPeriod}  RENTAL SUB type ${post.rentalSubtype}  RENTAL Type =======> ${post.rentalType} PROPERTY TYPE ====> ${post.propertyType}");
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
                                  postId: filteredDocuments[index].id,
                                ),
                              ),
                            );
                          },
                          child: GridPost(
                            postModel: post,
                            userId: post.userid!,
                            id: filteredDocuments[index].id,
                            likes: likes,
                          ));
                    });
                 } else {
                  return Center(child: Text('No posts found'));
                 }
            
            
              },
            )
          : StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
              stream: postsStream,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasData) {
                  List<DocumentSnapshot<Map<String, dynamic>>> documents =
                      snapshot.data!.docs;
                  int postCount = documents.length;

                  return GridView.builder(
                      gridDelegate:
                           SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              mainAxisSpacing: 25.0,
                              crossAxisSpacing: 2.0,
                             childAspectRatio:  deviceType == DeviceScreenType.tablet ? 1.1 : 0.8),
                      itemCount: postCount,
                      physics: ScrollPhysics(),
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
                                  postId: documents[index].id,
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
