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
  const PropertyDescriptionScreen({super.key, required this.postModel, required this.isEdited});

  final PostModel postModel;
  final bool isEdited;

  @override
  State<PropertyDescriptionScreen> createState() =>
      _PropertyDescriptionScreenState();
}

class _PropertyDescriptionScreenState extends State<PropertyDescriptionScreen> {
  TextEditingController descriptionController = TextEditingController();
  Set<String> selectedItems = Set<String>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if(widget.isEdited) {
      descriptionController.text = widget.postModel.propertyDescription!;
    }
  }




  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        body: Container(
          padding: EdgeInsets.only(left: 20.h, right: 20.h),
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          decoration: const BoxDecoration(gradient: appBackgroundGradient),
          child: CustomScrollView(
            slivers: [
              SliverFillRemaining(
                hasScrollBody: false,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    const CustomCreatePostHeader(),
                    // SizedBox(
                    //   height: 20.h,
                    // ),
                    Align(
                      alignment: Alignment.center,
                      child: Column(
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
                            style: style.copyWith(
                                fontSize: 15.sp, color: textwalktrough),
                          ),
                          SizedBox(
                            height: 20.h,
                          ),
                          Container(
                            alignment: Alignment.topLeft,
                            height: 110.h,
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(20.r)),
                            child: Row(
                              children: [
                                Expanded(
                                  child: TextField(
                                      maxLines: null,
                                      keyboardType: TextInputType.text,
                                      textInputAction: TextInputAction.done,
                                      controller: descriptionController,
                                      decoration: const InputDecoration(
                                        hintText: 'Description here.....',
                                        border: InputBorder.none,
                                      ),
                                      onSubmitted: (value) {}),
                                ),
                                IconButton(
                                  icon: const Icon(Icons.edit),
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
                            "Choose up to 2 highlights of the above to describe your property.",
                            style: style.copyWith(
                                fontSize: 15.sp, color: textwalktrough),
                          ),
                          SizedBox(
                            height: 20.h,
                          ),
                          PropertyDescription()
                        ],
                      ),
                    ),

                    Padding(
                      padding: EdgeInsets.only(
                          right: 12.h, left: 12.h, bottom: 30.h, top: 10.h),
                      child: customPostCreateBottomWidget(
                        OnPressedNextButton: () {
                          widget.postModel.propertyDescription =
                              descriptionController.text;

                          selectedItems.forEach((item) {
                            print(item);
                          });

                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => WalkthroughStep3(
                                        postModel: widget.postModel,
                                        isEdited : widget.isEdited
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
            ],
          ),
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
        final isSelected = selectedItems.contains(title);

        return GestureDetector(
          onTap: () {
            // Handle widget tap event
            setState(() {
              if (isSelected) {
                selectedItems.remove(title);
              } else {
                selectedItems.add(title);
              }
            });
          },
          child: Container(
            height: 40.h,
            width: 150.w,
            padding: EdgeInsets.symmetric(horizontal: 12.w),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20.r),
              border: Border.all(color: Shade2purple),
              color: isSelected ? Colors.white : Colors.transparent,
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
