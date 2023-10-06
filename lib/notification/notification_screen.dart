import 'package:cached_network_image/cached_network_image.dart';
import 'package:crypto_estate_tech/common/ColorConstants.dart';
import 'package:crypto_estate_tech/common/fixedvalues.dart';
import 'package:crypto_estate_tech/common/widgetConstants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class NotificationScreen extends StatelessWidget {
  NotificationScreen({super.key});

  List images = [
    'https://firebasestorage.googleapis.com/v0/b/crypto-estate-tech---app.appspot.com/o/profile_photos%2Fmichael-dam-mEZ3PoFGs_k-unsplash.jpg?alt=media&token=3318348a-1cf0-4fa9-af3e-d76ecf51734a&_gl=1*qxkql9*_ga*MzQ5NzczNzQxLjE2OTUzMTUzOTU.*_ga_CW55HF8NVT*MTY5NjU4MjcwMi41MS4xLjE2OTY1ODI3NTUuNy4wLjA.',
    'https://firebasestorage.googleapis.com/v0/b/crypto-estate-tech---app.appspot.com/o/profile_photos%2Faiony-haust-3TLl_97HNJo-unsplash.jpg?alt=media&token=3724d90c-1703-47bf-924d-5df385c51baf&_gl=1*a5xtw*_ga*MzQ5NzczNzQxLjE2OTUzMTUzOTU.*_ga_CW55HF8NVT*MTY5NjU4MjcwMi41MS4xLjE2OTY1ODI3NTguNC4wLjA.'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Container(
          // padding: EdgeInsets.symmetric(horizontal: 14.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 14.h,
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 14.w),
                child: Row(
                  children: [
                    Center(
                        child: IconButton(
                            padding: EdgeInsets.zero,
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            icon: Icon(Icons.arrow_back))),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 14.w),
                      child: Text(
                        'Notification',
                        style: style.copyWith(
                            color: Color(0xFF3A3153),
                            fontWeight: FontWeight.w700,
                            fontSize: 22.sp),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 14.h,
              ),
              Container(
                height: 1,
                color: Color(0xFF3A3153),
              ),
              SizedBox(
                height: 20.h,
              ),
              Expanded(
                child: ListView.builder(
                    itemCount: images.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text(
                          'Tom Reily started following you!',
                          style: style.copyWith(
                              color: Color(0xFF3A3153),
                              fontWeight: FontWeight.w700,
                              fontSize: 15.sp),
                        ),
                        contentPadding: EdgeInsets.all(16.w),
                        leading: CircleAvatar(
                          radius: 25.r,
                          backgroundImage:
                              CachedNetworkImageProvider(images[index]),
                        ),
                      );
                    }),
              )
            ],
          ),
        ),
      ),
    );
  }
}
