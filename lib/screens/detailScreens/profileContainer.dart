import 'package:crypto_estate_tech/common/ColorConstants.dart';
import 'package:crypto_estate_tech/common/widgetConstants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class profileContainer extends StatelessWidget {
  const profileContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 300.h,
     
      padding: EdgeInsets.only(left: 20.h, right: 20.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 20.h,
          ),
          Row(
            children: [
              Container(
                height: 100.h,
                width: 100.h,
                decoration:
                    BoxDecoration(shape: BoxShape.circle, color: Colors.black,
                    image: DecorationImage(image: NetworkImage("https://images.unsplash.com/photo-1494790108377-be9c29b29330?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8M3x8cHJvZmlsZXxlbnwwfHwwfHx8MA%3D%3D&auto=format&fit=crop&w=600&q=60"
                    ,
                    ),fit: BoxFit.cover
                    )
                    
                    
                    ),
                    
              ),
              SizedBox(
                width: 20.h,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Andera Biscotti",
                    style: style.copyWith(
                      fontFamily: "Circular Std",
                      fontSize: 22,
                      fontWeight: FontWeight.w500,
                      color: Color(0xff3a3153),
                    ),
                    textAlign: TextAlign.left,
                  ),
                  Text(
                    "Area Manager at White\n & Co Real Estate",
                    style: style.copyWith(
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w300,
                      color: Color(0xff4e4a59),
                    ),
                    textAlign: TextAlign.left,
                  )
                ],
              )
            ],
          ),
          SizedBox(
            height: 10.h,
          ),
          RichText(
            text: TextSpan(
              style: style.copyWith(
                fontSize: 18.sp,
                fontWeight: FontWeight.bold,
                color: Color(0xff3a3153),
              ),
              children: <TextSpan>[
                TextSpan(
                  text: 'Response time :',
                ),
                TextSpan(
                  text: 'Within 7 minutes',
                  style: style.copyWith(
                    fontWeight: FontWeight.normal,
                    color: Color(0xff4e4a59),
                    fontSize: 18.sp,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 5.h,
          ),
          RichText(
            text: TextSpan(
              style: style.copyWith(
                fontSize: 18.sp,
                fontWeight: FontWeight.bold,
                color: Color(0xff3a3153),
              ),
              children: <TextSpan>[
                TextSpan(
                  text: "Experience:",
                ),
                TextSpan(
                  text: '3 years',
                  style: style.copyWith(
                    fontWeight: FontWeight.normal,
                    color: Color(0xff4e4a59),
                    fontSize: 18.sp,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 5.h,
          ),
          RichText(
            text: TextSpan(
              style: style.copyWith(
                fontSize: 18.sp,
                fontWeight: FontWeight.bold,
                color: Color(0xff3a3153),
              ),
              children: <TextSpan>[
                TextSpan(
                  text: "Languages:",
                ),
                TextSpan(
                  text: "English, Italian",
                  style: style.copyWith(
                    fontWeight: FontWeight.normal,
                    color: Color(0xff4e4a59),
                    fontSize: 18.sp,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 20.h,
          ),
          Container(
            width: double.infinity,
            height: 55.h,
            alignment: Alignment.center,
            decoration: BoxDecoration(
                color: Shade2purple,
                borderRadius: BorderRadius.circular(25.r),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5), // Shadow color
                    spreadRadius: 2, // Spread radius
                    blurRadius: 5, // Blur radius
                    offset: Offset(0, 3), // Offset in x and y direction
                  ),
                ]),
            child: Text(
              "User Properties",
              style: style.copyWith(color: Colors.white, fontSize: 18.sp),
            ),
          ),
        ],
      ),
    );
  }
}
