import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../common/ColorConstants.dart';
import '../common/widgetConstants.dart';

class GridItemWidget extends StatelessWidget {
  const GridItemWidget(
      {super.key,
      required this.icon,
      required this.text,
      required this.selectedText});

  final Widget icon;
  final String text;
  final bool selectedText;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.topLeft,
      padding: EdgeInsets.only(left: 10.h, top: 10.h),
      margin: EdgeInsets.only(left: 10.h, right: 10.h, top: 10.h),
      decoration: BoxDecoration(
          color: selectedText ? Colors.grey.shade200 : Colors.transparent,
          border: Border.all(color: textwalktrough),
          borderRadius: BorderRadius.circular(15.r)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          icon,
          SizedBox(
            height: 5.h,
          ),
          Text(
            text,
            style: style.copyWith(fontSize: 16.sp, color: textwalktrough),
          )
        ],
      ),
    );
  }
}
