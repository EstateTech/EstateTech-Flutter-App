import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerWidget extends StatelessWidget {
  final double width;
  final double height;
  final ShapeBorder shapeBorder;
  const ShimmerWidget.rectangular({
    super.key, required this.width, required this.height}) 
    : this.shapeBorder = const RoundedRectangleBorder() ;

const ShimmerWidget.circular({
  super.key, required this.width, 
  required this.height , this.shapeBorder = const CircleBorder()});

  @override
  Widget build(BuildContext context) {
    return  Shimmer.fromColors(
      baseColor: Colors.grey.shade400,
      highlightColor: Colors.grey.shade300,

      child: Container(
        width: width,
        height: height,
        color: Colors.grey,
        decoration: ShapeDecoration(shape: shapeBorder),
      ),
    );
  }
}

Widget buildTileShimmer(int count) {
  return ListView.builder(
    itemCount: count,
    itemBuilder: (context,index) {
      return const ListTile(
        leading: ShimmerWidget.circular(height: 164,width: 164,),
        title: ShimmerWidget.rectangular(width: double.infinity, height: 16),
         subtitle: ShimmerWidget.rectangular(width: double.infinity, height: 14),
  
      );
    }
  );
}