import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crypto_estate_tech/common/ColorConstants.dart';
import 'package:crypto_estate_tech/common/widgetConstants.dart';
import 'package:crypto_estate_tech/helperclass/dataFromFirestore.dart';
import 'package:crypto_estate_tech/model/postModel.dart';
import 'package:crypto_estate_tech/model/signupSaveDataFirebase.dart';
import 'package:crypto_estate_tech/screens/bottomNavigation/explore/postdisplaywidgets/postListWidget.dart';
import 'package:crypto_estate_tech/screens/bottomNavigation/profile/AddPropertyScreens/propertyTypeScreen.dart';
import 'package:crypto_estate_tech/screens/detailScreens/postDetailScreen.dart';
import 'package:crypto_estate_tech/screens/inbox/chatScreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';

class UserProfileDetailedScreen extends StatefulWidget {
  final SignupSavepDataFirebase userdata ;
  const UserProfileDetailedScreen({super.key, required this.userdata});

  @override
  State<UserProfileDetailedScreen> createState() =>
      _UserProfileDetailedScreenState();
}

class _UserProfileDetailedScreenState extends State<UserProfileDetailedScreen> {

  String currentUserId = FirebaseAuth.instance.currentUser!.uid;
  bool isFollowing = false;
  bool isLoading = false;
  int postCount = 0;
  int followersCount = 0;
  int followingCount = 0;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if(widget.userdata.followers!.contains(currentUserId)){
      isFollowing = true;
    }
    getPostCountForUser(widget.userdata.userId!).then((value) {
    
     setState(() {
       postCount = value;
     });

    });

    // getFollowersCount(widget.userdata.userId!).then((value) {
    //  setState(() {
    //     followersCount = value;
    //  });
     
     
    // });

    // getFollowingCount(widget.userdata.userId!).then((value) {
    //   setState(() {
    //      followingCount = value;
    //   });
     
