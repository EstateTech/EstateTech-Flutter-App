import 'dart:io';

import 'package:crypto_estate_tech/screens/AuthScreens/user_info_developer_agency_info2.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

import '../../common/ColorConstants.dart';
import '../../common/custom_button_widget.dart';
import '../../common/fixedvalues.dart';
import '../../common/widgetConstants.dart';
import '../../components/own_textfield.dart';

class UserInfoDeveloper extends StatefulWidget {
  const UserInfoDeveloper({super.key, required this.email});

  final String email;

  @override
  State<UserInfoDeveloper> createState() => _UserInfoDeveloperState();
}

class _UserInfoDeveloperState extends State<UserInfoDeveloper> {
  bool readonly = false;
  String selectedMember = '';
  File? _image;
  String profilePicUrl = '';
  ImagePicker imagePicker = ImagePicker();
  GlobalKey<FormState> _key = GlobalKey<FormState>();
  TextEditingController firstName = TextEditingController();
  TextEditingController lastName = TextEditingController();
  TextEditingController idCardNumber = TextEditingController();
  TextEditingController dateOfBirth = TextEditingController();
  TextEditingController email = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      showModalBottomSheet(
        isDismissible: false,
        context: context,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(18.r)),
        builder: (context) {
          return Container(
            padding: EdgeInsets.symmetric(horizontal: 22.w),
            width: double.infinity,
            height: 400.h,
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
                        borderRadius: BorderRadius.circular(6.r)),
                  ),
                ),
                SizedBox(
                  height: 30.h,
                ),
                Text(
                  'Account type',
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
                            decoration: TextDecoration.underline,
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
                            decoration: TextDecoration.underline,
                            color: Colors.black,
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w300),
                      ),
                    ])),
                SizedBox(
                  height: 20.h,
                ),
                CustomButton(
                  onPressed: () {
                    setState(() {
                      selectedMember = 'Member';
                      Navigator.pop(context);
                    });
                  },
                  textStyle: style.copyWith(
                    color: Colors.white,
                    fontSize: 19.sp,
                    fontWeight: FontWeight.w500,
                  ),
                  borderColor: Colors.black,
                  text: 'Member',
                  fillColor: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [mainAppColor, Colors.black]),
                ),
                SizedBox(
                  height: 10.h,
                ),
                CustomButton(
                  onPressed: () {
                    setState(() {
                      selectedMember = 'Developer';
                      Navigator.pop(context);
                    });
                  },
                  textStyle: style.copyWith(
                    color: Colors.white,
                    fontSize: 19.sp,
                    fontWeight: FontWeight.w500,
                  ),
                  borderColor: Colors.black,
                  text: 'Developer',
                  fillColor: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [mainAppColor, Colors.black]),
                ),
                SizedBox(
                  height: 10.h,
                ),
                CustomButton(
                  onPressed: () {
                    setState(() {
                      selectedMember = 'Agency';
                      Navigator.pop(context);
                    });
                  },
                  textStyle: style.copyWith(
                    color: Colors.white,
                    fontSize: 19.sp,
                    fontWeight: FontWeight.w500,
                  ),
                  borderColor: Colors.black,
                  text: 'Agency',
                  fillColor: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [mainAppColor, Colors.black]),
                ),
                SizedBox(
                  height: 10.h,
                ),
              ],
            ),
          );
        },
      );

      setState(() {
        email.text = widget.email;
        if (email.text.length != 0) {
          readonly = true;
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Form(
        key: _key,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 50.h,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Container(
                    child: Icon(Icons.arrow_back_rounded),
                  ),
                ),
                SizedBox(
                  height: 30.h,
                ),
                Text(
                  'Add your info 1/2',
                  style: style.copyWith(
                      color: Color(0xFF3A3153),
                      fontSize: 22.sp,
                      fontWeight: FontWeight.w700),
                ),
                Container(
                  width: double.infinity,
                  alignment: Alignment.centerRight,
                  child: Text(
                    'Agent info',
                    style: style.copyWith(
                        color: Color(0xFF3A3153),
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w600),
                  ),
                ),
                SizedBox(
                  height: 20.h,
                ),
                OwnTextfield(
                  controller: firstName,
                  label: 'First Name',
                  hint: 'Scott',
                  validator: (v) {
                    if (v!.isEmpty) {
                      return 'First name required';
                    }
                  },
                ),
                SizedBox(
                  height: 20.h,
                ),
                OwnTextfield(
                  controller: lastName,
                  label: 'Last Name',
                  hint: 'Brown',
                  validator: (v) {
                    if (v!.isEmpty) {
                      return 'Last name required';
                    }
                  },
                ),
                SizedBox(
                  height: 10.h,
                ),
                Text(
                  'Make sure it matches on your governement issued ID',
                  style: style.copyWith(
                    color: Colors.black.withOpacity(0.8),
                  ),
                ),
                SizedBox(
                  height: 30.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Flexible(
                      child: OwnTextfield(
                        controller: idCardNumber,
                        textInputType: TextInputType.text,
                        label: 'ID Card',
                        hint: 'FI21515',
                        validator: (v) {
                          if (v!.isEmpty) {
                            return 'ID Card Required';
                          }
                        },
                      ),
                    ),
                    SizedBox(
                      width: 14.w,
                    ),
                    GestureDetector(
                      onTap: () async {
                        final XFile? pickedFile = await imagePicker.pickImage(
                            source: ImageSource.gallery);

                        setState(() {
                          _image = File(pickedFile!.path);
                        });
                      },
                      child: Container(
                        width: 60.w,
                        height: 55.h,
                        padding: EdgeInsets.all(10.w),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(13.r),
                            border: Border.all(color: Colors.black)),
                        child: _image == null
                            ? SvgPicture.asset(
                                'assets/images/add_gallery.svg',
                                alignment: Alignment.center,
                              )
                            : Image.file(_image!, fit: BoxFit.cover),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20.h,
                ),
                OwnTextfield(
                  controller: dateOfBirth,
                  label: 'Date of birth',
                  hint: '24/04/1993',
                  textInputType: TextInputType.number,
                  validator: (v) {
                    if (v!.isEmpty) {
                      return 'Date of birth Required';
                    }
                  },
                  containMask: true,
                  mask: MaskTextInputFormatter(
                      mask: "##/##/####", type: MaskAutoCompletionType.eager),
                ),
                SizedBox(
                  height: 10.h,
                ),
                Text(
                  'To sign up, you need to be at least 18. Other users won’t see you date of birth.',
                  style: style.copyWith(
                    fontSize: 14,
                    height: 1.2.h,
                    color: Colors.black.withOpacity(0.8),
                  ),
                ),
                SizedBox(
                  height: 30.h,
                ),
                OwnTextfield(
                  controller: email,
                  readonly: readonly,
                  label: 'Email',
                  hint: 'scott.brown@gmail.com',
                  validator: (v) {
                    if (v!.isEmpty) {
                      return 'Email Required';
                    }
                  },
                ),
                SizedBox(
                  height: 20.h,
                ),
                CustomButton(
                  onPressed: () {
                    if (_key.currentState!.validate()) {
                      if (_image != null) {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => DeveloperAgencyInfo2(
                                      selectedMember: selectedMember,
                                      userId: FirebaseAuth
                                          .instance.currentUser!.uid,
                                      firstName: firstName.text,
                                      lastName: lastName.text,
                                      email: email.text,
                                      dateOfBirth: dateOfBirth.text,
                                      cnicImage: _image,
                                      idCarddNumber: idCardNumber.text,
                                    )));
                        // Navigator.pushNamed(
                        //     context, userinfodeveloperscreenroute2);
                      } else {
                        Fluttertoast.showToast(
                            backgroundColor: Colors.red,
                            textColor: Colors.white,
                            msg: 'Please upload the id card image !',
                            gravity: ToastGravity.TOP);
                      }
                    }
                  },
                  textStyle: style.copyWith(
                    color: Colors.white,
                    fontSize: 19.sp,
                    fontWeight: FontWeight.w500,
                  ),
                  borderColor: Colors.black,
                  text: 'Continue',
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
                ),
                SizedBox(
                  height: 11.h,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
