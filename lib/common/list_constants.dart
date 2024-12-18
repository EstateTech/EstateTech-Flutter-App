// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

Map<String, String> selectPropertyTypeMap = {
  'House':"assets/images/house_icon.svg" ,
  'Appartment': "assets/images/appartment_icon.svg",
  'Villa': "assets/images/villa_icon.svg",
  'Flat': "assets/images/flat_icon.svg",
  'Town House': "assets/images/palace_icon.svg",

  // Add more key-value pairs as needed
};

Map<String, String> selectPropertyFeaturesMap = {
  'Wifi': "assets/images/wifi_icon.svg",
  'Television': "assets/images/tv_icon.svg",
  'Kitchen': "assets/images/kitchen_icon.svg",
  'Washer': "assets/images/washer_icon.svg",
  'Free parking': "assets/images/car_icon.svg",
  'Paying parking': "assets/images/paying_parking_icon.svg",
  'Air conditioning': "assets/images/ac_icon.svg",
  'Workspace': "assets/images/workspace_icon.svg",

  // Add more key-value pairs as needed
};

Map<String, Widget> descriptionFeature = {
  'Peaceful': SvgPicture.asset("assets/images/peaceful_icon.svg"),
  'Unique': SvgPicture.asset("assets/images/unique_icon.svg"),
  'Family-friendly': SvgPicture.asset("assets/images/family_icon.svg"),
  'Spacious': SvgPicture.asset("assets/images/spacious_icon.svg"),
  'Stylish': SvgPicture.asset("assets/images/stylish_icon.svg"),
  'Central': SvgPicture.asset("assets/images/central.svg"),

  // Add more key-value pairs as needed
};

class HomeViews {
  String images;
  String name;
  HomeViews({
    required this.images,
    required this.name,
  });
}

List<HomeViews> bestlocations = [
  HomeViews(
      images:
          "https://images.unsplash.com/photo-1511091734515-e50d46c37240?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Mjh8fGR1YmFpJTIwcGxhY2VzfGVufDB8fDB8fHww&auto=format&fit=crop&w=600&q=60",
      name: "Deira"),
  HomeViews(
      images:
          "https://images.unsplash.com/photo-1546412414-e1885259563a?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=387&q=80",
      name: "Burj Khalifa"),
  HomeViews(
      images:
          "https://images.unsplash.com/photo-1610821659180-2501462655f9?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=327&q=80",
      name: "Bur Dubai"),
  HomeViews(
      images:
          "https://images.unsplash.com/photo-1526495124232-a04e1849168c?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=387&q=80",
      name: "Jumeirah"),
  HomeViews(
      images:
          "https://images.unsplash.com/photo-1533395427226-788cee25cc7b?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=388&q=80",
      name: "Dubai Marina")
];






  String RENT = "Rent";
  String LONG_TERM = "Long-term";
  String SHORT_TERM = "Short-term";
  String READY_TO_MOVE = "Ready-to-move";
  String OFF_PLAN = "Off-plan";
  String UNDER_CONSTRUCTION = "Under-construction";
  String OFFER_TO_SELL = "Offer to Sell"; 
  String OFFER_TO_RENT= 'Offer to Rent'; 
  String SHORT_TERM_OPTIONS ="Short Term Options";
  String BUY = "Buy";
  String SELL  = "Sell";

String MONTLY = "Montly"; 
String YEARLY = "Yearly";
 String WEEKLY = "Weekly";