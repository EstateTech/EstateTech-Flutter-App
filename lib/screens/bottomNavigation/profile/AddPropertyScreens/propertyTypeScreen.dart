// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:crypto_estate_tech/model/postModel.dart';
import 'package:crypto_estate_tech/screens/bottomNavigation/profile/AddPropertyScreens/addPhotosScreen.dart';
import 'package:crypto_estate_tech/screens/bottomNavigation/profile/AddPropertyScreens/offeredSpaceScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:crypto_estate_tech/common/ColorConstants.dart';
import 'package:crypto_estate_tech/common/custom_create_post_header.dart';
import 'package:crypto_estate_tech/common/custom_post_create_bottom.dart';
import 'package:crypto_estate_tech/common/list_constants.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../../../common/widgetConstants.dart';
import '../../../../components/grid_item_widet.dart';

class PropertyTypeScreen extends StatefulWidget {
  final bool isMorePropertyScreen;
  final bool  isEdited;
  final PostModel postModel;
  const PropertyTypeScreen({
    Key? key,
    this.isMorePropertyScreen = false,

    this.isEdited = false, required this.postModel
    
  }) : super(key: key);

  @override
  State<PropertyTypeScreen> createState() => _PropertyTypeScreenState();
}

class _PropertyTypeScreenState extends State<PropertyTypeScreen> {
 String  propertyType = '';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if(widget.isEdited) {
      propertyType = widget.postModel.propertyType!;
    }
   
  }

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
                child: GridView.builder(
                  padding: EdgeInsets.zero,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 1.4,
                  ),
                  itemCount: selectPropertyTypeMap.length,
                  itemBuilder: (BuildContext context, int index) {
                    return GestureDetector(
                      onTap: () {
                        
                       
                        setState(() {
                          propertyType = selectPropertyTypeMap.keys
                              .elementAt(index)
                              .toString();

                         widget. postModel.propertyType = selectPropertyTypeMap.keys
                              .elementAt(index)
                              .toString();

                         
                        });
                        print(propertyType);
                      },
                      child: GridItemWidget(
                          selectedText: propertyType ==
                                  selectPropertyTypeMap.keys.elementAt(index)
                              ? true
                              : false,
                          icon: selectPropertyTypeMap.values.elementAt(index),
                          text: selectPropertyTypeMap.keys.elementAt(index)),
                    );
                  },
                ),
              ),
              Padding(
                padding: EdgeInsets.only(right: 12.h, left: 12.h, bottom: 10.h),
                child: customPostCreateBottomWidget(
                  OnPressedNextButton: () {
                    if (propertyType.isNotEmpty) {

                      widget.postModel.propertyType = propertyType;

                      print(widget.postModel.toJson());



                      widget.isMorePropertyScreen
                          ? Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => AddPhotoScreen(
                                        postModel: widget.postModel,
                                        isEdited:  widget.isEdited,
                                      )))
                          : Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => OfferedSpaceScreen(
                                        postModel:  widget. postModel,
                                      
                                        isEdited: widget.isEdited,
                                      )));
                    } else {
                      Fluttertoast.showToast(
                          msg: 'Please select the property type');
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
