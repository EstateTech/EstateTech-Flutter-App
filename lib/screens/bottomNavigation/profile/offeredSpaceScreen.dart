import 'package:crypto_estate_tech/common/ColorConstants.dart';
import 'package:crypto_estate_tech/common/custom_create_post_header.dart';
import 'package:crypto_estate_tech/common/custom_post_create_bottom.dart';
import 'package:crypto_estate_tech/common/widgetConstants.dart';
import 'package:crypto_estate_tech/screens/bottomNavigation/profile/propertyMappedScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../../model/postModel.dart';

class OfferedSpaceScreen extends StatefulWidget {
  const OfferedSpaceScreen({super.key, required this.postModel});
  final PostModel postModel;

  @override
  State<OfferedSpaceScreen> createState() => _OfferedSpaceScreenState();
}

class _OfferedSpaceScreenState extends State<OfferedSpaceScreen> {
  List data = [
    {
      "title": "Entire place",
      "description": "Guests have the whole place for themselves"
    },
    {
      "title": "A room",
      "description": "Guests have their own room plus acces to shared spaces"
    },
    {
      "title": "A shared room",
      "description": "Guests share a room or common space with others"
    },
  ];

  List<Widget> icons = [
    SvgPicture.asset("assets/images/house_icon.svg"),
    SvgPicture.asset("assets/images/single_room_icon.svg"),
    SvgPicture.asset("assets/images/double_room_icon.svg")
  ];

  String selectedTile = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.only(left: 20.h, right: 20.h),
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(gradient: appBackgroundGradient),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            CustomCreatePostHeader(),
            // SizedBox(
            //   height: 20.h,
            // ),
            Text(
              "Which of these best describes your property?",
              style: style.copyWith(
                  fontSize: 25.sp,
                  color: textwalktrough,
                  fontWeight: FontWeight.w500),
            ),
            Container(
              width: double.infinity,
              margin: EdgeInsets.only(left: 15.h, right: 15.h),

              //  color: Colors.amber,
              child: Column(
                //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: List.generate(
                    3,
                    (index) => GestureDetector(
                          onTap: () {
                            setState(() {
                              print(data[index]['title']);
                              selectedTile = data[index]['title'];

                              widget.postModel.propertyPortion =
                                  data[index]['title'];
                            });
                          },
                          child: buildItem(index, "${data[index]['title']}",
                              "${data[index]['description']}", selectedTile),
                        )),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(right: 12.h, left: 12.h, bottom: 30.h),
              child: customPostCreateBottomWidget(
                OnPressedNextButton: () {
                  if (selectedTile.length != 0) {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => PropertyMappedScreen(
                                  postModel: widget.postModel,
                                )));
                  } else {
                    Fluttertoast.showToast(msg: 'Please select the space');
                  }
                },
                OnPressedbackButton: () {
                  Navigator.pop(context);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildItem(
      int index, String title, String description, String selectedTile) {
    return Container(
      padding: EdgeInsets.all(8.h),
      height: 100.0,
      width: double.infinity,
      margin: EdgeInsets.all(10.h),
      decoration: BoxDecoration(
        color:
            title == selectedTile ? Colors.grey.shade200 : Colors.transparent,
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(color: textwalktrough),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: style.copyWith(
                      color: textwalktrough,
                      fontSize: 20.sp,
                      fontWeight: FontWeight.w700),
                ),
                Text(
                  description,
                  style: style.copyWith(
                    color: textwalktrough,
                    fontSize: 15.sp,
                  ),
                )
              ],
            ),
          ),
          SizedBox(
            width: 20.w,
          ),
          Container(
            height: 40.h,
            width: 40.h,
            child: icons[index],
          )
        ],
      ),
    );
  }
}