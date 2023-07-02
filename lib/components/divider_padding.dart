import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DividerPending extends StatelessWidget {
  const DividerPending({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 12.h, right: 12.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: Container(
              height: 1,
              width: 100,
              color: Colors.white,
            ),
          ),
          SizedBox(width: 8), // Adjust the spacing as needed
          Text(
            'Or',
            style: TextStyle(color: Colors.white),
          ),
          SizedBox(width: 8), // Adjust the spacing as needed
          Expanded(
            child: Container(
              height: 1,
              width: 100,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
