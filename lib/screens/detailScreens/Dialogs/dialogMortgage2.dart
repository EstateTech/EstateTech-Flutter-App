import 'package:crypto_estate_tech/common/ColorConstants.dart';
import 'package:crypto_estate_tech/common/rangeUtils.dart';
import 'package:crypto_estate_tech/common/switch.dart';
import 'package:crypto_estate_tech/common/widgetConstants.dart';
import 'package:crypto_estate_tech/screens/detailScreens/Dialogs/dialogMortgage.dart';
import 'package:crypto_estate_tech/screens/detailScreens/Dialogs/dialogMortgage3.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DialogMortgage2 extends StatefulWidget {
  const DialogMortgage2({super.key});

  @override
  State<DialogMortgage2> createState() => _DialogMortgage2State();
}

class _DialogMortgage2State extends State<DialogMortgage2> {
  double currentSliderValue = 0;
  bool switchValue = false;
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      backgroundColor: Colors.transparent,
      child: Container(
        decoration: BoxDecoration(
            gradient: const LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [mainAppColor, Colors.black]),
            borderRadius: BorderRadius.circular(30.r)),
        height:
            MediaQuery.of(context).size.height * 0.45, // Set height as needed
        width: MediaQuery.of(context).size.height * 0.7,
        child: Padding(
          padding: EdgeInsets.only(left: 10.h, right: 10.h),
          child: Column(
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.pop(context); // Close the dialog
                },
                child: Align(
                  alignment: Alignment.topRight,
                  child: Container(
                    margin: EdgeInsets.only(top: 10.h),
                    height: 35.h,
                    width: 35.h,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.white)),
                    child: const Icon(
                      Icons.close,
                      size: 30,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 15.h,
              ),
              Text(
                "Mortgage calculator",
                style: style.copyWith(
                    fontSize: 20.sp,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.5),
              ),
              SizedBox(
                height: 10.h,
              ),
              Text(
                "Your age",
                style: style.copyWith(fontSize: 15.sp),
              ),
              SizedBox(
                height: 20.h,
              ),
              buildSliderTopLabel(),
              SizedBox(
                height: 10.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "You have a partner?",
                    style: style.copyWith(color: Colors.white, fontSize: 15.sp),
                  ),
                  CustomSwitch(
                    value: switchValue,
                    onChanged: (newValue) {
                      setState(() {
                        switchValue = newValue;
                      });
                    },
                  ),
                ],
              ),
              SizedBox(
                height: 15.h,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                  showTransitionDialog(context, const DialogMortgage3());
                },
                child: Container(
                  alignment: Alignment.center,
                  height: 50.h,
                  width: 120.w,
                  decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [Color(0xffFFFFFF), Color(0xffA9A4B9)],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ),
                      borderRadius: BorderRadius.circular(20.r)),
                  child: Text(
                    "Next",
                    style: style.copyWith(
                      fontSize: 18,
                      fontWeight: FontWeight.w400,
                      color: Shade2purple,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget buildSliderTopLabel() {
    final labels = ["18", "25", "30", "35", "40", "+50"];
    const double min = 0;
    final double max = labels.length - 1.0;
    final divisions = (max - min).toInt();
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 18),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: Utils.modelBuilder(labels, (index, model) {
              return buildLabel(label: model, color: Colors.white);
            }),
          ),
        ),
        Slider(
            thumbColor: const Color(0xff7C778A),
            inactiveColor: Colors.white,
            activeColor: const Color(0xff7C778A),
            value: currentSliderValue,
            min: min,
            max: max,
            divisions: divisions,
            onChanged: (double value) {
              setState(() {
                currentSliderValue = value;
              });
            }),
      ],
    );
  }

  Widget buildLabel({required String label, required Color color}) {
    return Column(
      children: [
        Text(
          label,
          style: numberStyle.copyWith(
              fontSize: 12.sp, color: color, fontWeight: FontWeight.bold),
        ),
        Container(
          margin: EdgeInsets.only(top: 10.h),
          height: 15.0,
          width: 1.0,
          color: Colors.white,
        )
      ],
    );
  }
}
