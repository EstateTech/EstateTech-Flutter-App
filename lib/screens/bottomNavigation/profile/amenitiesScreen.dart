import 'package:crypto_estate_tech/common/list_constants.dart';
import 'package:crypto_estate_tech/screens/bottomNavigation/profile/addPhotosScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../../common/ColorConstants.dart';
import '../../../common/custom_create_post_header.dart';
import '../../../common/custom_post_create_bottom.dart';
import '../../../common/widgetConstants.dart';
import '../../../components/grid_item_widet.dart';
import '../../../model/postModel.dart';

class AmenitiesScreen extends StatefulWidget {
  const AmenitiesScreen({super.key, required this.postmodel});

  final PostModel postmodel;

  @override
  State<AmenitiesScreen> createState() => _AmenitiesScreenState();
}

class _AmenitiesScreenState extends State<AmenitiesScreen> {
  List<String> utilities = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.only(left: 20.h, right: 20.h),
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: const BoxDecoration(gradient: appBackgroundGradient),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SizedBox(
                height: 20.h,
              ),
              const CustomCreatePostHeader(),
              SizedBox(
                height: 20.h,
              ),
              Text(
                "Which of these best describes your property?",
                style: style.copyWith(
                    fontSize: 25.sp,
                    color: textwalktrough,
                    fontWeight: FontWeight.w500),
              ),
              Expanded(
                // height: 400.h,
                // width: double.infinity,
                //     child:   PropertyTypeGridWidget(
                //   selectedText: '',
                //   onPressed: () {},
                //   widgetMap: widget.isMorePropertyScreen
                //       ? selectPropertyFeaturesMap
                //       : selectPropertyTypeMap,
                // )

                child: GridView.builder(
                  padding: EdgeInsets.zero,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 1.4,
                  ),
                  itemCount: selectPropertyFeaturesMap.length,
                  itemBuilder: (BuildContext context, int index) {
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          if (utilities.contains(selectPropertyFeaturesMap.keys
                                  .elementAt(index)
                                  .toString()) ==
                              true) {
                            print('1');
                            print(selectPropertyFeaturesMap.keys
                                .elementAt(index)
                                .toString());
                            //  setState(() {
                            utilities.removeWhere((element) =>
                                element ==
                                selectPropertyFeaturesMap.keys
                                    .elementAt(index)
                                    .toString());
                            //  });
                          } else {
                            print('2');
                            // setState(() {
                            utilities.add(selectPropertyFeaturesMap.keys
                                .elementAt(index)
                                .toString());
                            //  });
                          }

                          print(utilities);
                        });
                      },
                      child: GridItemWidget(
                          selectedText: utilities.contains(
                                  selectPropertyFeaturesMap.keys
                                      .elementAt(index)
                                      .toString())
                              ? true
                              : false,
                          icon:
                              selectPropertyFeaturesMap.values.elementAt(index),
                          text:
                              selectPropertyFeaturesMap.keys.elementAt(index)),
                    );
                  },
                ),
              ),
              Padding(
                padding: EdgeInsets.only(right: 12.h, left: 12.h, bottom: 10.h),
                child: customPostCreateBottomWidget(
                  OnPressedNextButton: () {
                    setState(() {
                      widget.postmodel.utilities = utilities;
                    });

                    if (utilities.isNotEmpty) {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => AddPhotoScreen(
                                    postModel: widget.postmodel,
                                  )));
                    } else {
                      Fluttertoast.showToast(
                          msg: 'Please select atleast one utility type');
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
      ),
    );
  }
}
