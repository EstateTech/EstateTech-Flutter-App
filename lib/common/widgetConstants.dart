import 'package:crypto_estate_tech/common/ColorConstants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

TextStyle style = GoogleFonts.aBeeZee(color: Colors.white, fontSize: 12.sp);
TextStyle style2 = GoogleFonts.montserrat(color: Colors.white, fontSize: 12.sp);
TextStyle numberStyle = GoogleFonts.rubik(color: Colors.white, fontSize: 12.sp);

void showSnackBar(BuildContext context, String text) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(text)));
}

Widget loadingWidget() {
  return Container(
    color: mainAppColor.withOpacity(0.5),
    child: Center(
      child: LottieBuilder.asset("assets/images/animation.json")
      
    )
  );
}
