import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crypto_estate_tech/common/ColorConstants.dart';
import 'package:crypto_estate_tech/common/widgetConstants.dart';
import 'package:crypto_estate_tech/helperclass/dataFromFirestore.dart';
import 'package:crypto_estate_tech/model/signupSaveDataFirebase.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lottie/lottie.dart';

class PersonalInformation extends StatefulWidget {
  const PersonalInformation({super.key});

  @override
  State<PersonalInformation> createState() => _PersonalInformationState();
}

class _PersonalInformationState extends State<PersonalInformation> {
  String? photoUrl; // To store the URL of the profile photo
  bool isLoading = false;
  final ImagePicker picker = ImagePicker();

  Future<void> _updateProfilePhoto(String imagePath) async {
    User? user = FirebaseAuth.instance.currentUser;
    setState(() {
      isLoading = true; // Start loading indicator
    });

    // Upload the image to Firebase Storage
    final Reference storageRef =
        FirebaseStorage.instance.ref().child('profile_photos').child(user!.uid);
    final UploadTask uploadTask = storageRef.putFile(File(imagePath));

    await uploadTask.whenComplete(() async {
      // Get the download URL of the uploaded image
      final String imageUrl = await storageRef.getDownloadURL();

      // Update the photoUrl field in Firestore
      await updateUserPhotoUrl(user.uid, imageUrl);

      // Update the UI with the new photoUrl
      setState(() {
        photoUrl = imageUrl;
        isLoading = false; // Stop loading indicator
      });
    });
  }

