import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

import '../common/ColorConstants.dart';
import '../common/widgetConstants.dart';

class OwnTextfield extends StatelessWidget {
  const OwnTextfield({
    super.key,
    required this.label,
    required this.hint,
    required this.validator,
    this.mask,
    this.readonly = false,
    this.textInputType = TextInputType.text,
    this.containMask = false,
    required this.controller,
  });

  final String label;
  final String hint;
  final FormFieldValidator<String> validator;
  final MaskTextInputFormatter? mask;
  final bool? containMask;
  final bool? readonly;
  final TextInputType? textInputType;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.r),
        // boxShadow: [
        //   BoxShadow(
        //     color: mainAppColor.withOpacity(0.2), // shadow color
        //     spreadRadius: 1, // spread radius
        //     blurRadius: 4, // blur radius
        //     offset: Offset(0, 3), // changes position of shadow
        //   )
        // ],
      ),
      child: TextFormField(
        scrollPadding:
            EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        readOnly: readonly!,
        controller: controller,
        keyboardType: textInputType,
        validator: validator,
        cursorColor: const Color(0xFF444444),
        inputFormatters: containMask! ? [mask!] : [],
        decoration: InputDecoration(
          contentPadding:
              EdgeInsets.symmetric(vertical: 20.h, horizontal: 20.w),

          filled: true,
          fillColor: Colors.white,
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16.r),
              borderSide: const BorderSide(
                width: 1,
                color: Color(0xFF444444),
              )),

          //enabledBorder: InputBorder.none,

          errorStyle: style.copyWith(
              color: Colors.red, fontSize: 13.sp, fontWeight: FontWeight.w500),
          border: OutlineInputBorder(
              borderSide: const BorderSide(
                width: 2,
                color: Colors.black,
              ),
              borderRadius: BorderRadius.circular(16.r)),
          labelText: label,
          floatingLabelAlignment: FloatingLabelAlignment.start,
          hintText: hint,
          hintStyle: style.copyWith(
              letterSpacing: 1.1.w,
              color: const Color(0xFF444444),
              fontSize: 15.sp,
              fontWeight: FontWeight.w700),

          labelStyle: style.copyWith(
              color: const Color(0xFF444444),
              fontSize: 16.sp,
              fontWeight: FontWeight.w500),

          floatingLabelBehavior: FloatingLabelBehavior.always,
        ),
      ),
    );
  }
}
