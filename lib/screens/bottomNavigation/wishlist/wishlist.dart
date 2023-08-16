import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class WishlistPage extends StatefulWidget {
  const WishlistPage({super.key});

  @override
  State<WishlistPage> createState() => _WishlistPageState();
}

class _WishlistPageState extends State<WishlistPage> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Container()
      // Column(
      //   children: [
      //     SizedBox(
      //       height: 50.h,
      //     ),
      //     Row(
      //       children: [
      //        Column(
      //         children: [
      //           Container(
      //             height: 40.h,
      //             width: 40.h,
      //             child: SvgPicture.asset(
      //                     "assets/images/bxs_offer_icon.svg"),
      //           ),
      //           Text("Best Offers"),
      //           Container(
      //             width: 100.w,
      //             height: 4.h,
      //             color: Colors.amber,
      //           )
      //         ],
      //        ),
      //           Text("Hello world"),
      //             Text("Hello world"),
      //               Text("Hello world"),
      //       ],
      //     )
      //   ],
      // ),
    );
  }
}