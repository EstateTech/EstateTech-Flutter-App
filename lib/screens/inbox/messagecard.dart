import 'package:crypto_estate_tech/common/ColorConstants.dart';
import 'package:crypto_estate_tech/common/widgetConstants.dart';
import 'package:crypto_estate_tech/helperclass/dataFromFirestore.dart';
import 'package:crypto_estate_tech/model/message.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MessageCard extends StatefulWidget {
  final Message message;
  const MessageCard({super.key, required this.message});

  @override
  State<MessageCard> createState() => _MessageCardState();
}

class _MessageCardState extends State<MessageCard> {
  @override
  Widget build(BuildContext context) {
    return user!.uid == widget.message.fromId
        ? _greenMessage()
        : _blueMessage();
  }

  Widget _blueMessage() {
    return Row(
      children: [
        Flexible(
          child: IntrinsicHeight(
            child: Container(
              padding: EdgeInsets.only(
                  left: 10.h, top: 10.h, bottom: 5.h, right: 10.h),
              margin: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
              decoration: BoxDecoration(
                  color: mainAppColor.withOpacity(0.1),
                  border: Border.all(color: mainAppColor),
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30.r),
                      topRight: Radius.circular(30),
                      bottomRight: Radius.circular(30))),
              constraints: BoxConstraints(
                maxHeight: double.infinity,
              ),
              child: Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Expanded(
                        child: Text(
                          widget.message.msg,
                          style: style.copyWith(
                              fontSize: 15.sp, color: Colors.black),
                        ),
                      ),
                      SizedBox(
                        width: 5.h,
                      ),
                      Icon(
                        Icons.done_all_rounded,
                        color: Colors.blue,
                        size: 20,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 5.h,
                  ),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: Text(
                      widget.message.sent,
                      style: style.copyWith(
                          fontSize: 13.sp, color: Colors.black54),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.3,
        ),
      ],
    );
  }

  Widget _greenMessage() {
    return Row(
      children: [
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.3,
        ),
        Flexible(
          child: IntrinsicHeight(
            child: Container(
              padding: EdgeInsets.only(
                  left: 10.h, top: 10.h, bottom: 5.h, right: 10.h),
              margin: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
              decoration: BoxDecoration(
                  color: Colors.green.withOpacity(0.1),
                  border: Border.all(color: Colors.green),
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30.r),
                      topRight: Radius.circular(30),
                      bottomRight: Radius.circular(30))),
              constraints: BoxConstraints(
                maxHeight: double.infinity,
              ),
              child: Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Expanded(
                        child: Text(
                          widget.message.msg,
                          style: style.copyWith(
                              fontSize: 15.sp, color: Colors.black),
                        ),
                      ),
                      SizedBox(
                        width: 5.h,
                      ),
                      Icon(
                        Icons.done_all_rounded,
                        color: Colors.blue,
                        size: 20,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 5.h,
                  ),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: Text(
                      widget.message.sent,
                      style: style.copyWith(
                          fontSize: 13.sp, color: Colors.black54),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
