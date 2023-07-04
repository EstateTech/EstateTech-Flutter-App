import 'package:crypto_estate_tech/common/widgetConstants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../common/ColorConstants.dart';

class PropertyTypeGridWidget extends StatefulWidget {
  final Map<String, Widget> widgetMap;
  const PropertyTypeGridWidget({super.key, required this.widgetMap});

  @override
  State<PropertyTypeGridWidget> createState() => _PropertyTypeGridWidgetState();
}

class _PropertyTypeGridWidgetState extends State<PropertyTypeGridWidget> {
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: EdgeInsets.zero,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 1.4,
      ),
      itemCount: widget.widgetMap.length,
      itemBuilder: (BuildContext context, int index) {
        return GridItemWidget(
            icon: widget.widgetMap.values.elementAt(index),
            text: widget.widgetMap.keys.elementAt(index));
      },
    );
  }

  Widget GridItemWidget({required Widget icon, required String text}) {
    return Container(
      alignment: Alignment.topLeft,
      padding: EdgeInsets.only(left: 10.h, top: 10.h),
      margin: EdgeInsets.only(left: 10.h, right: 10.h, top: 10.h),
      decoration: BoxDecoration(
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
