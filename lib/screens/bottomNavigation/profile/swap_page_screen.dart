import 'package:crypto_estate_tech/common/ColorConstants.dart';
import 'package:crypto_estate_tech/common/custom_button_widget.dart';
import 'package:crypto_estate_tech/common/widgetConstants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SwapPageScreen extends StatefulWidget {
  SwapPageScreen({super.key});

  @override
  State<SwapPageScreen> createState() => _SwapPageScreenState();
}

class _SwapPageScreenState extends State<SwapPageScreen> {
  List<String> percentage = ['25%', '50%', '75%', 'MAX'];

  Object? selected = '1';
  Object? selected1 = '4';
  //var selected;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 14.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(
                    Icons.arrow_back,
                    size: 28.w,
                    color: Colors.black87,
                  )),
              SizedBox(
                height: 20.h,
              ),
              Stack(
                children: [
                  Column(
                    children: [
                      Container(
                        height: 160.h,
                        padding: EdgeInsets.symmetric(
                            horizontal: 20.w, vertical: 14.h),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.r),
                            gradient: LinearGradient(
                              stops: [0.0, 1.5],
                              begin: FractionalOffset.topRight,
                              end: FractionalOffset.bottomRight,
                              colors: [
                                mainAppColor,
                                Colors.black.withOpacity(1),
                              ],
                            )),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Pay',
                                  style: style.copyWith(
                                      color: Colors.white,
                                      fontSize: 20.sp,
                                      fontWeight: FontWeight.bold),
                                ),
                                Wrap(
                                  children: percentage.map((e) {
                                    return Container(
                                        margin: EdgeInsets.symmetric(
                                            horizontal: 4.w),
                                        padding: EdgeInsets.all(5.w),
                                        decoration: BoxDecoration(
                                            border:
                                                Border.all(color: Colors.white),
                                            borderRadius:
                                                BorderRadius.circular(10.r)),
                                        child: Text(
                                          '$e',
                                          style: style.copyWith(
                                              color: Colors.white,
                                              fontSize: 12.sp,
                                              fontWeight: FontWeight.bold),
                                        ));
                                  }).toList(),
                                )
                              ],
                            ),
                            SizedBox(
                              height: 20.h,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  child: Text(
                                    '3,675.39',
                                    style: style.copyWith(
                                        color: Colors.white,
                                        fontSize: 24.sp,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                Container(
                                  // width: 100.w,

                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          width: 1.5, color: Colors.white),
                                      borderRadius:
                                          BorderRadius.circular(40.r)),
                                  child: DropdownButtonHideUnderline(
                                    child: ButtonTheme(
                                      alignedDropdown: true,
                                      child: DropdownButton(
                                          icon: Icon(
                                            Icons.keyboard_arrow_down_sharp,
                                            color: Colors.white,
                                          ),
                                          hint: Text('Select coin'),
                                          value: selected,
                                          onChanged: (v) {
                                            setState(
                                              () {
                                                selected = v;
                                              },
                                            );
                                          },
                                          dropdownColor:
                                              mainAppColor.withOpacity(1),
                                          items: bitcoinCurrency
                                              .map((coin) => DropdownMenuItem(
                                                  value: coin['id'],
                                                  child: Container(
                                                    // color:
                                                    //     mainAppColor.withOpacity(0.1),
                                                    child: Row(
                                                      children: [
                                                        Container(
                                                            width: 25.w,
                                                            height: 25.h,
                                                            child:
                                                                Image.network(
                                                              coin['flag'],
                                                              fit: BoxFit.fill,
                                                            )),
                                                        Container(
                                                          margin:
                                                              EdgeInsets.only(
                                                                  left: 5.w),
                                                          child: Text(
                                                            '${coin['Code']}',
                                                            style: style.copyWith(
                                                                color: Colors
                                                                    .white,
                                                                fontSize: 24.sp,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold),
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                  )))
                                              .toList()),
                                    ),
                                  ),
                                )
                              ],
                            ),
                            SizedBox(
                              height: 8.h,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  '=\$272.63',
                                  style: style.copyWith(
                                      color: Colors.white,
                                      fontSize: 12.sp,
                                      fontWeight: FontWeight.w200),
                                ),
                                Container(
                                  padding: EdgeInsets.only(right: 24.w),
                                  child: Text(
                                    'Balance: 37.83',
                                    style: style.copyWith(
                                        color: Colors.white,
                                        fontSize: 12.sp,
                                        fontWeight: FontWeight.w200),
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      Container(
                        height: 160.h,
                        padding: EdgeInsets.symmetric(
                            horizontal: 20.w, vertical: 14.h),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.r),
                            gradient: LinearGradient(
                              stops: [0.0, 1.5],
                              begin: FractionalOffset.topRight,
                              end: FractionalOffset.bottomRight,
                              colors: [
                                mainAppColor,
                                Colors.black.withOpacity(1),
                              ],
                            )),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Recieve',
                                  style: style.copyWith(
                                      color: Colors.white,
                                      fontSize: 20.sp,
                                      fontWeight: FontWeight.bold),
                                ),
                                // Wrap(
                                //   children: percentage.map((e) {
                                //     return Container(
                                //         margin: EdgeInsets.symmetric(
                                //             horizontal: 4.w),
                                //         padding: EdgeInsets.all(5.w),
                                //         decoration: BoxDecoration(
                                //             border:
                                //                 Border.all(color: Colors.white),
                                //             borderRadius:
                                //                 BorderRadius.circular(10.r)),
                                //         child: Text(
                                //           '$e',
                                //           style: style.copyWith(
                                //               color: Colors.white,
                                //               fontSize: 12.sp,
                                //               fontWeight: FontWeight.bold),
                                //         ));
                                //   }).toList(),
                                // )
                              ],
                            ),
                            SizedBox(
                              height: 20.h,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  child: Text(
                                    '3,675.39',
                                    style: style.copyWith(
                                        color: Colors.white,
                                        fontSize: 24.sp,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                Container(
                                  // width: 100.w,

                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          width: 1.5, color: Colors.white),
                                      borderRadius:
                                          BorderRadius.circular(40.r)),
                                  child: DropdownButtonHideUnderline(
                                    child: ButtonTheme(
                                      alignedDropdown: true,
                                      child: DropdownButton(
                                          icon: Icon(
                                            Icons.keyboard_arrow_down_sharp,
                                            color: Colors.white,
                                          ),
                                          hint: Text('Select coin'),
                                          value: selected1,
                                          onChanged: (v) {
                                            setState(
                                              () {
                                                selected = v;
                                              },
                                            );
                                          },
                                          dropdownColor:
                                              mainAppColor.withOpacity(1),
                                          items: bitcoinCurrency
                                              .map((coin) => DropdownMenuItem(
                                                  value: coin['id'],
                                                  child: Container(
                                                    // color:
                                                    //     mainAppColor.withOpacity(0.1),
                                                    child: Row(
                                                      children: [
                                                        Container(
                                                            width: 25.w,
                                                            height: 25.h,
                                                            child:
                                                                Image.network(
                                                              coin['flag'],
                                                              fit: BoxFit.fill,
                                                            )),
                                                        Container(
                                                          margin:
                                                              EdgeInsets.only(
                                                                  left: 5.w),
                                                          child: Text(
                                                            '${coin['Code']}',
                                                            style: style.copyWith(
                                                                color: Colors
                                                                    .white,
                                                                fontSize: 24.sp,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold),
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                  )))
                                              .toList()),
                                    ),
                                  ),
                                )
                              ],
                            ),
                            SizedBox(
                              height: 8.h,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  '=\$272.63',
                                  style: style.copyWith(
                                      color: Colors.white,
                                      fontSize: 12.sp,
                                      fontWeight: FontWeight.w200),
                                ),
                                Container(
                                  padding: EdgeInsets.only(right: 24.w),
                                  child: Text(
                                    'Balance: 37.83',
                                    style: style.copyWith(
                                        color: Colors.white,
                                        fontSize: 12.sp,
                                        fontWeight: FontWeight.w200),
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                  Positioned(
                    top: 150.h,
                    left: 140.w,
                    right: 140.w,
                    child: Container(
                        // width: 50.w,
                        // height: 40.h,
                        padding: EdgeInsets.all(5.w),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          //borderRadius: BorderRadius.circular(2.r),
                          gradient: LinearGradient(
                            stops: [0.0, 1.5],
                            begin: FractionalOffset.topRight,
                            end: FractionalOffset.bottomRight,
                            colors: [
                              mainAppColor,
                              Colors.black.withOpacity(1),
                            ],
                          ),
                        ),
                        child: Icon(
                          Icons.swap_vert,
                          color: Colors.white,
                          size: 28.w,
                        )),
                  )
                ],
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 14.w),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: EdgeInsets.only(top: 10.h),
                      child: Text(
                        '1 CET = 0.000367 ETH',
                        style: style.copyWith(
                            color: Color(0xFF08021A),
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w400),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 10.h, bottom: 10.h),
                      width: double.infinity,
                      height: 1.h,
                      decoration: BoxDecoration(color: Color(0xFF959595)),
                    ),
                    ListTile(
                      contentPadding: EdgeInsets.zero,
                      title: Text(
                        'Price Impact',
                        style: style.copyWith(
                            color: Color(0xFF08021A),
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w600),
                      ),
                      trailing: Text(
                        '0%',
                        style: style.copyWith(
                            color: Color(0xFF017940),
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                    ListTile(
                      contentPadding: EdgeInsets.zero,
                      title: Text(
                        'Minimum recieved after slippage',
                        style: style.copyWith(
                            color: Color(0xFF08021A),
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w600),
                      ),
                      trailing: Text(
                        '151,87',
                        style: style.copyWith(
                            color: Colors.black,
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                    ListTile(
                      contentPadding: EdgeInsets.zero,
                      title: Text(
                        'Network Fee',
                        style: style.copyWith(
                            color: Color(0xFF08021A),
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w600),
                      ),
                      trailing: Text(
                        '\$2.56',
                        style: style.copyWith(
                            color: Colors.black,
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                    ListTile(
                      contentPadding: EdgeInsets.zero,
                      title: Text(
                        'Exchange Fee',
                        style: style.copyWith(
                            color: Color(0xFF08021A),
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w600),
                      ),
                      trailing: Text(
                        'Free',
                        style: style.copyWith(
                            color: Color(0xFF017940),
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                    CustomButton(
                      onPressed: () async {},
                      textStyle: style.copyWith(
                        color: Colors.white,
                        fontSize: 24.sp,
                        fontWeight: FontWeight.bold,
                      ),
                      borderColor: Colors.black,
                      text: 'Swap',
                      fillColor: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [mainAppColor, Colors.black]),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
