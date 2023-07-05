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

class HomeViews {
  List<String> homeimages;
  HomeViews({
    required this.homeimages,
  });
}

List<HomeViews> listhomeviews = [
  HomeViews(homeimages: [
    "https://images.unsplash.com/photo-1615915613497-0ee591aa2fe6?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1100&q=80",
    "https://images.unsplash.com/photo-1580587771525-78b9dba3b914?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=774&q=80",
    "https://images.unsplash.com/photo-1613685703237-6628de38ddb7?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MTZ8fGJlZCUyMHJvb218ZW58MHx8MHx8&auto=format&fit=crop&w=600&q=60",
    "https://images.unsplash.com/photo-1570129477492-45c003edd2be?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8M3x8aG91c2V8ZW58MHx8MHx8&auto=format&fit=crop&w=600&q=60"
  ]),
  HomeViews(homeimages: [
    "https://images.unsplash.com/photo-1522050212171-61b01dd24579?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=580&q=80",
    "https://images.unsplash.com/photo-1595526051245-4506e0005bd0?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8M3x8YmVkJTIwcm9vbXxlbnwwfHwwfHw%3D&auto=format&fit=crop&w=600&q=60",
    "https://images.unsplash.com/photo-1613685703237-6628de38ddb7?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MTZ8fGJlZCUyMHJvb218ZW58MHx8MHx8&auto=format&fit=crop&w=600&q=60"
  ]),
  HomeViews(homeimages: [
    "https://images.unsplash.com/photo-1615915613497-0ee591aa2fe6?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1100&q=80",
    "https://images.unsplash.com/photo-1580587771525-78b9dba3b914?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=774&q=80",
    "https://media.istockphoto.com/id/88620985/photo/exterior-of-modern-house-and-swimming-pool.jpg?s=1024x1024&w=is&k=20&c=fcfN1iIOMcuhlCn-4noOPYXmUo6Td6gp9sn5s2lxtEE=",
    "https://images.unsplash.com/photo-1615552269451-903ecf1f7b9b?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=387&q=80"
  ]),
  HomeViews(homeimages: [
    "https://images.unsplash.com/photo-1522050212171-61b01dd24579?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=580&q=80",
    "https://images.unsplash.com/photo-1595526051245-4506e0005bd0?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8M3x8YmVkJTIwcm9vbXxlbnwwfHwwfHw%3D&auto=format&fit=crop&w=600&q=60",
    "https://images.unsplash.com/photo-1613685703237-6628de38ddb7?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MTZ8fGJlZCUyMHJvb218ZW58MHx8MHx8&auto=format&fit=crop&w=600&q=60"
  ]),
];
