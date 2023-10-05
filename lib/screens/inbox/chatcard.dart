import 'package:cached_network_image/cached_network_image.dart';
import 'package:crypto_estate_tech/common/fixedvalues.dart';
import 'package:crypto_estate_tech/common/widgetConstants.dart';
import 'package:crypto_estate_tech/model/signupSaveDataFirebase.dart';
import 'package:crypto_estate_tech/screens/inbox/chatScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

class ChatCard extends StatefulWidget {
  final SignupSavepDataFirebase user;
  final bool isSelected;
  const ChatCard({super.key, required this.user, required this.isSelected});

  @override
  State<ChatCard> createState() => _ChatCardState();
}

class _ChatCardState extends State<ChatCard> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (_) => ChatScreen(
                      user: widget.user,
                    )));
      },
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 10.w),
       
                decoration: BoxDecoration(
          color: Colors.white,
          
          border: Border(bottom: BorderSide(color: Colors.grey, width: 0.5))),


        
      
        child: ListTile(
          
            contentPadding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 0),
            leading: Container(
              clipBehavior: Clip.hardEdge,
              width: 90.w,
              height: 90.h,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
              ),
              child: ClipRect(
                child: CachedNetworkImage(
                    key: UniqueKey(),
                    imageUrl: widget.user.photoUrl ?? demyprofileurl,
                    fit: BoxFit.cover,
                    placeholder: (context, url) => Container(
                          child: Lottie.asset(
                            'assets/images/loading_animation.json', // Replace with your animation file path
                            width: 70.h,
                            height: 70.h,
                            // Other properties you can customize
                          ),
                        ),
                    errorWidget: (context, url, error) => Image.network(
                          demyprofileurl, // Replace with your animation file path
                          width: 70.h,
                          height: 70.h,
                          // Other properties you can customize
                        )),
              ),
            ),
            title: Text(
              '${widget.user.firstName ?? "NO Name"}',
              textAlign: TextAlign.left,
              style: GoogleFonts.dmSans(
                  color: Color(
                    0xFF3A3153,
                  ),
                  fontWeight: FontWeight.bold,
                  fontSize: 18.sp),
            ),
            subtitle: Text(
              widget.user.about.toString(),
              maxLines: 1,
              style: GoogleFonts.dmSans(
                  color: Color(
                    0xFF3A3153,
                  ),
                  fontWeight: FontWeight.w400,
                  fontSize: 14.sp),
            ),
            trailing: Text(
              "7 Nov",
              style: numberStyle.copyWith(fontSize: 15.sp, color: Colors.grey),
            )),
      ),
    );
  }
}