    //});
  }



  @override
  Widget build(BuildContext context) {
    String profileUserId = widget.userdata.userId!;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Container(
            height: 250.h,
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(40.r),
                bottomRight: Radius.circular(40.r),
              ),
              color: textColor,
            ),
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(top: 40.h , left: 20.h),
                  child: Align(
                    alignment: Alignment.bottomLeft,
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      
                      },
                      child: Container(
                        height: 30.h,
                        width: 30.h,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle
                        ),
                        child: Icon(Icons.arrow_back , color: Colors.black,
                        size: 25.h,
                        ),
                      ),
                    )),
                ),
                Expanded(
                  child: Align(
                    alignment: AlignmentDirectional.bottomCenter,
                    child: Container(
                      height: 80.h,
                      width: 80.h,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(50.r),
                        child: CachedNetworkImage(
                          key: UniqueKey(),
                          imageUrl: widget.userdata.photoUrl ??
                              "https://images.unsplash.com/photo-1494790108377-be9c29b29330?auto=format&fit=crop&q=80&w=2187&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
                          fit: BoxFit.cover,
                          placeholder: (context, url) => Container(
                            child: Lottie.asset(
                              'assets/images/loading_animation.json', // Replace with your animation file path
                              width: 200,
                              height: 200,
                              // Other properties you can customize
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),

                /// SizedBox(height: 10.h,),
                Text(
                widget.userdata.firstName ??  "Andrea Biscout",
                  style: style.copyWith(fontSize: 20.sp),
                ),
                Text(
                widget.userdata.about??  "How may i help you?",
                  style: style.copyWith(fontSize: 20.sp),
                ),
                SizedBox(
                  height: 10.h,
                ),
                // GestureDetector(
                //   onTap: (){
                //     //follow button code here 
                //     print(profileUserId);
                //     print(currentUserId);
                //     setState(() {
                //       isLoading = true;
                //     });
                   
                //     //  if(isFollowing) {
                //     //   unfollowUser(currentUserId,profileUserId).then((value) {
                //     //     setState(() {
                //     //       isLoading = false;
                //     //       isFollowing = false;
                        
                //     //     });
                //     //   });
                //     //  }else {
                //     //     followUser(currentUserId,profileUserId).then((value) {
                //     //   setState(() {
                //     //     isLoading = false;
                //     //     isFollowing = true;
                //     //   });
                //     // });

                //     //  }
                  
                  
                     
                   

                //   },
                //   child: Container(
                //     height: 40.h,
                //     width: 150.w,
                //     margin: EdgeInsets.only(bottom: 10.h),
                //     decoration: BoxDecoration(
                //         gradient: LinearGradient(
                //           colors: [
                //             Colors.white,
                //            isFollowing ? textColor.withOpacity(0.1) : Colors.grey.shade400,
                //             Colors.white,
                //           ],
                //           stops: [0.0, 0.5, 1.0],
                //           begin: Alignment.topCenter,
                //           end: Alignment.bottomCenter,
                //         ),
                //         borderRadius: BorderRadius.all(Radius.circular(10.r))),
                //         child: Align(
                //           alignment: Alignment.center,
                //           child: 
                          
                //         isLoading ? CircularProgressIndicator(
                //           color: Colors.white,
                //         ) : Text
                //           (
                            
                //             isFollowing ? "Following" :   "Follow" , style: style.copyWith(
                //              color:   isFollowing ?Colors.black : Colors.black,
                //             fontSize: 20.sp,
                            
                //           ),),
                //         ),
                //   ),
                // ),
              ],
            ),
          ),
          Container(
            height: 80.h,
            margin: EdgeInsets.only(left: 10.h,right: 10.h),
            //color: Colors.amber,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                //Number of properties
                Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text("Properties" , style: style.copyWith(
                      color: Colors.black,
                      fontSize: 18.sp
                    ),),
                     Text(postCount.toString() , style: numberStyle.copyWith(
                      color: Colors.black,
                      fontSize: 18.sp
                    ),)
                  ],
                ),
                //Number of followers
                // Column(
                //     mainAxisAlignment: MainAxisAlignment.center,
                //      crossAxisAlignment: CrossAxisAlignment.center,
                //   children: [
                //        Text("Followers" , style: style.copyWith(
                //       color: Colors.black,
                //       fontSize: 18.sp
                //     ),),
                //      Text(followersCount.toString() , style: numberStyle.copyWith(
                //       color: Colors.black,
                //       fontSize: 18.sp
                //     ),),
                    
                    

                //   ],

                // ),
                //Number of following
                // Column(
                //   mainAxisAlignment: MainAxisAlignment.center,
                //    crossAxisAlignment: CrossAxisAlignment.center,
                //   children: [
                //        Text("Following" , style: style.copyWith(
                //       color: Colors.black,
                //       fontSize: 18.sp
                //     ),),
                //      Text(followingCount.toString() , style: numberStyle.copyWith(
                //       color: Colors.black,
                //       fontSize: 18.sp
                //     ),)

                //   ],
                // )
              ],
            ),
          ),
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          Padding(
            padding: EdgeInsets.only(left: 20.h),
            child: Align(
              alignment: Alignment.topLeft,
              child: Text("My Properties" , style: style.copyWith(
                fontSize: 20.sp,
                color: Shade2purple,
                fontWeight: FontWeight.bold
              ),),
            ),
          ), 
          SizedBox(height: 10.h,),

             Expanded(
            child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                stream: getPostsForCurrentUser(
                    widget.userdata.userId!),
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
                            print("hello");
                             Navigator.push(context,
                             
                             MaterialPageRoute(
                                builder: (context) => postDetailScreen(
                                  postModel: post,
                                  postId: documents[index].id,
                                ),
                              ));
                           

                          },
                          child: Post(
                            postModel: post,
                            userId: post.userid,
                            id: documents[index].id,
                            likes: likes,
                            isMyProperty: false,
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
     
     bottomNavigationBar: Container(
    
      //height: 60.h,
      decoration: BoxDecoration(
        color: Colors.white,
      boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  spreadRadius: 5,
                  blurRadius: 7,
                  offset: Offset(0, -3), // Offset to create a top shadow
                ),
              ],

      ),
      child:  GestureDetector(
        onTap: (){
      //     //open message chat
            Navigator.push(
              context,
             MaterialPageRoute(
                builder: (_) => ChatScreen(
               user: widget.userdata,
                 )));
         },
       child: Container(
           height: 60.h,
         width: 200.w,
          alignment: Alignment.center,
          decoration: BoxDecoration(
     gradient: LinearGradient(
         begin: Alignment.topCenter,
                   end: Alignment.bottomCenter,
     colors: [mainAppColor, Colors.black]
           ),
                   
                     
     //  borderRadius: BorderRadius.circular(10.r)
      ),
         child: Row(
   crossAxisAlignment: CrossAxisAlignment.center,
       mainAxisAlignment: MainAxisAlignment.center,

          children: [
         Icon(Icons.message_outlined,color: Colors.white,size: 25),
         SizedBox(width: 10.h,),
            Text("Message" , style: style.copyWith(
             color: Colors.white,
             fontSize: 20.sp
     ),),
   ],
       ),
               
          
     ),
    ),
     ),
  
    );
  }
}

