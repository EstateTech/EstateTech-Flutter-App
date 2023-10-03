import 'package:cached_network_image/cached_network_image.dart';
import 'package:crypto_estate_tech/common/ColorConstants.dart';
import 'package:crypto_estate_tech/common/fixedvalues.dart';
import 'package:crypto_estate_tech/common/widgetConstants.dart';
import 'package:crypto_estate_tech/helperclass/dataFromFirestore.dart';
import 'package:crypto_estate_tech/model/message.dart';
import 'package:crypto_estate_tech/model/signupSaveDataFirebase.dart';
import 'package:crypto_estate_tech/screens/inbox/messagecard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';

class ChatScreen extends StatefulWidget {
  final SignupSavepDataFirebase user;
  const ChatScreen({super.key, required this.user});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  List<Message> _messagelist = [];
  TextEditingController textEditingController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: PreferredSize(
          preferredSize: Size(MediaQuery.of(context).size.width * 1, 70),
          child: customappbar(context),
        ),
        body: Column(
          children: [
            Expanded(
              child: StreamBuilder(
                  stream: getAllMessages(widget.user),
                builder: (context, snapshot) {
                  switch (snapshot.connectionState) {
                    case ConnectionState.waiting:
                    case ConnectionState.none:
                      return const Center(
                        child: SizedBox(),
                      );
            
                    case ConnectionState.active:
                    case ConnectionState.done:
                    
                    final data = snapshot.data?.docs;
                    _messagelist = data?.map((e) => Message.fromJson(e.data())).toList() ?? [];

                   
                     
 


                      if (_messagelist.isNotEmpty) {
                        return ListView.builder(
                            itemCount:
                               _messagelist.length,
                            itemBuilder: (context, index) {
                              return MessageCard(message: _messagelist[index]);
                            });
                      } else {
                        return  Center(
                          child: Text("Say Hi !!🤩" , style: style.copyWith(
                            fontSize: 25.sp,
                            color: Shade2purple
                          ),),
                        );
                      }
                  }
                },
              
              ),
            ),
            _chatInput()
          ],
        ));
  }

  Container customappbar(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 18.h),
      margin: EdgeInsets.only(top: 50.h),
      height: 50.h,
      decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black12.withOpacity(0.2),
              spreadRadius: 2,
              blurRadius: 4,
              offset: Offset(0, 3),
            ),
          ],
          border: Border(bottom: BorderSide(color: Colors.grey, width: 0.5))),
      child: InkWell(
        onTap: () {},
        child: Row(
          //  mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: () {
                Navigator.of(context).pop();
              },
              child: Icon(
                Icons.arrow_back,
                color: Colors.black,
              ),
            ),
            Container(
              clipBehavior: Clip.hardEdge,
              width: 60.w,
              height: 40.w,
              decoration:
                  BoxDecoration(shape: BoxShape.circle, color: Colors.black),
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
            SizedBox(
              width: 10,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(widget.user.firstName.toString(),
                    style: style.copyWith(
                        fontSize: 15.sp,
                        color: Colors.black87,
                        fontWeight: FontWeight.w500)),
                SizedBox(
                  height: 2.h,
                ),
                Text(
                  'Last seen not available',
                  style: style.copyWith(
                    fontSize: 13.sp,
                    color: Colors.black54,
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget _chatInput() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 10.h),
      child: Row(
        children: [
          Expanded(
            child: Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15)),
              child: Row(
                children: [
                  IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.emoji_emotions,
                        color: Colors.grey,
                      )),
                  Expanded(
                      child: TextField(
                        controller: textEditingController,
                    keyboardType: TextInputType.multiline,
                    maxLines: null,
                    decoration: InputDecoration(
                        hintText: "Type Something....",
                        hintStyle: style.copyWith(color: Colors.grey),
                        border: InputBorder.none),
                  )),
                  IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.image,
                        color: Colors.grey,
                      )),
                  IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.camera_alt_rounded,
                        color: Colors.grey,
                      ))
                ],
              ),
            ),
          ),
          MaterialButton(
            minWidth: 0,
            padding: EdgeInsets.only(top: 10, bottom: 10, right: 5, left: 10),
            shape: CircleBorder(),
            color: Shade2purple,
            onPressed: () {
              if(textEditingController.text.isNotEmpty){
                sendMessage(widget.user, textEditingController.text.toString());
                textEditingController.text = '';
              }
            },
            child: Icon(
              Icons.send, 
              color: Colors.white,
              size: 28,
            ),
          )
        ],
      ),
    );
  }
}
