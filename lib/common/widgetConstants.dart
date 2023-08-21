import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

TextStyle style = GoogleFonts.aBeeZee(color: Colors.white, fontSize: 12.sp);
TextStyle style2 = GoogleFonts.montserrat(color: Colors.white, fontSize: 12.sp);
TextStyle numberStyle = GoogleFonts.rubik(color: Colors.white, fontSize: 12.sp);

void showSnackBar(BuildContext context, String text) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(text)));
}

Widget loadingWidget(double progress) {
  return Container(
    color: Colors.black.withOpacity(0.5),
    child: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularProgressIndicator(
            value: progress / 100,
          ),
          const SizedBox(height: 16),
          Text(
            'Uploading: ${progress.toStringAsFixed(1)}%',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16,
            ),
          ),
        ],
      ),
    ),
  );
}
