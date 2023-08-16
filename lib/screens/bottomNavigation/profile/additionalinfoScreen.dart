import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crypto_estate_tech/common/ColorConstants.dart';
import 'package:crypto_estate_tech/common/custom_create_post_header.dart';
import 'package:crypto_estate_tech/common/custom_post_create_bottom.dart';

import 'package:crypto_estate_tech/common/widgetConstants.dart';
import 'package:crypto_estate_tech/model/postModel.dart';
import 'package:crypto_estate_tech/provider/firebaseStorageProvider.dart';
import 'package:crypto_estate_tech/provider/postImagesProvider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class AdditionalInfoScreen extends StatefulWidget {
  const AdditionalInfoScreen({super.key, required this.postModel});

  final PostModel postModel;

  @override
  State<AdditionalInfoScreen> createState() => _AdditionalInfoScreenState();
}

class _AdditionalInfoScreenState extends State<AdditionalInfoScreen> {
  TextEditingController additionaltextEditingController =
      TextEditingController();
  @override
  Widget build(BuildContext context) {
    final xFileProvider = Provider.of<XFileProvider>(context);

    List<XFile> xFiles = xFileProvider.xFiles;
    var size = MediaQuery.of(context).size;

    final firebaseStorageprovider =
        Provider.of<FirebaseStorageProvider>(context);

    Future uploadImages() async {
      Timestamp currentDate = Timestamp.now();
      // Call the upload method from the ImageUploadController

      await firebaseStorageprovider.uploadImages(xFiles, context).then((value) {
        firebaseStorageprovider.createPost(
            PostModel(
                propertyType: widget.postModel.propertyType,
                propertyPortion: widget.postModel.propertyPortion,
                latLong: widget.postModel.latLong,
                propertyOwnerNumber: widget.postModel.propertyOwnerNumber,
                propertyAddressLine1: widget.postModel.propertyAddressLine1,
                propertyAddressLine2: widget.postModel.propertyAddressLine2,
                city: widget.postModel.city,
                state: widget.postModel.state,
                postalCode: widget.postModel.postalCode,
                guest: widget.postModel.guest,
                bedrooms: widget.postModel.bedrooms,
                bathrooms: widget.postModel.bathrooms,
                propertyArea: widget.postModel.propertyArea,
                propertyBuildArea: widget.postModel.propertyBuildArea,
                propertyPlotArea: widget.postModel.propertyPlotArea,
                utilities: widget.postModel.utilities,
                propertyPhotos: value,
                propertyDescription: widget.postModel.propertyDescription,
                preferedCurrency: widget.postModel.preferedCurrency,
                amount: widget.postModel.amount,
                propertyListingType: widget.postModel.propertyListingType,
                additionalInfo: widget.postModel.additionalInfo,
                userid: FirebaseAuth.instance.currentUser!.uid,
                likes: widget.postModel.likes,
                propertyFeature: widget.postModel.propertyFeature,
                datePosted: currentDate,
                postFeature: bestofferPf,
                
                ),
            context);
      });
    }

    return Scaffold(
      // floatingActionButton: FloatingActionButton(onPressed: () {
      //   print(widget.postModel.toJson());
      // }),
      body: Consumer<FirebaseStorageProvider>(
          builder: (context, firebaseStorageProvider, _) {
        final isUploading = firebaseStorageProvider.isUploading;
        final progress = firebaseStorageProvider.progress;
        return isUploading
            ? loadingWidget(progress)
            : Container(
                height: size.height,
                width: size.width,
                padding: EdgeInsets.only(top: 50.h, left: 20.h, right: 20.h),
                decoration: BoxDecoration(
                  gradient: appBackgroundGradient,
                ),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: [
                          CustomCreatePostHeader(),
                          SizedBox(
                            height: 20.h,
                          ),
                          Text(
                            "Additional Info",
                            style: style.copyWith(
                                fontSize: 30.sp,
                                color: textwalktrough,
                                fontWeight: FontWeight.w600),
                          ),
                          SizedBox(
                            height: 10.h,
                          ),
                          Text(
                            "You may also want to give additional info or details for the users who might be interested in your property:",
                            style: style.copyWith(
                                fontSize: 15.sp, color: textwalktrough),
                          ),
                          SizedBox(
                            height: 10.h,
                          ),
                          Container(
                            alignment: Alignment.topLeft,
                            height: 200.h,
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(15.r)),
                            child: TextField(
                              maxLines: null,
                              controller: additionaltextEditingController,
                              decoration: InputDecoration(
                                hintText: 'Additional info',
                                border: InputBorder.none,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            right: 12.h, left: 12.h, bottom: 30.h),
                        child: customPostCreateBottomWidget(
                          OnPressedNextButton: () {
                            setState(() {
                              widget.postModel.additionalInfo =
                                  additionaltextEditingController.text;
                            });
                            uploadImages().then((value) {
                              Navigator.pushNamed(
                                  context, postCompletedCongratulationsScreen);
                            });
                            print(widget.postModel.toJson());
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
      }),
    );
  }
}
