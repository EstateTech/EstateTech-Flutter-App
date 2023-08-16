import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crypto_estate_tech/common/ColorConstants.dart';
import 'package:crypto_estate_tech/common/widgetConstants.dart';
import 'package:crypto_estate_tech/helperclass/dataFromFirestore.dart';
import 'package:crypto_estate_tech/model/postModel.dart';
import 'package:crypto_estate_tech/screens/bottomNavigation/explore/postdisplaywidgets/postGridWidget.dart';
import 'package:crypto_estate_tech/screens/bottomNavigation/explore/postdisplaywidgets/postListWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RecomendationContainer extends StatelessWidget {
  final PostModel postModel;
  const RecomendationContainer({super.key, required this.postModel});

  @override
  Widget build(BuildContext context) {
    return  Container(
        width: MediaQuery.of(context).size.width,
      height: 400.h,
      padding: EdgeInsets.only(left: 20.h, right: 20.h),
      child: Column(
        children: [
            Text(
            "Similar Properties",
            style: style.copyWith(
              fontSize: 20.sp,
              color: Shade2purple,
            ),
          ),
          SizedBox(height: 20.h,),
          Container(
            height: 255.h,
           
            child: StreamBuilder<QuerySnapshot>(
  stream: getSimilarPostsStream(postModel.propertyType!),
  builder: (context, snapshot) {
    if (snapshot.connectionState == ConnectionState.waiting) {
      return CircularProgressIndicator();
    }
    if (snapshot.hasError) {
      return Text('Error: ${snapshot.error}');
    }
    if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
      return Text('No similar properties found.');
    }
     List<DocumentSnapshot<Map<String, dynamic>>> documents =
                    snapshot.data!.docs
                        .cast<DocumentSnapshot<Map<String, dynamic>>>();
    return SizedBox(
    // Set your desired height
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: snapshot.data!.docs.length,
        itemBuilder: (context, index) {
          // Access post data from the DocumentSnapshot
       PostModel post =
                        PostModel.fromJson(documents[index].data()!);
          return GridPost(postModel: post, userId: post.userid!,isRecomendationPage: true,);
        },
      ),
    );
  },
)
,
          )


        ],
      ),
    );

  }
}