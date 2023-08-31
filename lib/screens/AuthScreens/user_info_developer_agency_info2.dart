import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';
import '../../common/ColorConstants.dart';
import '../../common/custom_button_widget.dart';
import '../../common/widgetConstants.dart';

class DeveloperAgencyInfo2 extends StatefulWidget {
  const DeveloperAgencyInfo2(
      {super.key,
      this.firstName,
      this.lastName,
      this.cnicImage,
      this.email,
      this.dateOfBirth,
      required this.idCarddNumber,
      required this.userId,
      required this.selectedMember});

  final String userId;
  final String? firstName;
  final String? lastName;
  final File? cnicImage;
  final String? email;
  final String? dateOfBirth;
  final String idCarddNumber;
  final String selectedMember;

  @override
  State<DeveloperAgencyInfo2> createState() => _DeveloperAgencyInfo2State();
}

class _DeveloperAgencyInfo2State extends State<DeveloperAgencyInfo2> {
  File? profileImage;
  String profilePicUrl = '';
  String idCardImage = '';
  ImagePicker imagePicker = ImagePicker();
  bool loading = false;

  var id = Uuid();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 10.h,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Icon(Icons.arrow_back_rounded),
              ),
              SizedBox(
                height: 30.h,
              ),
              Text(
                'Add your info 2/2',
                style: style.copyWith(
                    color: Color(0xFF3A3153),
                    fontSize: 22.sp,
                    fontWeight: FontWeight.w700),
              ),
              SizedBox(
                height: 50.h,
              ),
              Text(
                'Profile picture',
                style: style.copyWith(
                    color: Color(0xFF3A3153),
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w500),
              ),
              SizedBox(
                height: 10.h,
              ),
              GestureDetector(
                onTap: () async {
                  final XFile? pickedFile =
                      await imagePicker.pickImage(source: ImageSource.gallery);

                  setState(() {
                    profileImage = File(pickedFile!.path);
                  });
                },
                child: profileImage == null
                    ? Container(
                        width: double.infinity,
                        height: 220.h,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16.r),
                            border: Border.all(color: Colors.black)),
                        alignment: Alignment.center,
                        child:
                            SvgPicture.asset('assets/images/photo_gallery.svg'))
                    : Container(
                        width: double.infinity,
                        height: 220.h,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                              fit: BoxFit.fill,
                              image: FileImage(
                                profileImage!,
                              ),
                            ),
                            borderRadius: BorderRadius.circular(16.r),
                            border: Border.all(color: Colors.black)),
                        alignment: Alignment.center,
                      ),
              ),
              SizedBox(
                height: 20.h,
              ),
              Text.rich(TextSpan(
                  text: 'By selecting ',
                  style: style.copyWith(
                      height: 1.5,
                      color: Color(
                        0xFF717171,
                      ),
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w300),
                  children: <InlineSpan>[
                    TextSpan(
                      text: 'Agree & continue',
                      style: style.copyWith(
                          height: 1.5,
                          color: Color(
                            0xFF020202,
                          ),
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w500),
                    ),
                    TextSpan(
                      text: ', I agree to the ',
                      style: style.copyWith(
                          color: Color(
                            0xFF717171,
                          ),
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w300),
                    ),
                    TextSpan(
                      text: 'Terms of service',
                      style: style.copyWith(
                          decoration: TextDecoration.underline,
                          height: 1.5,
                          color: Color(
                            0xFF717171,
                          ),
                          fontSize: 17.sp,
                          fontWeight: FontWeight.w400),
                    ),
                    TextSpan(
                      text: ', ',
                      style: style.copyWith(
                          height: 1.5,
                          color: Color(
                            0xFF717171,
                          ),
                          fontSize: 17.sp,
                          fontWeight: FontWeight.w400),
                    ),
                    TextSpan(
                      text: 'Payment terms',
                      style: style.copyWith(
                          height: 1.5,
                          decoration: TextDecoration.underline,
                          color: Color(
                            0xFF717171,
                          ),
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w300),
                    ),
                    TextSpan(
                      text: ' and acknowledge the ',
                      style: style.copyWith(
                          color: Color(
                            0xFF717171,
                          ),
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w300),
                    ),
                    TextSpan(
                      text: 'Privacy policy.',
                      style: style.copyWith(
                          decoration: TextDecoration.underline,
                          color: Color(
                            0xFF717171,
                          ),
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w300),
                    )
                  ])),
              SizedBox(
                height: 20.h,
              ),
              CustomButton(
                onPressed: () {
                  if (profileImage != null) {
                    showModalBottomSheet(
                        enableDrag: false,
                        isDismissible: false,
                        context: context,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18.r)),
                        builder: (context) {
                          return StatefulBuilder(
                            builder: (context, setState) {
                              return Container(
                                padding: EdgeInsets.symmetric(horizontal: 22.w),
                                width: double.infinity,
                                height: 340.h,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      height: 20.h,
                                    ),
                                    Center(
                                      child: Container(
                                        width: 50.w,
                                        height: 5.h,
                                        alignment: Alignment.center,
                                        decoration: BoxDecoration(
                                            color: Color(0xFFD9D9D9),
                                            borderRadius:
                                                BorderRadius.circular(6.r)),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 30.h,
                                    ),
                                    Text(
                                      'Our cookies & data policy',
                                      style: style.copyWith(
                                          fontSize: 20.sp,
                                          color: Colors.black,
                                          fontWeight: FontWeight.w700),
                                    ),
                                    SizedBox(
                                      height: 10.h,
                                    ),
                                    Text.rich(TextSpan(
                                        text:
                                            'By clicking on the "agree and continue” button below, you accept our ',
                                        style: style.copyWith(
                                            height: 1.7,
                                            color: Colors.black,
                                            fontSize: 14.sp,
                                            fontWeight: FontWeight.w300),
                                        children: <InlineSpan>[
                                          TextSpan(
                                            text: 'Cookies Policy Terms ',
                                            style: style.copyWith(
                                                decoration:
                                                    TextDecoration.underline,
                                                height: 1.7,
                                                color: Colors.black,
                                                fontSize: 14.sp,
                                                fontWeight: FontWeight.w400),
                                          ),
                                          TextSpan(
                                            text: 'and ',
                                            style: style.copyWith(
                                                height: 1.7,
                                                color: Colors.black,
                                                fontSize: 14.sp,
                                                fontWeight: FontWeight.w400),
                                          ),
                                          TextSpan(
                                            text: 'Conditions Data Policy',
                                            style: style.copyWith(
                                                height: 1.7,
                                                decoration:
                                                    TextDecoration.underline,
                                                color: Colors.black,
                                                fontSize: 14.sp,
                                                fontWeight: FontWeight.w300),
                                          ),
                                        ])),
                                    SizedBox(
                                      height: 20.h,
                                    ),
                                    loading
                                        ? Center(
                                            child: CircularProgressIndicator(
                                              color: mainAppColor,
                                            ),
                                          )
                                        : CustomButton(
                                            onPressed: () async {
                                              if (profileImage != null) {
                                                setState(() {
                                                  loading = true;
                                                });

                                                // await uploadIdCard(
                                                //     context,
                                                //     widget.userId,
                                                //     widget.cnicImage!);

                                                await uploadPic(
                                                    context,
                                                    widget.userId,
                                                    profileImage!);

                                                print(widget.firstName);
                                                print(widget.lastName);
                                                print(widget.email);
                                                print(profilePicUrl);
                                                print(idCardImage);
                                                print(widget.userId);
                                                print(widget.idCarddNumber);
                                                print(widget.cnicImage);

                                                await FirebaseFirestore.instance
                                                    .collection('users')
                                                    .doc(widget.userId)
                                                    .update({
                                                  'firstName': widget.firstName,
                                                  'lastName': widget.lastName,
                                                  'email': widget.email,
                                                  'photoUrl': profilePicUrl,
                                                  'cnicImage': idCardImage,
                                                  'profileCompleted': true,
                                                  'cnic': widget.idCarddNumber,
                                                  'memberType':
                                                      widget.selectedMember
                                                }).then((value) {
                                                  setState(() {
                                                    loading = false;
                                                  });
                                                  Navigator
                                                      .pushNamedAndRemoveUntil(
                                                          context,
                                                          successScreenRoute,
                                                          (route) => false);
                                                }).catchError((e) {
                                                  print(e);
                                                });
                                              } else {
                                                Fluttertoast.showToast(
                                                    msg: 'Profile Completed!');
                                              }
                                            },
                                            textStyle: style.copyWith(
                                              color: Colors.white,
                                              fontSize: 19.sp,
                                              fontWeight: FontWeight.w500,
                                            ),
                                            borderColor: Colors.black,
                                            text: 'Agree & continue',
                                            fillColor: LinearGradient(
                                                begin: Alignment.topCenter,
                                                end: Alignment.bottomCenter,
                                                colors: [
                                                  mainAppColor,
                                                  Colors.black
                                                ]),
                                          ),
                                    SizedBox(
                                      height: 10.h,
                                    ),
                                    CustomButton(
                                      textStyle: style.copyWith(
                                        color: Colors.grey,
                                        fontSize: 19.sp,
                                        fontWeight: FontWeight.w500,
                                      ),
                                      borderColor: Colors.black,
                                      text: 'Decline',
                                      fillColor: LinearGradient(
                                          begin: Alignment.topCenter,
                                          end: Alignment.bottomCenter,
                                          colors: [Colors.white, Colors.white]),
                                    )
                                  ],
                                ),
                              );
                            },
                          );
                        });
                  } else {
                    Fluttertoast.showToast(msg: 'Please add profile pic!');
                  }
                },
                textStyle: style.copyWith(
                  color: Colors.white,
                  fontSize: 19.sp,
                  fontWeight: FontWeight.w500,
                ),
                borderColor: Colors.black,
                text: 'Agree & continue',
                fillColor: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [mainAppColor, Colors.black]),
              ),
              SizedBox(
                height: 11.h,
              ),
              CustomButton(
                textStyle: style.copyWith(
                  color: Colors.grey,
                  fontSize: 19.sp,
                  fontWeight: FontWeight.w500,
                ),
                borderColor: Colors.black,
                text: 'Skip for later',
                fillColor: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Colors.white, Colors.white]),
              )
            ],
          ),
        ),
      ),
    );
  }

  Future uploadIdCard(BuildContext context, String userId, File image) async {
    Reference firebaseStorageRef = FirebaseStorage.instance
        .ref()
        .child(DateTime.now().microsecondsSinceEpoch.toString());
    UploadTask uploadTask = firebaseStorageRef.putFile(image);

    final snapshot = await uploadTask.whenComplete(() {});
    var dowurl = await snapshot.ref.getDownloadURL();
    print("download : ${dowurl}");

    setState(() {
      idCardImage = dowurl.toString();

      // if (uploadTask.snapshot.state == TaskState.success) {
      //   FirebaseFirestore.instance
      //       .collection('users')
      //       .doc(userId)
      //       .update({'photoUrl': '$idCardImage'}).then((value) {
      //     ScaffoldMessenger.of(context).showSnackBar(
      //         SnackBar(content: Text('Profile Picture Uploaded')));
      //   });
      // } else if (uploadTask.snapshot.state == TaskState.running) {
      //   print('File in Progress');
      // }
    });
  }

  Future uploadPic(BuildContext context, String userId, File image) async {
    Reference firebaseStorageRef = FirebaseStorage.instance.ref().child(
        DateTime.now().microsecondsSinceEpoch.toString() + id.v4().toString());
    UploadTask uploadTask = firebaseStorageRef.putFile(image);

    final snapshot = await uploadTask.whenComplete(() {});
    var dowurl = await snapshot.ref.getDownloadURL();
    print("download : ${dowurl}");

    setState(() {
      profilePicUrl = dowurl.toString();

      // if (uploadTask.snapshot.state == TaskState.success) {
      //   FirebaseFirestore.instance
      //       .collection('users')
      //       .doc(userId)
      //       .update({'photoUrl': '$profilePicUrl'}).then((value) {
      //     ScaffoldMessenger.of(context).showSnackBar(
      //         SnackBar(content: Text('Profile Picture Uploaded')));
      //   });
      // } else if (uploadTask.snapshot.state == TaskState.running) {
      //   print('File in Progress');
      // }
    });
  }
}
