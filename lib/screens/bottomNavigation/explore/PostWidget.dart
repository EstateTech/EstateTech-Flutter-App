import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Post extends StatefulWidget {
  const Post({super.key});

  @override
  State<Post> createState() => _PostState();
}

class _PostState extends State<Post> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 20.0),
      height: 400.h,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
          color: Colors.amber, borderRadius: BorderRadius.circular(25.r)),
    );
  }
}
