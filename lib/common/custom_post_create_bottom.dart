import 'package:crypto_estate_tech/common/ColorConstants.dart';
import 'package:crypto_estate_tech/common/custom_button_widget.dart';
import 'package:crypto_estate_tech/common/widgetConstants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class customPostCreateBottomWidget extends StatelessWidget {
  final VoidCallback OnPressedbackButton;
  final VoidCallback OnPressedNextButton;
  const customPostCreateBottomWidget({
    super.key,
    required this.OnPressedbackButton,
    required this.OnPressedNextButton,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: CustomButton(
            text: "Back",
            fillColor: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [greyButtonColor, greyButtonColor]),
            borderColor: whiteBorderColor,
            textStyle: style.copyWith(
              color: greyTextColor,
              fontSize: 19.sp,
              fontWeight: FontWeight.w500,
            ),
            onPressed: OnPressedbackButton,
          ),
        ),
        SizedBox(
          width: 20.w,
        ),
        Expanded(
          child: CustomButton(
            text: "Next",
            fillColor: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [mainAppColor, Colors.black]),
            borderColor: Colors.black,
            textStyle: style.copyWith(
              color: Colors.white,
              fontSize: 19.sp,
              fontWeight: FontWeight.w500,
            ),
            onPressed: OnPressedNextButton,
          ),
        ),
      ],
    );
  }
}
