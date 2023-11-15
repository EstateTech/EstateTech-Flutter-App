import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crypto_estate_tech/common/ColorConstants.dart';
import 'package:crypto_estate_tech/common/widgetConstants.dart';
import 'package:crypto_estate_tech/helperclass/dataFromFirestore.dart';
import 'package:crypto_estate_tech/model/signupSaveDataFirebase.dart';
import 'package:crypto_estate_tech/screens/inbox/chatcard.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class InboxScreen extends StatefulWidget {
  InboxScreen({super.key});

  @override
  State<InboxScreen> createState() => _InboxScreenState();
}

class _InboxScreenState extends State<InboxScreen> {
  List<SignupSavepDataFirebase> alllist = [];
  List<SignupSavepDataFirebase> _searchlist = [];
  bool _isSearching = false;
  List<SignupSavepDataFirebase> chatList = [];
  List<SignupSavepDataFirebase> _chatSearchList = [];
  List<String> receiverList = [];
  bool _isLoadingWidget = false;
  TextEditingController searchController = TextEditingController();
  String senderId = "";
  bool _isChatListSearched = false;
  bool istyping = false;
  String selectedOption = 'Member';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    try {
      // Replace 'senderId' with the actual sender ID
      setState(() {
        _isLoadingWidget = true;
      });
      senderId = FirebaseAuth.instance.currentUser!.uid;
      receiverList = await getReceiverIdsBySenderId(senderId);
      setState(() {
        _isLoadingWidget = false;
      });

      print(" the reciver id in the fetchdata method is $receiverList");
    } catch (e) {
      print('Error fetching user ID: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: WillPopScope(
          onWillPop: () {
            if (_isSearching) {
              setState(() {
                _isSearching = !_isSearching;
              });
              return Future.value(false);
            } else {
              return Future.value(true);
            }
          },
          child: Scaffold(
            backgroundColor: Colors.white,
            appBar: PreferredSize(
              preferredSize: Size(MediaQuery.of(context).size.width * 1, 60),
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 15.w),
                child: _isChatListSearched
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Container(
                              child: searchTextField(),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                _isChatListSearched = !_isChatListSearched;
                              });
                            },
                            child: Icon(
                              Icons.close,
                              color: Colors.purple,
                            ),
                          ),
                        ],
                      )
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              _isSearching
                                  ? Container(
                                      width: 200.w,
                                      //height: 5.h,
                                      child: searchTextField(),
                                    )
                                  : Text(
                                      'Inbox',
                                      style: GoogleFonts.dmSans(
                                          color: Color(0xFF3A3153),
                                          fontSize: 22.sp,
                                          fontWeight: FontWeight.w700),
                                    ),
                            ],
                          ),
                          Row(
                            children: [
                            _isSearching ?  Row(
                                children: [
                                  DropdownButton<String>(
                                    value: selectedOption,
                                    onChanged: (String? newValue) {
                                      setState(() {
                                        selectedOption = newValue!;
                                        _searchlist.clear();
                                        istyping = false;
                                        searchController.text = "";
                                     
                                      });
                                     
                                    },
                                    items: <String>[
                                      'Member',
                                      'Developer',
                                      'Agency'
                                    ].map<DropdownMenuItem<String>>((String value) {
                                      return DropdownMenuItem<String>(
                                        value: value,
                                        child: Text(value),
                                      );
                                    }).toList(),
                                  ),
                                   GestureDetector(
                                onTap: () {
                                  setState(() {
                                    _isSearching = !_isSearching;
                                    searchController.text = "";
                                    istyping = false;
                                  });
                                },
                                child: Icon(
                                  CupertinoIcons.clear_circled_solid,
                                  color: Color(0xFF3A3153),
                                  size: 29.w,
                                ),
                              ),
                                ],
                              ):
                             
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    _isChatListSearched = !_isChatListSearched;
                                    _chatSearchList = chatList;
                                  });
                                },
                                child: Icon(
                                  Icons.search,
                                  color: Color(0xFF3A3153),
                                  size: 29.w,
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
              ),
            ),
            body: Column(
              children: [
                SizedBox(
                  height: 10.h,
                ),
                Container(
                  height: 1.h,
                  color: Colors.black,
                ),
                SizedBox(
                  height: 20.h,
                ),
                Expanded(
                    child: _isSearching
                        ? StreamBuilder(
                            stream: FirebaseFirestore.instance
                                .collection('users')
                                .where('memberType',
                                    isEqualTo:
                                        selectedOption)
                                .snapshots(),
                            builder: (context, snapshot) {
                              switch (snapshot.connectionState) {
                                case ConnectionState.waiting:
                                case ConnectionState.none:
                                  return const Center(
                                    child: CircularProgressIndicator(),
                                  );

                                case ConnectionState.active:
                                case ConnectionState.done:
                                  final data = snapshot.data?.docs;
                                  alllist = data
                                          ?.map((e) =>
                                              SignupSavepDataFirebase.fromJson(
                                                  e.data()))
                                          .toList() ??
                                      [];

                                  if (_searchlist.isEmpty &&
                                      searchController.text.isNotEmpty) {
                                    return Center(
                                      child: Text(
                                        "No matching results found!!",
                                        style: style.copyWith(
                                            color: mainAppColor,
                                            fontSize: 20.sp),
                                        textAlign: TextAlign.center,
                                      ),
                                    );
                                  } else if (istyping) {
                                    return ListView.builder(
                                        itemCount: _searchlist.length,
                                        itemBuilder: (context, index) {
                                          return ChatCard(
                                            user: _searchlist[index],
                                            isSelected: false,
                                          );
                                        });
                                  } else if (alllist.isNotEmpty) {
                                    return ListView.builder(
                                        itemCount: alllist.length,
                                        itemBuilder: (context, index) {
                                          return ChatCard(
                                            user: alllist[index],
                                            isSelected: false,
                                          );
                                        });
                                  } else {
                                    return Center(
                                      child: Text("No User found"),
                                    );
                                  }
                              }
                            })
                        : !_isLoadingWidget
                            ? !receiverList.isEmpty
                                ? StreamBuilder(
                                    stream: FirebaseFirestore.instance
                                        .collection('users')
                                        .where('userId',
                                            whereIn:
                                                receiverList) // Filter documents by user IDs
                                        .snapshots(),
                                    builder: (context, snapshot) {
                                      switch (snapshot.connectionState) {
                                        case ConnectionState.waiting:
                                        case ConnectionState.none:
                                          return const Center(
                                            child: CircularProgressIndicator(),
                                          );

                                        case ConnectionState.active:
                                        case ConnectionState.done:
                                          final data = snapshot.data?.docs;

                                          chatList = data
                                                  ?.map((e) =>
                                                      SignupSavepDataFirebase
                                                          .fromJson(e.data()))
                                                  .toList() ??
                                              [];
                                          if (chatList.isNotEmpty) {
                                            if (_chatSearchList.isEmpty &&
                                                searchController
                                                    .text.isNotEmpty) {
                                              return Center(
                                                child: Text(
                                                  "No matching results found!!",
                                                  style: style.copyWith(
                                                      color: mainAppColor,
                                                      fontSize: 20.sp),
                                                  textAlign: TextAlign.center,
                                                ),
                                              );
                                            } else if (_isChatListSearched) {
                                              return chatListViewBuilder(
                                                  _chatSearchList);
                                            } else {
                                              return chatListViewBuilder(
                                                  chatList);
                                            }
                                          } else {
                                            return const Center(
                                              child: Text("No Chats!"),
                                            );
                                          }
                                      }
                                    })
                                : Container(
                                    alignment: Alignment.center,
                                    height: 100.h,
                                    child: Text(
                                      "No chats Found :(",
                                      style: style.copyWith(
                                          color: mainAppColor, fontSize: 20.sp),
                                      textAlign: TextAlign.center,
                                    ))
                            : Container(
                                alignment: Alignment.center,
                                height: 100.h,
                                width: 100.h,
                                child: CircularProgressIndicator(
                                  color: mainAppColor,
                                )))
              ],
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                setState(() {
                  _isSearching = !_isSearching;
                });
                if (!_isSearching) {
                  fetchData();
                }
              },
              child: Icon(Icons.message),
              backgroundColor: mainAppColor,
            ),
          ),
        ),
      ),
    );
  }

  ListView chatListViewBuilder(List<SignupSavepDataFirebase> list) {
    return ListView.builder(
        itemCount: list.length,
        itemBuilder: (context, index) {
          String item = list[index].firstName.toString();
          return Dismissible(
            key: Key(item),
            background: Card(
              color: mainAppColor,
              child: Align(
                alignment: Alignment.centerRight,
                child: Padding(
                  padding: EdgeInsets.only(right: 10.h),
                  child: Icon(
                    Icons.delete,
                    color: Colors.white,
                    size: 40.sp,
                  ),
                ),
              ),
            ),
            direction: DismissDirection.endToStart,
            onDismissed: (direction) {
              print("heello");
              print(" the id in on dismissed is ${list[index].userId}");
              // print(getConversationID(chatList[index].userId!));

              deleteChatDocument(
                      getConversationID(list[index].userId!), context)
                  .then((value) {
                setState(() {
                  list.removeAt(index);
                  fetchData();
                });
              });
            },
            child: ChatCard(
              user: list[index],
              isSelected: false,
            ),
          );
        });
  }

  TextField searchTextField() {
    return TextField(
      controller: searchController,
      decoration: InputDecoration(
        isCollapsed: true,
        isDense: true,
        contentPadding: EdgeInsets.zero,
        border: InputBorder.none,
        hintText: 'Name , Email ...',
        hintStyle: style.copyWith(color: Colors.grey, fontSize: 18.sp),
      ),
      autofocus: true,
      style: style.copyWith(color: Colors.black, fontSize: 18.sp),
      onChanged: (value) {
        print(value);

        if (_isSearching) {
          setState(() {
            istyping = true;
            _searchlist.clear();
          });

          for (var i in alllist) {
            if (i.firstName
                    .toString()
                    .toLowerCase()
                    .contains(value.toLowerCase()) ||
                i.lastName
                    .toString()
                    .toLowerCase()
                    .contains(value.toString().toLowerCase()) ||
                i.email
                    .toString()
                    .toLowerCase()
                    .contains(value.toLowerCase())) {
              _searchlist.add(i);
              setState(() {
                _searchlist;
              });
            }
          }
        } else {
          setState(() {
            _chatSearchList.clear();
          });
          for (var i in chatList) {
            if (i.firstName
                    .toString()
                    .toLowerCase()
                    .contains(value.toLowerCase()) ||
                i.lastName
                    .toString()
                    .toLowerCase()
                    .contains(value.toString().toLowerCase())) {
              _chatSearchList.add(i);
            }
            setState(() {
              _chatSearchList;
            });
          }
        }
      },
    );
  }
}
