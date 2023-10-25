import 'package:flutter/material.dart';

class FilterProvider with ChangeNotifier {
  String propertyType = "House";
  int bedrooms = 1;
  int bathrooms = 1; 
 
  int? price;
  bool isFilterApplied = false;
  String? postFeature;
  String rentalPeriod = "Yearly";
  String rentalType = "Rent";
  String rentalSubtype = "Long-term";


  void updateRentalProperties(String rP, String rT, String rST){
    rentalPeriod = rP;
    rentalType = rT;
    rentalSubtype = rST;
    notifyListeners();
  }


  

  void updateFilterAppliedField(bool value) {
    isFilterApplied = value;
    notifyListeners();
  }

  void updatePropertyType(String value) {
    propertyType = value;
    notifyListeners();
  }

  void updateBedrooms(int value) {
    bedrooms = value;
    notifyListeners();
  }

  void updateBathrooms(int value) {
    bathrooms = value;
    notifyListeners();
  }


  void updatePrice(int? value) {
    price = value;
    notifyListeners();
  }

  void updatePostType(String? value) {
    postFeature = value;
    notifyListeners();
  }

  List<String> likedPostIds = [];

  void toggleLike(String postId) {
    if (likedPostIds.contains(postId)) {
      likedPostIds.remove(postId);
    } else {
      likedPostIds.add(postId);
    }
    notifyListeners();
  }
}
