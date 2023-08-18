import 'package:crypto_estate_tech/common/list_constants.dart';
import 'package:crypto_estate_tech/common/widgetConstants.dart';
import 'package:crypto_estate_tech/model/postModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AnimetiesContainer extends StatelessWidget {
  final PostModel postModel;
  const AnimetiesContainer({super.key, required this.postModel});

  @override
  Widget build(BuildContext context) {
    int itemCount = postModel.utilities!.length;
    double itemHeight = 20.h + 10.h; // Icon height + spacing

    double containerHeight = (itemCount / 2).ceil() * itemHeight +
        40.h; // Adjust based on your needs

    return Container(
      width: MediaQuery.sizeOf(context).width,
      padding: EdgeInsets.only(left: 20.h, right: 20.h),
      decoration: const BoxDecoration(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Animeties",
            style:
                style.copyWith(color: const Color(0xff3A3153), fontSize: 20.sp),
          ),
          SizedBox(height: 5.h),
          SizedBox(
            height: containerHeight - 25.h,
            child: GridView.builder(
              padding: EdgeInsets.zero,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, // Two items in each row
                crossAxisSpacing: 7.0, // Spacing between columns
                mainAxisSpacing: 10.0, // Spacing between rows
                childAspectRatio: 7.0,
              ),
              itemCount: postModel.utilities!.length,
              itemBuilder: (context, index) {
                return _buildItemWidget(postModel.utilities![index]);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget getWidgetByKey(String key) {
    if (selectPropertyFeaturesMap.containsKey(key)) {
      return selectPropertyFeaturesMap[key]!;
    } else {
      // Return a default widget or handle the missing key case
      return Container();
    }
  }

  _buildItemWidget(String item) {
    return Container(
      decoration: const BoxDecoration(),
      child: Row(
        children: [
          SizedBox(
            width: 7.w,
          ),
          SizedBox(height: 20.h, width: 20.w, child: getWidgetByKey(item)),
          SizedBox(
            width: 7.w,
          ),
          Text(
            item,
            style:
                style.copyWith(fontSize: 15.sp, color: const Color(0xff4E4A59)),
          ),
        ],
      ),
    );
  }
}
