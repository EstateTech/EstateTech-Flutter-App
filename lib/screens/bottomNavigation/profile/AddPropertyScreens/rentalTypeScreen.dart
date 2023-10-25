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
  String selectedMainOption = RENT;
  String selectedSubOption = LONG_TERM;
  // Options for the main dropdown
  List<String> mainOptions = [RENT, BUY, SELL];

  // Sub-options for the sub dropdown based on the main option selected
  Map<String, List<String>> subOptions = {
    RENT: [LONG_TERM, SHORT_TERM],
    BUY: [READY_TO_MOVE, OFF_PLAN, UNDER_CONSTRUCTION],
   SELL: [OFFER_TO_SELL, OFFER_TO_RENT, SHORT_TERM_OPTIONS],
  };
  int selectedItem = -1;
  bool isRentalPeriodSaved = false;

  List<String> rentalList = ["Montly", "Yearly", "Weekly"];
  bool _isExpanded = false;
  DateTimeRange dateTimeRange = DateTimeRange(
    end: DateTime.now().add(const Duration(days: 30)),
    start: DateTime.now().subtract(const Duration(days: 30)),
  );

  @override
  Widget build(BuildContext context) {
    final start = dateTimeRange.start;
    final end = dateTimeRange.end;

    return Scaffold(
      body: Container(
        padding: EdgeInsets.only(left: 20.h, right: 20.h, top: 25.h),
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: const BoxDecoration(gradient: appBackgroundGradient),
        child: Column(
          //  mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            SizedBox(
              height: 10.h,
            ),
            Align(
                alignment: Alignment.topCenter,
                child: CustomCreatePostHeader()),
            SizedBox(
              height: 30.h,
            ),
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
            SizedBox(
              height: 20.h,
            ),
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
            SizedBox(
              height: 20.h,
            ),
            selectedMainOption == "Rent"
                ?  !isRentalPeriodSaved  ? PropertyDescription() : SizedBox.shrink()
                : SizedBox.shrink(),
            SizedBox(
              height: 20.h,
            ),
           selectedMainOption == "Rent" ? Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.3),
                        spreadRadius: 5,
                        blurRadius: 7,
                        offset:
                            Offset(0, 3), // changes the position of the shadow
                      ),
                    ],
                    borderRadius: BorderRadius.circular(10.r)),
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(25.r),
                    child: ExpansionTile(
                      backgroundColor: Colors.white,
                      title: Text(
                        "Select Rental Period",
                        style: style.copyWith(
                            color: Shade2purple,
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w700),
                      ),
                      trailing: SizedBox.shrink(),
                      onExpansionChanged: (value) {
                        setState(() {
                          _isExpanded = value;
                        });
                      },
                      children: <Widget>[
                        //  FilterWidget(isPeriodTimeRequired: false,),
                        ShowDateTimeRange(start, end)
                      ],
                    ))) :SizedBox.shrink(),
            Padding(
              padding: EdgeInsets.only(
                  top: 100.h, right: 12.h, left: 12.h, bottom: 10.h),
              child: Align(
                alignment: Alignment.bottomCenter,
                child: customPostCreateBottomWidget(
                  OnPressedNextButton: () {
                    widget.postModel.rentalType = selectedMainOption;
                    widget.postModel.rentalSubtype = selectedSubOption;
                    if(selectedMainOption == "Long-term") {
                      widget.postModel.rentalPeriod = rentalList[selectedItem];
                    }else {
                      widget.postModel.rentalPeriod = "NoPeriod";
                    }
                 //   widget.postModel.rentalPeriod = rentalList[selectedItem];
                    // print(
                    //     "${selectedMainOption} , ${selectedSubOption} , ${rentalList[selectedItem]}");
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

  Widget ShowDateTimeRange(DateTime start, DateTime end) {
    return Column(children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Text(
            "From",
            style: style2.copyWith(
                color: mainAppColor,
                fontSize: 18.sp,
                fontWeight: FontWeight.bold),
          ),
          Text(
            "To",
            style: style2.copyWith(
                color: mainAppColor,
                fontSize: 18.sp,
                fontWeight: FontWeight.bold),
          )
        ],
      ),
      SizedBox(
        height: 10.h,
      ),
      Padding(
        padding: EdgeInsets.only(left: 5.h, right: 5.h),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
                child: OutlinedButton(
              onPressed: pickDateRange,
              child: Text(
                "${start.year}/${start.month}/${start.day}",
                style: style.copyWith(color: Shade2purple, fontSize: 18.sp),
              ),
            )),
            const SizedBox(
              width: 12,
            ),
            Expanded(
                child: OutlinedButton(
              onPressed: pickDateRange,
              child: Text(
                '${end.year}/${end.month}/${end.day}',
                style: style.copyWith(color: Shade2purple, fontSize: 18.sp),
              ),
            ))
          ],
        ),
      )
    ]);
  }

  Future pickDateRange() async {
   DateTimeRange? newDateRange = await showDateRangePicker(
  context: context,
 // initialDateRange: dateTimeRange,
  firstDate: DateTime.now(),
  lastDate: DateTime(2100),


  builder: (context, Widget? child) => Theme(
    data: Theme.of(context).copyWith(
        dialogBackgroundColor:
          mainAppColor,
        appBarTheme: Theme.of(context).appBarTheme.copyWith(
            iconTheme: IconThemeData(
                color: Theme.of(context).primaryColorLight)),
        colorScheme: Theme.of(context).colorScheme.copyWith(
            onPrimary: Colors.white,
            primary: mainAppColor)),
    child: child!,
  ),









);

if (newDateRange == null) return;

setState(() {
  dateTimeRange = newDateRange;
  isRentalPeriodSaved = true;
});

  }

  Widget PropertyDescription() {
    return Wrap(
      spacing: 9.0,
      runSpacing: 7.0,
      children: rentalList.asMap().entries.map((entry) {
        int index = entry.key; // Extract the index
        bool isSelected = selectedItem == index;
        String value = entry.value;

         bool isEnabled = false; // Initialize as disabled

    if (selectedSubOption == "Long-term") {
      // Enable "yearly" and "monthly" for long-term
      isEnabled = (value == "Yearly" || value == "Montly");
    } else if (selectedSubOption == "Short-term") {
      // Enable "weekly" for short-term
      isEnabled = (value == "Weekly");
    }

        return IgnorePointer(
            ignoring: !isEnabled, 
          child: GestureDetector(
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
                color: 
                selectedSubOption == "Long-term" &&
                                        index == 2
                                    ? Colors.black38
                                    : selectedSubOption == "Short-term" &&
                                            index == 0
                                        ? Colors.black38
                                        : selectedSubOption ==
                                                    "Short-term" &&
                                                index == 1
                                            ? Colors.black38:  
                
                isSelected ? Colors.white : Colors.transparent,
              ),
              child: Row(
                children: [
                  Text(
                    value,
                    style: TextStyle(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      }).toList(),
    );
  }
}
