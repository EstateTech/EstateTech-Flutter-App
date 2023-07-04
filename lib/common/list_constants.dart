import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

Map<String, Widget> selectPropertyTypeMap = {
  'House': SvgPicture.asset("assets/images/house_icon.svg"),
  'Appartment': SvgPicture.asset("assets/images/appartment_icon.svg"),
  'Villa': SvgPicture.asset("assets/images/villa_icon.svg"),
  'Flat': SvgPicture.asset("assets/images/flat_icon.svg"),
  'Palace': SvgPicture.asset("assets/images/palace_icon.svg"),
  'Single room': SvgPicture.asset("assets/images/single_room_icon.svg"),

  // Add more key-value pairs as needed
};

Map<String, Widget> selectPropertyFeaturesMap = {
  'Wifi': SvgPicture.asset("assets/images/wifi_icon.svg"),
  'Television': SvgPicture.asset("assets/images/tv_icon.svg"),
  'Kitchen': SvgPicture.asset("assets/images/kitchen_icon.svg"),
  'Washer': SvgPicture.asset("assets/images/washer_icon.svg"),
  'Free parking': SvgPicture.asset("assets/images/car_icon.svg"),
  'Paying parking': SvgPicture.asset("assets/images/paying_parking_icon.svg"),
  'Air conditioning': SvgPicture.asset("assets/images/ac_icon.svg"),
  'Workspace': SvgPicture.asset("assets/images/workspace_icon.svg"),

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
