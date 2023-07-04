import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_picker/image_picker.dart';

class PostModel {
  String? propertyType;
  String? propertyPortion;
  LatLng? latLong;
  String? propertyOwnerNumber;
  String? propertyAddressLine1;
  String? propertyAddressLine2;
  String? city;
  String? state;
  String? postalCode;
  int? guest;
  int? bedrooms;
  int? bathrooms;
  int? propertyArea;
  int? propertyBuildArea;
  int? propertyPlotArea;
  List<String>? utilities;
  List<XFile?>? propertyPhotos;
  String? propertyDescription;
  String? preferedCurrency;
  String? amount;
  String? propertyListingType;
  String? additionalInfo;

  PostModel(
      {this.propertyType,
      this.propertyPortion,
      this.latLong,
      this.propertyOwnerNumber,
      this.propertyAddressLine1,
      this.propertyAddressLine2,
      this.city,
      this.state,
      this.postalCode,
      this.guest,
      this.bedrooms,
      this.bathrooms,
      this.propertyArea,
      this.propertyBuildArea,
      this.propertyPlotArea,
      this.utilities,
      this.propertyPhotos,
      this.propertyDescription,
      this.preferedCurrency,
      this.amount,
      this.propertyListingType,
      this.additionalInfo});

  PostModel.fromJson(Map<String, dynamic> json) {
    propertyType = json['propertyType'];
    propertyPortion = json['propertyPortion'];
    latLong = json['LatLong'];
    propertyOwnerNumber = json['propertyOwnerNumber'];
    propertyAddressLine1 = json['propertyAddressLine1'];
    propertyAddressLine2 = json['propertyAddressLine2'];
    city = json['city'];
    state = json['state'];
    postalCode = json['postalCode'];
    guest = json['guest'];
    bedrooms = json['bedrooms'];
    bathrooms = json['bathrooms'];
    propertyArea = json['propertyArea'];
    propertyBuildArea = json['propertyBuildArea'];
    propertyPlotArea = json['propertyPlotArea'];
    utilities = json['Utilities'].cast<String>();
    propertyPhotos = json['propertyPhotos'].cast<String>();
    propertyDescription = json['propertyDescription'];
    preferedCurrency = json['preferedCurrency'];
    amount = json['amount'];
    propertyListingType = json['propertyListingType'];
    additionalInfo = json['additionalInfo'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['propertyType'] = this.propertyType;
    data['propertyPortion'] = this.propertyPortion;
    data['LatLong'] = this.latLong;
    data['propertyOwnerNumber'] = this.propertyOwnerNumber;
    data['propertyAddressLine1'] = this.propertyAddressLine1;
    data['propertyAddressLine2'] = this.propertyAddressLine2;
    data['city'] = this.city;
    data['state'] = this.state;
    data['postalCode'] = this.postalCode;
    data['guest'] = this.guest;
    data['bedrooms'] = this.bedrooms;
    data['bathrooms'] = this.bathrooms;
    data['propertyArea'] = this.propertyArea;
    data['propertyBuildArea'] = this.propertyBuildArea;
    data['propertyPlotArea'] = this.propertyPlotArea;
    data['Utilities'] = this.utilities;
    data['propertyPhotos'] = this.propertyPhotos;
    data['propertyDescription'] = this.propertyDescription;
    data['preferedCurrency'] = this.preferedCurrency;
    data['amount'] = this.amount;
    data['propertyListingType'] = this.propertyListingType;
    data['additionalInfo'] = this.additionalInfo;
    return data;
  }
}
