import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class InboxScreen extends StatelessWidget {
  InboxScreen({super.key});

  List images = [
    {
      'title': 'Tom Reily',
      'images':
          'https://images.unsplash.com/photo-1633332755192-727a05c4013d?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=2960&q=80'
    },
    {
      'title': 'Nancy Bailer',
      'images':
          'https://images.unsplash.com/photo-1494790108377-be9c29b29330?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=2787&q=80'
    },
    {
      'title': 'Edward McFurr',
      'images':
          'https://images.unsplash.com/photo-1438761681033-6461ffad8d80?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=2940&q=80'
    }
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: PreferredSize(
          preferredSize: Size(MediaQuery.of(context).size.width * 1, 70),
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 18.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Text(
                      'Inbox',
                      style: GoogleFonts.dmSans(
                          color: Color(0xFF3A3153),
                          fontSize: 22.sp,
                          fontWeight: FontWeight.w700),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Icon(
                      Icons.search,
                      color: Color(0xFF3A3153),
                      size: 29.w,
                    ),
                    SizedBox(
                      width: 10.w,
                    ),
                    Icon(
                      Icons.edit,
                      color: Color(0xFF3A3153),
                      size: 29.w,
                    ),
                    SizedBox(
                      width: 10.w,
                    ),
                    Icon(
                      Icons.delete_outline,
                      color: Color(0xFF3A3153),
                      size: 29.w,
                    )
                  ],
                )
              ],
            ),
          ),
        ),
        body: Column(
          children: [
            SizedBox(
              height: 20.h,
            ),
            Container(
              height: 1.h,
              color: Colors.black,
            ),
            SizedBox(
              height: 20.h,
            ),
            Expanded(
              child: ListView.builder(
                  itemCount: images.length,
                  // shrinkWrap: true,
                  // physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    return Container(
                      margin: EdgeInsets.symmetric(vertical: 10.w),
                      child: ListTile(
                        contentPadding:
                            EdgeInsets.symmetric(horizontal: 14.w, vertical: 0),
                        leading: Container(
                          width: 90.w,
                          height: 90.h,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                  image: NetworkImage(
                                      '${images[index]['images']}'),
                                  alignment: Alignment.topCenter,
                                  fit: BoxFit.cover)),
                        ),
                        title: Text(
                          '${images[index]['title']}',
                          textAlign: TextAlign.left,
                          style: GoogleFonts.dmSans(
                              color: Color(
                                0xFF3A3153,
                              ),
                              fontWeight: FontWeight.bold,
                              fontSize: 18.sp),
                        ),
                        subtitle: Text(
                          'Hey there ! Yes, I’ll be there.',
                          style: GoogleFonts.dmSans(
                              color: Color(
                                0xFF3A3153,
                              ),
                              fontWeight: FontWeight.w400,
                              fontSize: 14.sp),
                        ),
                        trailing: Icon(
                          Icons.done_all_rounded,
                          color: Color(0xFF3078CC),
                        ),
                      ),
                    );
                  }),
            )
          ],
        ),
      ),
    );
  }
}
