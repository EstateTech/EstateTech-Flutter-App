// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crypto_estate_tech/provider/filterProvider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import 'package:crypto_estate_tech/common/ColorConstants.dart';
import 'package:crypto_estate_tech/helperclass/dataFromFirestore.dart';
import 'package:crypto_estate_tech/model/postModel.dart';
import 'package:crypto_estate_tech/screens/bottomNavigation/explore/PostWidget.dart';
import 'package:crypto_estate_tech/screens/bottomNavigation/explore/demy.dart';
import 'package:provider/provider.dart';

class BestOffers extends StatefulWidget {
  const BestOffers({
    Key? key,
  }) : super(key: key);

  @override
  State<BestOffers> createState() => _BestOffersState();
}

class _BestOffersState extends State<BestOffers> {
  int currentViewIndex = 0;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    FilterProvider filterProvider = Provider.of<FilterProvider>(context);

    Stream<QuerySnapshot> queryStream = firestore
        .collection('posts')
        .where('propertyType', isEqualTo: filterProvider.propertyType)
        .where('bedrooms', isEqualTo: filterProvider.bedrooms)
        .where('bathrooms', isEqualTo: filterProvider.bathrooms)
        .snapshots();
    return Column(
      children: [
        SizedBox(
          height: 10.h,
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 10.w),
          child: Row(
            children: [
              ViewIconContainer(
                  isSelected: currentViewIndex == 0 ? true : false,
                  child: SvgPicture.asset("assets/images/grid_icon.svg",
                      color: currentViewIndex == 0
                          ? Shade2purple
                          : unselectedTabcolor),
                  onTap: () {
                    setState(() {
                      currentViewIndex = 0;
                    });
                  }),
              SizedBox(
                width: 10.w,
              ),
              ViewIconContainer(
                  isSelected: currentViewIndex == 1 ? true : false,
                  child: SvgPicture.asset(
                      "assets/images/horizontal_lines_icon.svg",
                      color: currentViewIndex == 1
                          ? Shade2purple
                          : unselectedTabcolor),
                  onTap: () {
                    setState(() {
                      currentViewIndex = 1;
                    });
                  }),
              Expanded(child: SizedBox()),
              Container(
                  padding: EdgeInsets.all(7.h),
                  height: 50.h,
                  width: 60.h,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: unselectedTabcolor,
                          blurRadius: 4,
                          offset: Offset(0, 5), // Shadow position
                        ),
                      ],
                      border: Border.all(color: Shade2purple),
                      borderRadius: BorderRadius.circular(10.r)),
                  child: SvgPicture.asset("assets/images/dollar_icon.svg"))
            ],
          ),
        ),
        Expanded(
          child: filterProvider.isFilterApplied
              ? StreamBuilder<QuerySnapshot>(
                  stream: queryStream,
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}');
                    }

                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return CircularProgressIndicator();
                    }

                    if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                      return Text('No posts found.');
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
                        return Post(postModel: post);
                      },
                    );
                  },
                )
              : StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                  stream: FirebaseFirestore.instance
                      .collection('posts')
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }
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
                          return Post(postModel: post);
                          // PostModel post = posts[index];
                        },
                      );
                    } else {
                      print(snapshot.error);
                      return Container(
                        child: Text("There is no Property For Display"),
                      );
                    }
                  }),
        )
        //  CourselBuilder()
      ],
    );
  }

  Widget ViewIconContainer(
      {required Widget child,
      required VoidCallback onTap,
      required bool isSelected}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
          padding: EdgeInsets.all(5.h),
          height: 50.h,
          width: 60.h,
          decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: unselectedTabcolor,
                  blurRadius: 4,
                  offset: Offset(0, 5), // Shadow position
                ),
              ],
              color: Colors.white,
              border: Border.all(
                  color: isSelected ? Shade2purple : unselectedTabcolor),
              borderRadius: BorderRadius.circular(10.r)),
          child: child),
    );
  }
}
