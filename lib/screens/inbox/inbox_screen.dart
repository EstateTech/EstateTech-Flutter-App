import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crypto_estate_tech/common/widgetConstants.dart';
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
  List<SignupSavepDataFirebase> list = [];
  final List<SignupSavepDataFirebase> _searchlist = [];
  bool _isSearching = false;
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
              preferredSize: Size(MediaQuery.of(context).size.width * 1, 70),
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 18.w),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        _isSearching
                            ? Container(
                                width: 200.w,
                                child: TextField(
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: 'Name , Email ...',
                                    hintStyle: style.copyWith(
                                        color: Colors.grey, fontSize: 15.sp),
                                  ),
                                  autofocus: true,
                                  style: style.copyWith(
                                      color: Colors.black, fontSize: 15.sp),
                                  onChanged: (value) {
                                    //search logic
                                    _searchlist.clear();
                                    for (var i in list) {
                                      if (i.firstName
                                              .toString()
                                              .toLowerCase()
                                              .contains(value.toLowerCase()) ||
                                          i.lastName
                                              .toString()
                                              .toLowerCase()
                                              .contains(value
                                                  .toString()
                                                  .toLowerCase()) ||
                                          i.email
                                              .toString()
                                              .toLowerCase()
                                              .contains(value.toLowerCase())) {
                                        _searchlist.add(i);
                                      }
                                      setState(() {
                                        _searchlist;
                                      });
                                    }
                                  },
                                ),
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
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              _isSearching = !_isSearching;
                            });
                          },
                          child: Icon(
                            _isSearching
                                ? CupertinoIcons.clear_circled_solid
                                : Icons.search,
                            color: Color(0xFF3A3153),
                            size: 29.w,
                          ),
                        ),
                        SizedBox(
                          width: 10.w,
                        ),
                        Icon(
                          Icons.edit,
                          color: Color(0xFF3A3153),
                          size: 29.w,
                        ),
                        SizedBox(
                          width: 10.w,
                        ),
                        Icon(
                          Icons.delete_outline,
                          color: Color(0xFF3A3153),
                          size: 29.w,
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
            body: Column(
              children: [
                SizedBox(
                  height: 20.h,
                ),
                Container(
                  height: 1.h,
                  color: Colors.black,
                ),
                SizedBox(
                  height: 20.h,
                ),
                Expanded(
                  child: StreamBuilder(
                      stream: FirebaseFirestore.instance
                          .collection('users')
                          .where('userId',
                              isNotEqualTo:
                                  FirebaseAuth.instance.currentUser!.uid)
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
                            list = data
                                    ?.map((e) =>
                                        SignupSavepDataFirebase.fromJson(
                                            e.data()))
                                    .toList() ??
                                [];
                            if (list.isNotEmpty) {
                              return ListView.builder(
                                  itemCount: _isSearching
                                      ? _searchlist.length
                                      : list.length,
                                  itemBuilder: (context, index) {
                                    return ChatCard(
                                        user: _isSearching
                                            ? _searchlist[index]
                                            : list[index]);
                                  });
                            } else {
                              return const Center(
                                child: Text("No connections FOUND!"),
                              );
                            }
                        }
                      }),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
