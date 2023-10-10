// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';

class PostModel {
  String? propertyType;
  String? propertyPortion;
  GeoPoint? latLong;
  String? propertyOwnerNumber;
  String? propertyAddressLine1;
  String? propertyAddressLine2;
  String? city;
  String? state;
  String? postalCode;
  String? country;
  int? guest;
  int? bedrooms;
  int? bathrooms;
  int? propertyArea;
  int? propertyBuildArea;
  int? propertyPlotArea;
  List<String>? utilities;
  List<String?>? propertyPhotos;
  String? propertyDescription;
  String? preferedCurrency;
  String? amount;
  String? propertyListingType;
  String? additionalInfo;
  String? userid;
  List<String>? likes;
  List<String>? propertyFeature;
  Timestamp? datePosted;
  String? postFeature;
  String? rentType;
  String? rentSubType;
  String? rentalPeriod;

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
      this.additionalInfo,
      this.userid,
      this.likes,
      this.propertyFeature,
      this.country,
      this.datePosted,
      this.postFeature,
      this.rentType,
      this.rentSubType,
      this.rentalPeriod
      }  );

  PostModel.fromJson(Map<String, dynamic> json) {
    propertyType = json['propertyType'];
    propertyPortion = json['propertyPortion'];
    latLong = _convertToGeoPoint(json['latLong']);
    propertyOwnerNumber = json['propertyOwnerNumber'];
    propertyAddressLine1 = json['propertyAddressLine1'];
    propertyAddressLine2 = json['propertyAddressLine2'];
    city = json['city'];
    state = json['state'];
    country = json['country'];
    postalCode = json['postalCode'];
    guest = json['guest'];
    bedrooms = json['bedrooms'];
    bathrooms = json['bathrooms'];
    propertyArea = json['propertyArea'];
    propertyBuildArea = json['propertyBuildArea'];
    propertyPlotArea = json['propertyPlotArea'];
    utilities = json['utilities'].cast<String>();
    propertyPhotos = json['propertyPhotos'].cast<String>();
    propertyDescription = json['propertyDescription'];
    preferedCurrency = json['preferedCurrency'];
    amount = json['amount'];
    propertyListingType = json['propertyListingType'];
    additionalInfo = json['additionalInfo'];
    userid = json['userid'];

    propertyFeature = json['propertyFeature'];
    datePosted = json['datePosted'];
    postFeature = json['postFeature'];
    if (json['likes'] != null) {
      likes = (json['likes'] as List<dynamic>).cast<String>();
    } else {
      likes = json['likes']; // Assign an empty list if 'likes' is null
    }
    rentType = json['rentType'];
    rentSubType = json['rentSubType'];
    rentalPeriod = json['rentalPeriod'];


  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['propertyType'] = propertyType;
    data['propertyPortion'] = propertyPortion;
    data['latLong'] = _convertFromGeoPoint(latLong);
    data['propertyOwnerNumber'] = propertyOwnerNumber;
    data['propertyAddressLine1'] = propertyAddressLine1;
    data['propertyAddressLine2'] = propertyAddressLine2;
    data['city'] = city;
    data['state'] = state;
    data['postalCode'] = postalCode;
    data['guest'] = guest;
    data['bedrooms'] = bedrooms;
    data['bathrooms'] = bathrooms;
    data['country'] = country;
    data['propertyArea'] = propertyArea;
    data['propertyBuildArea'] = propertyBuildArea;
    data['propertyPlotArea'] = propertyPlotArea;
    data['utilities'] = utilities;
    data['propertyPhotos'] = propertyPhotos;
    data['propertyDescription'] = propertyDescription;
    data['preferedCurrency'] = preferedCurrency;
    data['amount'] = amount;
    data['propertyListingType'] = propertyListingType;
    data['additionalInfo'] = additionalInfo;
    data['userid'] = userid;
    data['likes'] = likes;
    data['propertyFeature'] = propertyFeature;
    data['datePosted'] = datePosted;
    data['postFeature'] = postFeature;
    data['rentType'] = rentType;
    data['rentSubType'] = rentSubType;
    data['rentalPeriod'] = rentalPeriod;
    return data;
  }

  GeoPoint? _convertToGeoPoint(dynamic value) {
    if (value != null && value is GeoPoint) {
      return value;
    } else if (value != null && value is Map<String, dynamic>) {
      final double latitude = value['latitude'] ?? 0.0;
      final double longitude = value['longitude'] ?? 0.0;
      return GeoPoint(latitude, longitude);
    }
    return null;
  }

  Map<String, dynamic>? _convertFromGeoPoint(GeoPoint? geoPoint) {
    if (geoPoint != null) {
      return {
        'latitude': geoPoint.latitude,
        'longitude': geoPoint.longitude,
      };
    }
    return null;
  }

  bool isLikedByCurrentUser(String currentUserId) {
    return likes!.contains(currentUserId);
  }
}
