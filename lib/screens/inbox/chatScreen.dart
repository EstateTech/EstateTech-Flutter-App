import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crypto_estate_tech/common/ColorConstants.dart';
import 'package:crypto_estate_tech/helperclass/dataFromFirestore.dart';
import 'package:crypto_estate_tech/model/message.dart';
import 'package:crypto_estate_tech/model/signupSaveDataFirebase.dart';
import 'package:crypto_estate_tech/screens/inbox/messagecard.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ChatScreen extends StatefulWidget {
  final SignupSavepDataFirebase user;

  const ChatScreen({super.key, required this.user});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  //for storing all messages
  List<Message> _list = [];

  //for handling message text changes
  TextEditingController textController = TextEditingController();

  //showEmoji -- for storing value of showing or hiding emoji
  //isUploading -- for checking if image is uploading or not?
  bool _showEmoji = false, _isUploading = false;
  Stream<QuerySnapshot>? _messageStream;


  void initState() {
    super.initState();
   
    _messageStream = getAllMessages(widget.user);
  }


  @override
  Widget build(BuildContext context) {
    Size mq = MediaQuery.of(context).size;

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: WillPopScope(
        //if emojis are shown & back button is pressed then hide emojis
        //or else simple close current screen on back button click
        onWillPop: () {
          if (_showEmoji) {
            setState(() => _showEmoji = !_showEmoji);
            return Future.value(false);
          } else {
            return Future.value(true);
          }
        },
        child: Builder(
          builder: (context) {
            return Scaffold(
              //app bar

           

              //body
              body: Column(
                children: [
                  Align(
                    alignment: Alignment.topCenter,
                    child: _appBar(),

                  ),
                  Expanded(
                    child: StreamBuilder(
                      stream: _messageStream,
                      builder: (context, snapshot) {
                        switch (snapshot.connectionState) {
                          //if data is loading
                          case ConnectionState.waiting:
                          case ConnectionState.none:
                            return const SizedBox();
 //// heello 
                          //if some or all data is loaded then show it
                          case ConnectionState.active:
                          case ConnectionState.done:
                            //final data = snapshot.data?.docs;
                           final data = snapshot.data as QuerySnapshot<Map<String, dynamic>>?;
if (data != null) {
  _list = data.docs.map((e) => Message.fromJson(e.data())).toList();
} else {
  // Handle the case when data is null or empty
  _list = [];
}
                                print("hello world");

                            if (_list.isNotEmpty) {
                              return ListView.builder(
                                  reverse: false,
                                  itemCount: _list.length,
                                  padding: EdgeInsets.only(top: mq.height * .01),
                                  physics: const BouncingScrollPhysics(),
                                  itemBuilder: (context, index) {
                                    return MessageCard(message: _list[index]);
                                  });
                            } else {
                              return const Center(
                                child: Text('Say Hii! 👋',
                                    style: TextStyle(fontSize: 20)),
                              );
                            }
                        }
                      },
                    ),
                  ),

                  //progress indicator for showing uploading
                  if (_isUploading)
                    const Align(
                        alignment: Alignment.centerRight,
                        child: Padding(
                            padding:
                                EdgeInsets.symmetric(vertical: 8, horizontal: 20),
                            child: CircularProgressIndicator(strokeWidth: 2))),

                  //chat input filed
                  Padding(
                    padding: EdgeInsets.only(bottom: 20.h),
                    child: _chatInput()),

                 
                ],
              ),
            );
          }
        ),
      ),
    );
  }

  // app bar widget
  Widget _appBar() {
    return InkWell(
        onTap: () {},
        child: Container(
          margin: EdgeInsets.only(top: 50.h),
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

          child: Row(children: [
            //back button
            IconButton(
                onPressed: () => Navigator.pop(context),
                icon: const Icon(Icons.arrow_back, color: Colors.black54)),
        
            //user profile picture
            ClipRRect(
              borderRadius:
                  BorderRadius.circular(MediaQuery.of(context).size.height * .03),
              child: CachedNetworkImage(
                width: MediaQuery.of(context).size.height * .05,
                height: MediaQuery.of(context).size.height * .05,
                imageUrl: widget.user.photoUrl ?? "",
                errorWidget: (context, url, error) =>
                    const CircleAvatar(child: Icon(CupertinoIcons.person)),
              ),
            ),
        
            //for adding some space
            const SizedBox(width: 10),
        
            //user name & last seen time
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //user name
                Text(widget.user.firstName ?? "",
                    style: const TextStyle(
                        fontSize: 16,
                        color: Colors.black87,
                        fontWeight: FontWeight.w500)),
        
                //for adding some space
                const SizedBox(height: 2),
        
                //last seen time of user
                Text("last seen no active",
                    style: const TextStyle(fontSize: 13, color: Colors.black54)),
              ],
            )
          ]),
        ));
  }

  // bottom chat input field
  Widget _chatInput() {
    return Padding(
      padding: EdgeInsets.symmetric(
          vertical: MediaQuery.of(context).size.height * .01,
          horizontal: MediaQuery.of(context).size.width * .025),
      child: Row(
        children: [
          //input field & buttons
          Expanded(
            child: Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15)),
              child: Row(
                children: [
                  //emoji button
                  // IconButton(
                  //     onPressed: () {
                  //       FocusScope.of(context).unfocus();
                  //     },
                  //     icon: const Icon(Icons.emoji_emotions,
                  //         color: Colors.blueAccent, size: 25)),

                  Expanded(
                      child: Padding(
                        padding: EdgeInsets.only(left: 20.h),
                        child: TextField(
                                          controller: textController,
                                          keyboardType: TextInputType.multiline,
                                          maxLines: null,
                                          onTap: () {},
                                          decoration: const InputDecoration(
                          hintText: 'Type Something...',
                          hintStyle: TextStyle(color: Colors.grey),
                          border: InputBorder.none),
                                        ),
                      )),

                  //pick image from gallery button
                  // IconButton(
                  //     onPressed: () async {},
                  //     icon: const Icon(Icons.image,
                  //         color: Colors.blueAccent, size: 26)),

                  //take image from camera button
                

                  //adding some space
                  SizedBox(width: MediaQuery.of(context).size.width * .02),
                ],
              ),
            ),
          ),

          //send message button
          MaterialButton(
            onPressed: () {
              if (textController.text.isNotEmpty) {
                sendMessage(
                    widget.user, textController.text.toString(), context);
                textController.text = '';

                //simply send message
              }
            },
            minWidth: 0,
            padding:
                const EdgeInsets.only(top: 10, bottom: 10, right: 5, left: 10),
            shape: const CircleBorder(),
            color: mainAppColor,
            child: const Icon(Icons.send, color: Colors.white, size: 28),
          )
        ],
      ),
    );
  }
}
