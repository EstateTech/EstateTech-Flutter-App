import 'package:flutter/material.dart';

class FilterProvider with ChangeNotifier {
  String? propertyType;
  int? bedrooms;
  int? bathrooms;
  String? period;
  int? price;
  bool isFilterApplied = false;

  void updateFilterAppliedField(bool value) {
    isFilterApplied = value;
    notifyListeners();
  }

  void updatePropertyType(String? value) {
    propertyType = value;
    notifyListeners();
  }

  void updateBedrooms(int? value) {
    bedrooms = value;
    notifyListeners();
  }

  void updateBathrooms(int? value) {
    bathrooms = value;
    notifyListeners();
  }

  void updatePeriod(String? value) {
    period = value;
    notifyListeners();
  }

  void updatePrice(int? value) {
    price = value;
    notifyListeners();
  }
}
