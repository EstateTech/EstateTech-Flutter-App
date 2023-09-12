import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../common/ColorConstants.dart';
import '../../../../common/widgetConstants.dart';

class ProfileImageButtons extends StatelessWidget {
  final String imagePath;
  final VoidCallback onTap;
  final String text;
  const ProfileImageButtons({
    super.key,
    required this.imagePath,
    required this.onTap,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: 70.h,
        margin: EdgeInsets.only(right: 20.h),
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(20.r)),
        child: Stack(
          children: [
            Row(
              children: [
                Expanded(
                  flex: 1,
                  child: Container(
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage(imagePath), fit: BoxFit.contain)),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: ClipRRect(
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(15.r),
                        bottomRight: Radius.circular(15.r)),
                    child: Container(
                      height: 70.h,
                      alignment: Alignment.center,
                      decoration: const BoxDecoration(color: Shade2purple),
                      child: Text(
                        text,
                        style: style.copyWith(
                            color: Colors.white, fontSize: 21.sp),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                )
              ],
            ),
            Positioned(
              left: 100.h,
              child: ClipRRect(
                child: Container(
                  height: 70.h,
                  width: 20.h,
                  decoration: const BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                          color: Shade2purple,
                          blurRadius: 10,
                          spreadRadius: 2,
                          offset: Offset(3.0, 0))
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
