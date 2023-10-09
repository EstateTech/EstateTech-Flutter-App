import 'package:crypto_estate_tech/common/ColorConstants.dart';
import 'package:crypto_estate_tech/common/custom_create_post_header.dart';
import 'package:crypto_estate_tech/common/custom_post_create_bottom.dart';
import 'package:crypto_estate_tech/common/list_constants.dart';
import 'package:crypto_estate_tech/model/postModel.dart';
import 'package:crypto_estate_tech/screens/walkthroughScreens/walkthroughPostScreen2.dart';
import 'package:crypto_estate_tech/screens/walkthroughScreens/walkthroughStep3.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../common/widgetConstants.dart';

class RentalTypeScreen extends StatefulWidget {
  final PostModel postModel;
  const RentalTypeScreen({super.key, required this.postModel});

  @override
  State<RentalTypeScreen> createState() => _RentalTypeScreenState();
}

class _RentalTypeScreenState extends State<RentalTypeScreen> {
  String selectedMainOption = 'Rent';
  String selectedSubOption = 'Long-term';
  // Options for the main dropdown
  List<String> mainOptions = ['Rent', 'Buy', 'Sell'];

  // Sub-options for the sub dropdown based on the main option selected
  Map<String, List<String>> subOptions = {
    'Rent': ['Long-term', 'Short-term'],
    'Buy': ['Ready-to-move', 'Off-plan', 'Under-construction'],
    'Sell': ['Offer to Sell', 'Offer to Rent', 'Short Term Options'],
  };
  int selectedItem = -1;

  List<String> rentalList = ["Montly","Yearly","Weekly"];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.only(left: 20.h, right: 20.h, top: 25.h),
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: const BoxDecoration(gradient: appBackgroundGradient),
        child: Column(
        //  mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            SizedBox(height: 10.h,),
            Align(
              alignment: Alignment.topCenter,
              child: CustomCreatePostHeader()),
            
             SizedBox(height: 30.h,),
             
              Text(
                  "Share some more important  basics about your place",
                  style: style.copyWith(
                      fontSize: 25.sp,
                      color: textwalktrough,
                      fontWeight: FontWeight.w600),
                ),
                                Text(
              "Your choice helps potential buyers or renters understand your property listing.",
              style: style.copyWith(
                fontSize: 15.sp,
                color: textwalktrough,
              ),
                ),

                SizedBox(height: 20.h,),

                Container(
              width: double.infinity,
              padding: EdgeInsets.only(left: 10.h, right: 10.h),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: DropdownButton<String>(
                underline: SizedBox.shrink(),
                value: selectedMainOption,
                isExpanded: true,
                onChanged: (String? newValue) {
              setState(() {
                selectedMainOption = newValue!;
                // Reset the sub-option when the main option changes
                selectedSubOption = subOptions[selectedMainOption]![0];
              });
                },
                items:
                mainOptions.map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
                }).toList(),
              ),
            ),
            SizedBox(height: 30.h),
            Container(
              width: double.infinity,
              padding: EdgeInsets.only(left: 10.h, right: 10.h),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: DropdownButton<String>(
                alignment: AlignmentDirectional.bottomEnd,
                isExpanded: true,
                underline: SizedBox.shrink(),
                value: selectedSubOption,
                onChanged: (String? newValue) {
              setState(() {
                selectedSubOption = newValue!;
              });
                },
                items: subOptions[selectedMainOption]!
                .map<DropdownMenuItem<String>>(
              (String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              },
                ).toList(),
              ),
            ),
 SizedBox(height: 20.h,),

           
            selectedMainOption == "Rent" ?  PropertyDescription() : SizedBox.shrink(),
            Padding(
              padding: EdgeInsets.only(top: 200.h,right: 12.h, left: 12.h, bottom: 10.h),
              child: Align(
                alignment: Alignment.bottomCenter,
                child: customPostCreateBottomWidget(
                  OnPressedNextButton: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => WalkThroughScreenPost2(
                                  isStep2: true,
                                  postmodel: widget.postModel,
                                )));
                  },
                  OnPressedbackButton: () {
                    Navigator.pop(context);
                  },
                ),
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
      children: rentalList.asMap().entries.map((entry) {
         
        int index = entry.key; // Extract the index
    bool isSelected = selectedItem == index; 

        return GestureDetector(
          onTap: () {
            // Handle widget tap event

            setState(() {
              selectedItem = index; // Set the selected item
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
           
                Text(
                  entry.value,
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