  Future<void> updateUserPhotoUrl(String userId, String imageUrl) async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .update({'photoUrl': imageUrl});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(left: 10.h, right: 10.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Icon(
                  Icons.arrow_back_ios,
                  size: 30.h,
                  color: Colors.black54,
                ),
              ),
              SizedBox(
                height: 30.h,
              ),
              Padding(
                padding: EdgeInsets.only(left: 20.h),
                child: Text(
                  "Personal information",
                  style: style.copyWith(
                      fontSize: 25.sp,
                      color: Shade2purple,
                      fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(
                height: 20.h,
              ),
              Align(
                alignment: Alignment.center,
                child: StreamBuilder<DocumentSnapshot>(
                    stream: getUserDataStream(
                        FirebaseAuth.instance.currentUser!.uid),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Text(
                          "Loading....",
                          style: style.copyWith(
                            fontSize: 15.sp,
                            color: Shade2purple,
                          ),
                        );
                      }

                      if (!snapshot.hasData || !snapshot.data!.exists) {
                        return Text(
                          "Data not found",
                          style: style.copyWith(
                            fontSize: 15.sp,
                            color: Shade2purple,
                          ),
                        );
                      }

                      final userData = SignupSavepDataFirebase.fromJson(
                        snapshot.data!.data() as Map<String, dynamic>,
                      );

                      photoUrl = userData.photoUrl!;
                      return Column(
                        children: [
                          SizedBox(
                            height: 110.h,
                            width: 110.w,
                            child: Stack(
                              clipBehavior: Clip.none,
                              children: [
                                Center(
                                  child: Container(
                                    height: 100.h,
                                    width: 100.h,
                                    clipBehavior: Clip.antiAlias,
                                    decoration: const BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Colors.black),
                                    child: isLoading
                                        ? const CircularProgressIndicator()
                                        : CachedNetworkImage(
                                            key: UniqueKey(),
                                            imageUrl: photoUrl ?? '',
                                            fit: BoxFit.cover,
                                            placeholder: (context, url) =>
                                                Container(
                                              child: Lottie.asset(
                                                'assets/images/loading_animation.json', // Replace with your animation file path
                                                width: 70.h,
                                                height: 70.h,
                                                // Other properties you can customize
                                              ),
                                            ),
                                          ),
                                  ),
                                ),
                                Align(
                                  alignment: Alignment.bottomRight,
                                  child: GestureDetector(
                                    onTap: () {
                                      showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return AlertDialogBox(
                                              onCameraSelected: () async {
                                            Navigator.pop(context);

                                            final XFile? pickedImage =
                                                await picker.pickImage(
                                                    source: ImageSource
                                                        .camera); // You can use ImageSource.camera for the camera option
                                            if (pickedImage != null) {
                                              // Update the profile photo
                                              await _updateProfilePhoto(
                                                  pickedImage.path);
                                            }
                                          }, onGallerySelected: () async {
                                            Navigator.pop(context);
                                            final XFile? pickedImage =
                                                await picker.pickImage(
                                                    source: ImageSource.camera);
                                            if (pickedImage != null) {
                                              // Update the profile photo
                                              await _updateProfilePhoto(
                                                  pickedImage.path);
                                            }
                                          });
                                        },
                                      );
                                    },
                                    child: Container(
                                      height: 40.h,
                                      width: 40.h,
                                      clipBehavior: Clip.antiAlias,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Colors.grey.shade100,
                                      ),
                                      child: const Icon(
                                        Icons.edit,
                                        size: 30.0,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 10.h,
                          ),
                          Text(
                            "${userData.firstName}",
                            style: numberStyle.copyWith(
                              fontSize: 25.sp,
                              color: Shade2purple,
                            ),
                          )
                        ],
                      );
                    }),
              ),
              SizedBox(
                height: 20.h,
              ),
              StreamBuilder<DocumentSnapshot>(
                  stream:
                      getUserDataStream(FirebaseAuth.instance.currentUser!.uid),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Text(
                        "Loading....",
                        style: style.copyWith(
                          fontSize: 15.sp,
                          color: Shade2purple,
                        ),
                      );
                    }

                    if (!snapshot.hasData || !snapshot.data!.exists) {
                      return Text(
                        "Data not found",
                        style: style.copyWith(
                          fontSize: 15.sp,
                          color: Shade2purple,
                        ),
                      );
                    }
                    final userData = SignupSavepDataFirebase.fromJson(
                      snapshot.data!.data() as Map<String, dynamic>,
                    );
                    final email = userData.email ?? "noah.freeman@gmail.com";
                    String verified = userData.isVerified!
                        ? "Not Verified"
                        : "Verified identity";
                    return Column(
                      children: [
                        InformationField("Email", email, isPencilShown: true),
                        InformationField("Address", "24 , 17th Avenue,Dubai",
                            isPencilShown: true),
                        InformationField(
                            "Phone", userData.phoneNumber ?? "Not Available",
                            isPencilShown: true),
                        InformationField(
                          "Member\nsince",
                          "24/04/2023",
                        ),
                        InformationField("Status", verified,
                            isMemberSince: true),
                      ],
                    );
                  }),
              SocialStatus()
            ],
          ),
        ),
      ),
    );
  }

  Padding InformationField(String heading, String information,
      {bool isPencilShown = false, bool isMemberSince = false}) {
    return Padding(
      padding: EdgeInsets.only(
        left: 10.h,
      ),
      child: Row(
        children: [
          Container(
            height: 50.h,
            width: 100.w,
            // color: Colors.blue,
            alignment: Alignment.centerLeft,
            child: Text(
              heading,
              style: numberStyle.copyWith(
                fontSize: 17.sp,
                color: Shade2purple,
              ),
            ),
          ),
          SizedBox(
            height: 20.h,
            width: 200.w,
            child: Row(
              children: [
                Flexible(
                 
                  child: Text(
                    information,
                    style: numberStyle.copyWith(
                      fontSize: 17.sp,
                      color: Colors.black54,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                SizedBox(
                  width: 3.w,
                ),
                isMemberSince
                    ? SizedBox(
                        height: 20.h,
                        width: 20.h,
                        child: SvgPicture.asset(
                          "assets/images/verify_checked._icon.svg",
                          width: 20.h,
                          height: 20.h,
                        ),
                      )
                    : const SizedBox.shrink()
              ],
            ),
          ),
          isPencilShown ? const Icon(Icons.edit) : const SizedBox.shrink(),
        ],
      ),
    );
  }

  Padding SocialStatus() {
    return Padding(
      padding: EdgeInsets.only(
        left: 10.h,
      ),
      child: Row(
        children: [
          Container(
            height: 50.h,
            width: 100.w,
            // color: Colors.blue,
            alignment: Alignment.centerLeft,
            child: Text(
              "Social\nStatus",
              style: numberStyle.copyWith(
                fontSize: 17.sp,
                color: Shade2purple,
              ),
            ),
          ),
          Row(
            children: [
              Container(
                height: 30.h,
                width: 30.h,
                margin: EdgeInsets.only(right: 10.h),
                child: SvgPicture.asset("assets/images/logo_facebook.svg"),
              ),
              Container(
                height: 30.h,
                width: 30.h,
                margin: EdgeInsets.only(right: 10.h),
                child: SvgPicture.asset("assets/images/logo_google.svg"),
              ),
              Container(
                height: 30.h,
                width: 30.h,
                margin: EdgeInsets.only(right: 10.h),
                child: Image.asset(
                  "assets/images/logo_instagram.png",
                  fit: BoxFit.contain,
                ),
              ),
              Container(
                height: 30.h,
                width: 30.h,
                margin: EdgeInsets.only(right: 10.h),
                child: SvgPicture.asset("assets/images/logo_twitter.svg"),
              )
            ],
          )
        ],
      ),
    );
  }

  Widget AlertDialogBox(
      {required VoidCallback onGallerySelected,
      required VoidCallback onCameraSelected}) {
    return AlertDialog(
      title: const Text('Select an Image'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
              leading: const Icon(Icons.photo_library),
              title: const Text('Select from Gallery'),
              onTap: onGallerySelected),
          ListTile(
              leading: const Icon(Icons.camera_alt),
              title: const Text('Select from Camera'),
              onTap: onCameraSelected),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            // Handle cancel option
            Navigator.of(context).pop(); // Close the dialog
          },
          child: const Text('Cancel'),
        ),
      ],
    );
  }
}
