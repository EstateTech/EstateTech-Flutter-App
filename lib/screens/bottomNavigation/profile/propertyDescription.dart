import 'package:crypto_estate_tech/common/ColorConstants.dart';
import 'package:crypto_estate_tech/common/custom_create_post_header.dart';
import 'package:crypto_estate_tech/common/custom_post_create_bottom.dart';
import 'package:crypto_estate_tech/common/list_constants.dart';
import 'package:crypto_estate_tech/common/widgetConstants.dart';
import 'package:crypto_estate_tech/model/postModel.dart';
import 'package:crypto_estate_tech/screens/walkthroughScreens/walkthroughStep3.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PropertyDescriptionScreen extends StatefulWidget {
  const PropertyDescriptionScreen({super.key, required this.postModel});

  final PostModel postModel;

  @override
  State<PropertyDescriptionScreen> createState() =>
      _PropertyDescriptionScreenState();
}

class _PropertyDescriptionScreenState extends State<PropertyDescriptionScreen> {
  TextEditingController descriptionController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          print(widget.postModel.toJson());
        },
      ),
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
            Column(
              children: [
                Text(
                  "Now, let’s give your house a title & description",
                  style: style.copyWith(
                      fontSize: 25.sp,
                      color: textwalktrough,
                      fontWeight: FontWeight.w500),
                ),
                SizedBox(
                  height: 10.h,
                ),
                Text(
                  "Describe your property in a few words, create your amazing motto!",
                  style: style.copyWith(fontSize: 15.sp, color: textwalktrough),
                ),
                SizedBox(
                  height: 20.h,
                ),
                Container(
                  alignment: Alignment.topLeft,
                  height: 110.h,
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20.r)),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          maxLines: null,
                          controller: descriptionController,
                          decoration: InputDecoration(
                            hintText: 'Type your motto here .....',
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                      IconButton(
                        icon: Icon(Icons.edit),
                        onPressed: () {
                          // Handle pencil icon button press
                        },
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 10.h,
                ),
                Text(
                  "Chose up to 2 highlights of the aboce to describe your property.",
                  style: style.copyWith(fontSize: 15.sp, color: textwalktrough),
                ),
                SizedBox(
                  height: 20.h,
                ),
                PropertyDescription()
              ],
            ),

            Padding(
              padding: EdgeInsets.only(right: 12.h, left: 12.h, bottom: 30.h),
              child: customPostCreateBottomWidget(
                OnPressedNextButton: () {
                  widget.postModel.propertyDescription =
                      descriptionController.text;

                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => WalkthroughStep3(
                                postModel: widget.postModel,
                              )));
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

  Widget PropertyDescription() {
    return Wrap(
      spacing: 9.0,
      runSpacing: 7.0,
      children: descriptionFeature.entries.map((entry) {
        final title = entry.key;
        final widget = entry.value;
        final iconColor = Colors.accents[
            descriptionFeature.keys.toList().indexOf(title) %
                Colors.accents.length];

        return GestureDetector(
          onTap: () {
            // Handle widget tap event
          },
          child: Container(
            height: 40.h,
            width: 150.w,
            padding: EdgeInsets.symmetric(horizontal: 12.w),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20.r),
              border: Border.all(color: Shade2purple),
            ),
            child: Row(
              children: [
                widget,
                SizedBox(width: 8.w),
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        );
      }).toList(),
    );
  }
}
