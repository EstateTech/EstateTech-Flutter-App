import 'package:crypto_estate_tech/common/ColorConstants.dart';
import 'package:crypto_estate_tech/common/widgetConstants.dart';
import 'package:crypto_estate_tech/screens/detailScreens/Dialogs/dialogMortgage2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../common/rangeUtils.dart';

class MortgageDialog extends StatefulWidget {
  const MortgageDialog({super.key});

  @override
  State<MortgageDialog> createState() => _MortgageDialogState();
}

class _MortgageDialogState extends State<MortgageDialog> {
  double currentSliderValue = 0;

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
            MediaQuery.of(context).size.height * 0.4, // Set height as needed
        width: MediaQuery.of(context).size.height * 0.7,
        child: Padding(
          padding: EdgeInsets.only(left: 10.h, right: 10.h),
          child: Column(children: [
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
              height: 20.h,
            ),
            Text(
              "Mortgage calculator",
              style: style.copyWith(
                  fontSize:
                      MediaQuery.of(context).orientation == Orientation.portrait
                          ? 20.sp
                          : 9.sp,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.5),
            ),
            SizedBox(
              height: 10.h,
            ),
            Text(
              "Your gross annual income",
              style: style.copyWith(
                fontSize:
                    MediaQuery.of(context).orientation == Orientation.portrait
                        ? 15.sp
                        : 9.sp,
              ),
            ),
            SizedBox(
              height: 20.h,
            ),
            buildSliderTopLabel(),
            SizedBox(
              height: 20.h,
            ),
            GestureDetector(
              onTap: () {
                Navigator.pop(context);
                showTransitionDialog(context, const DialogMortgage2());
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
                    fontSize: MediaQuery.of(context).orientation ==
                            Orientation.portrait
                        ? 18
                        : 9,
                    fontWeight: FontWeight.w400,
                    color: Shade2purple,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            )
          ]),
        ),
      ),
    );
  }

  Widget buildSliderTopLabel() {
    final labels = ["50k", "100k", "150k", "200k", "250k", "+300k"];
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

void showTransitionDialog(BuildContext context, Widget dialog) {
  showGeneralDialog(
    context: context,
    barrierDismissible: true,
    barrierLabel: 'Transition Dialog',
    transitionDuration: const Duration(milliseconds: 400),
    pageBuilder: (context, animation1, animation2) {
      return Center(
          child: SlideTransition(
              position: Tween<Offset>(
                begin: const Offset(1.0, 0.0),
                end: Offset.zero,
              ).animate(animation1),
              child: dialog));
    },
  );
}
