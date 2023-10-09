import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crypto_estate_tech/common/widgetConstants.dart';
import 'package:crypto_estate_tech/model/postModel.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class FirebaseStorageProvider extends ChangeNotifier {
  final FirebaseStorage _storage = FirebaseStorage.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  bool _isUploading = false;
  bool get isUploading => _isUploading;

  

   setisUploading(bool isUploading){
    this._isUploading=isUploading;
    notifyListeners();

   }

  Future<List<String>?> uploadImages(
      List<XFile> imageFiles, BuildContext context) async {
    try {
      // _isUploading = true;
      // notifyListeners();

      List<String> downloadUrls = [];

      for (XFile imageFile in imageFiles) {
        // Generate a unique file name for the uploaded image
        String uid = FirebaseAuth.instance.currentUser!.uid;
        String fileName =
            DateTime.now().millisecondsSinceEpoch.toString() + uid;

        // Upload the image to Firebase Storage
        final Reference storageReference =
            _storage.ref().child('images/$fileName');

        final UploadTask uploadTask =
            storageReference.putFile(File(imageFile.path));
        // to get the progress of task
        uploadTask.snapshotEvents.listen((TaskSnapshot snapshot) {
          // double progress =
          //     (snapshot.bytesTransferred / snapshot.totalBytes) * 100;
          // _progress = progress;
          notifyListeners();
        });
        final TaskSnapshot taskSnapshot = await uploadTask;

        // Get the download URL of the uploaded image
        final String downloadUrl = await taskSnapshot.ref.getDownloadURL();

        downloadUrls.add(downloadUrl);
      }

      // _isUploading = false;
      // notifyListeners();

      showSnackBar(context, "Successfully Uploaded");

      return downloadUrls;
    } catch (error) {
      // _isUploading = false;
      // notifyListeners();

      // Handle error
      print('Image upload error: $error');
      showSnackBar(context, "Error Occurred While Uploading Images");
      return null;
    }
  }

  Future<void> createPost(PostModel post, BuildContext context) async {
    try {
      // Generate a unique UID for the post collection
      _isUploading = true;
      notifyListeners();

      final String postUid = DateTime.now().millisecondsSinceEpoch.toString();
      await _firestore.collection('posts').doc(postUid).set({
        "propertyType": post.propertyType,
        "propertyPortion": post.propertyPortion,
        "latLong": post.latLong,
        "propertyOwnerNumber": post.propertyOwnerNumber,
        "propertyAddressLine1": post.propertyAddressLine1,
        "propertyAddressLine2": post.propertyAddressLine2,
        "city": post.city,
        "state": post.state,
        "postalCode": post.postalCode,
        "guest": post.guest, //int?
        "bedrooms": post.bedrooms, // int?
        "bathrooms": post.bathrooms, //  int?
        "propertyArea": post.propertyArea, // int?
        "propertyBuildArea": post.propertyBuildArea, //  int?
        "propertyPlotArea": post.propertyPlotArea, //int?
        "utilities": post.utilities,
        "propertyPhotos": post.propertyPhotos,
        "propertyDescription": post.propertyDescription,
        "preferedCurrency": post.preferedCurrency,
        "amount": post.amount,
        "propertyListingType": post.propertyListingType,
        "additionalInfo": post.additionalInfo,
        "userid": post.userid,
        "likes": post.likes,

        "propertyFeature": post.propertyFeature,
        "datePosted": post.datePosted,
        "postFeature": post.postFeature
      });
      print('Post created successfully!');

      _isUploading = false;
      notifyListeners();

      showSnackBar(context, "Successfully Uploaded");
    } catch (error) {
      _isUploading = false;
      notifyListeners();

      print('Error creating post: $error');
      showSnackBar(context, "Error Occurred: ${error.toString()}");
    }
  }
}
