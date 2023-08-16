import 'package:crypto_estate_tech/common/ColorConstants.dart';
import 'package:crypto_estate_tech/common/widgetConstants.dart';
import 'package:crypto_estate_tech/helperclass/dataFromFirestore.dart';
import 'package:crypto_estate_tech/model/postModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class GridPost extends StatefulWidget {
  final PostModel postModel;
  final String userId;
  final bool isRecomendationPage;
  const GridPost({
    super.key,
    required this.postModel,
    required this.userId,  this.isRecomendationPage = false,
  });

  @override
  State<GridPost> createState() => _GridPostState();
}

class _GridPostState extends State<GridPost> {
   String memberType = 'Loading';

   void fetchMemberType() async {
    print("the user id is ${widget.userId}");
    String type = await getMemberType(widget.userId);
    if(mounted){
 setState(() {
      memberType = type;
    });
    }
   
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
     fetchMemberType();
  }
  
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10.h),
      width: 150.w,
      height: 150.h,
      decoration: BoxDecoration(
        
          ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              Container(
                height: 150.h,
                decoration: BoxDecoration(
                    color: Colors.grey.shade200,
                    borderRadius: BorderRadius.circular(25.r),
                    image: DecorationImage(
                        image: NetworkImage(widget.postModel.propertyPhotos![0]!),
                        fit: BoxFit.fitHeight
                        
                        )),
              ),
             Positioned(
                  top: 10.h,
                  left: 5.h,
                  child:  memberType == "Loading" ?  Text("Loading.."
                  ) :Text(memberType,style: style.copyWith(
                    color: Color(0xff0D2769),
                    fontSize: 14.sp,
                    fontWeight: FontWeight.bold
                  ),)),

                  Positioned(
                  top: 1.h,
                  right: 5.h,
                  child: IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.favorite_border,
                      color: Colors.white,
                      size: 30.h,
                    ),
                  )),
           
            ],
          ),
          SizedBox(
            height: 5.h,
          ),
          FittedBox(
           fit: BoxFit.scaleDown,
           alignment: Alignment.center,
            child: Text(
             getFirstThreeWords(widget.postModel.propertyDescription!),
            
              style: style.copyWith(
                  fontSize: 20.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
                   maxLines: 1,
            ),
          ),
         widget.isRecomendationPage? Container(): Container(
            height: 50.h,
            // color: Colors.blue,
            child: Text(
              widget.postModel.additionalInfo!,
              style: style2.copyWith(color: Color(0xff717171), fontSize: 18.sp),
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
            ),
          ),
          RichText(
              text: TextSpan(
                  style: style.copyWith(
                      color: Colors.black,
                      fontSize: 20.sp,
                      fontWeight: FontWeight.bold),
                  children: <TextSpan>[
                TextSpan(text: "300,0000 AED"),
                TextSpan(
                  text: ' / year',
                  style: style2.copyWith(
                    color: Colors.black,
                    fontSize: 18.sp,
                  ),
                ),
              ]))
        ],
      ),
    );
  }
}
