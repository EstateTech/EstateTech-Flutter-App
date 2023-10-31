import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:crypto_estate_tech/common/ColorConstants.dart';
import 'package:crypto_estate_tech/common/custom_button_widget.dart';
import 'package:crypto_estate_tech/common/custom_create_post_header.dart';
import 'package:crypto_estate_tech/common/custom_post_create_bottom.dart';
import 'package:crypto_estate_tech/common/widgetConstants.dart';
import 'package:crypto_estate_tech/model/postModel.dart';
import 'package:crypto_estate_tech/provider/XfileProvider.dart';
import 'package:crypto_estate_tech/screens/bottomNavigation/profile/AddPropertyScreens/propertyDescription.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

class AddPhotoScreen extends StatefulWidget {
  const AddPhotoScreen(
      {super.key, required this.postModel, required this.isEdited});

  final PostModel postModel;
  final bool isEdited;

  @override
  State<AddPhotoScreen> createState() => _AddPhotoScreenState();
}

class _AddPhotoScreenState extends State<AddPhotoScreen> {
  final List<XFile>? _selectedImages = [];
  List<String?> networkImages = []; // For network images
  ImageSource? globalImageSource;

  Future<void> _getImage(ImageSource source) async {
    final picker = ImagePicker();

    final List<XFile> selectedGalleryImages = await picker.pickMultiImage();
    if (selectedGalleryImages.isNotEmpty) {
      setState(() {
        _selectedImages!.addAll(selectedGalleryImages);
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (widget.isEdited) {
      // Assuming postModel.propertyPhotos is a List<String> of network image URLs
      networkImages = widget.postModel.propertyPhotos!;
    }
  }

  @override
  Widget build(BuildContext context) {
    final xFileProvider = Provider.of<XFileProvider>(context);
    return Scaffold(
      body: Container(
        padding: EdgeInsets.only(left: 20.h, right: 20.h),
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: const BoxDecoration(gradient: appBackgroundGradient),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            const CustomCreatePostHeader(),
            // SizedBox(
            //   height: 20.h,
            // ),
            Column(
              children: [
                Text(
                  "Add some photos of your property",
                  style: style.copyWith(
                      fontSize: 25.sp,
                      color: textwalktrough,
                      fontWeight: FontWeight.w500),
                ),
                SizedBox(
                  height: 10.h,
                ),
                Text(
                  "You ‘ll need 5 photos to get started, but you can add more later or make changes.",
                  style: style.copyWith(fontSize: 15.sp, color: textwalktrough),
                )
              ],
            ),

            Column(
              children: [
                _selectedImages!.isEmpty && networkImages.isEmpty
                    ? UploadImageContainer()
                    : Container(
                        height: 300.h,
                        decoration: BoxDecoration(
                            border: Border.all(color: textwalktrough, width: 2),
                            borderRadius: BorderRadius.circular(20.r)),
                        child: GridView.builder(
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            childAspectRatio: 1.4,
                          ),
                          itemCount:
                              networkImages.length + _selectedImages!.length,
                          itemBuilder: (BuildContext context, int index) {
                            if (index < networkImages.length) {
                              // Display network images
                              return NetworkImagePost(networkImages[index]!,
                                  () {
                                setState(() {
                                  networkImages.removeAt(index);
                                });
                              });
                            } else {
                              // Display local images
                              final localImageIndex =
                                  index - networkImages.length;
                              return PostImageWidget(
                                  ValueKey(_selectedImages![localImageIndex]),
                                  File(_selectedImages![localImageIndex].path),
                                  () {
                                setState(() {
                                  _selectedImages!.removeAt(localImageIndex);
                                });
                              });
                            }
                          },
                        ),
                      ),
                SizedBox(
                  height: 20.h,
                ),
                CustomButton(
                  text: "Add 360 images",
                  fillColor: const LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [mainAppColor, Colors.black]),
                  borderColor: Colors.black,
                  textStyle: style.copyWith(
                    color: Colors.white,
                    fontSize: 19.sp,
                    fontWeight: FontWeight.w500,
                  ),
                  onPressed: () {
                    _getImage(ImageSource.gallery);
                  },
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.only(right: 12.h, left: 12.h, bottom: 30.h),
              child: customPostCreateBottomWidget(
                OnPressedNextButton: () {
                  if (_selectedImages!.isNotEmpty || networkImages.isNotEmpty) {
                    if (widget.isEdited) {
                      xFileProvider.updateImages(
                          _selectedImages!, networkImages as List<String>);
                    } else {
                      setState(() {
                        xFileProvider.setXFiles(_selectedImages!);
                      });
                    }

                    // Your updated list

                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => PropertyDescriptionScreen(
                                postModel: widget.postModel,
                                isEdited: widget.isEdited)));
                  } else {
                    Fluttertoast.showToast(
                        msg: 'Please select at least one image');
                  }
                },
                OnPressedbackButton: () {
                  Navigator.pop(context);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Container UploadImageContainer() {
    return Container(
        width: double.infinity,
        height: 300.h,
        margin: EdgeInsets.only(left: 15.h, right: 15.h),
        decoration: BoxDecoration(
            border: Border.all(color: textwalktrough, width: 2),
            borderRadius: BorderRadius.circular(20.r)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            SvgPicture.asset("assets/images/jam_picture.svg"),
            Text(
              "Add at least 5 photos",
              style: style.copyWith(
                  color: textwalktrough,
                  fontSize: 15.sp,
                  fontWeight: FontWeight.w700),
            ),
            GestureDetector(
              onTap: () {
                _getImage(ImageSource.gallery);
              },
              child: Text(
                "Upload from your device",
                style: style.copyWith(
                  color: textwalktrough,
                  fontSize: 15.sp,
                  decoration: TextDecoration.underline,
                ),
              ),
            ),
          ],
        ));
  }

  Widget PostImageWidget(Key key, File file, VoidCallback OnTap) {
    return Container(
      height: 100.h,
      margin: EdgeInsets.all(10.h),

      key: key,
      // margin: EdgeInsets.only(left: 10.h),
      child: Stack(
        alignment: Alignment.topRight,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(15.r),
            child: Image.file(
              file,
              width: double.infinity,
              height: 120,
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 5.h, right: 2.h),
            child: GestureDetector(
              onTap: OnTap,
              child: Icon(
                Icons.close,
                color: Colors.white,
                size: 20.h,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget NetworkImagePost(String path, VoidCallback OnTap) {
    return Container(
      height: 100.h,
      margin: EdgeInsets.all(10.h),

      // margin: EdgeInsets.only(left: 10.h),
      child: Stack(
        alignment: Alignment.topRight,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(15.r),
            child: CachedNetworkImage(
              key: UniqueKey(),
              imageUrl: path,
              fit: BoxFit.cover,
              width: double.infinity,
              height: 120,
              placeholder: (context, url) => Container(
                child: Lottie.asset(
                  'assets/images/loading_animation.json', // Replace with your animation file path
                  width: double.infinity,
                  height: 120,
                  // Other properties you can customize
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 5.h, right: 2.h),
            child: GestureDetector(
              onTap: OnTap,
              child: Icon(
                Icons.close,
                color: Colors.white,
                size: 20.h,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
