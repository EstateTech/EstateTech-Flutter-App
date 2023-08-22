import 'package:crypto_estate_tech/common/ColorConstants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomSwitch extends StatelessWidget {
  final bool value;
  final ValueChanged<bool> onChanged;

  const CustomSwitch({
    super.key,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onChanged(!value);
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeInOut,
        width: 70.w,
        height: 30.h,
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.white, // Customize the border color
            width: 1.0,
          ),
          borderRadius: BorderRadius.circular(20.r),
          color: value ? Shade2purple : Colors.transparent,
        ),
        alignment: value ? Alignment.centerRight : Alignment.centerLeft,
        child: Container(
          width: 25.0,
          height: 25.0,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.transparent,
            border: Border.all(
              color: Colors.white, // Customize the border color
              width: 1.0,
            ),
          ),
          child: Icon(
            value ? Icons.check : Icons.close,
            color: Colors.white,
            size: 20.0,
          ),
        ),
      ),
    );
  }
}
