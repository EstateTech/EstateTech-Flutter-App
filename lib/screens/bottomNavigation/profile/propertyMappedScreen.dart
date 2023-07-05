// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crypto_estate_tech/screens/bottomNavigation/profile/featuresScreen.dart';
import 'package:crypto_estate_tech/screens/bottomNavigation/profile/propertyTextAdressScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

import 'package:crypto_estate_tech/common/ColorConstants.dart';
import 'package:crypto_estate_tech/common/custom_create_post_header.dart';
import 'package:crypto_estate_tech/common/custom_post_create_bottom.dart';

import '../../../common/widgetConstants.dart';
import '../../../model/postModel.dart';

class PropertyMappedScreen extends StatefulWidget {
  final bool isConfirmPinScreen;

  final PostModel postModel;

  PropertyMappedScreen({
    Key? key,
    required this.postModel,
    this.isConfirmPinScreen = false,
  }) : super(key: key);

  @override
  State<PropertyMappedScreen> createState() => _PropertyMappedScreenState();
}

class _PropertyMappedScreenState extends State<PropertyMappedScreen> {
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();

  LatLng _latLng = LatLng(37.43296265331129, -122.08832357078792);
  CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );

  _setMarker() {
    return Marker(
        markerId: MarkerId("marker_1"),
        icon: BitmapDescriptor.defaultMarker,
        position: _latLng);
  }

  @override
  void initState() {
    super.initState();
    getCurrentLocation();
  }

  @override
  void dispose() {
    // TODO: implement dispose

    super.dispose();
  }

  void getCurrentLocation() async {
    Location location = new Location();

    bool _serviceEnabled;
    PermissionStatus _permissionGranted;
    LocationData _locationData;

    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    _locationData = await location.getLocation();

    _latLng = LatLng(_locationData.latitude!, _locationData.longitude!);

    _kGooglePlex = CameraPosition(target: _latLng, zoom: 14.4746);

    await Future.delayed(const Duration(seconds: 1));
    final GoogleMapController controller = await _controller.future;
    setState(() {
      controller.animateCamera(CameraUpdate.newCameraPosition(_kGooglePlex));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.only(left: 20.h, right: 20.h),
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(gradient: appBackgroundGradient),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            CustomCreatePostHeader(),
            // SizedBox(
            //   height: 20.h,
            // ),
            Text(
              widget.isConfirmPinScreen
                  ? "Is the pin on the right spot?"
                  : "Where is your property located?",
              style: style.copyWith(
                  fontSize: 25.sp,
                  color: textwalktrough,
                  fontWeight: FontWeight.w500),
            ),
            Container(
              height: 400.h,
              width: double.infinity,
              child: Stack(
                children: [
                  GoogleMap(
                    mapType: MapType.normal,
                    initialCameraPosition: _kGooglePlex,
                    markers: <Marker>{_setMarker()},
                    onMapCreated: (GoogleMapController controller) {
                      _controller.complete(controller);
                    },
                  ),
                  Container(
                      alignment: Alignment.center,
                      margin:
                          EdgeInsets.only(top: 20.h, right: 40.h, left: 40.h),
                      height: 40.h,
                      width: double.infinity,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(color: textwalktrough),
                          borderRadius: BorderRadius.circular(10.r)),
                      child: TextField(
                        decoration: InputDecoration(
                            hintText: "Enter your address",
                            hintStyle: style.copyWith(
                                color: textwalktrough, fontSize: 15.sp),
                            contentPadding: EdgeInsets.only(top: 4.h),
                            border: InputBorder.none,
                            prefixIcon: Icon(
                              Icons.location_on,
                              color: Colors.black,
                            )),
                      )),
                  //Adjust container
                  widget.isConfirmPinScreen
                      ? Align(
                          alignment: Alignment.bottomRight,
                          child: GestureDetector(
                            onTap: () {
                              //implement here
                            },
                            child: Container(
                              height: 50.h,
                              width: 90.w,
                              margin:
                                  EdgeInsets.only(bottom: 10.h, right: 60.h),
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  border: Border.all(color: Shade2purple),
                                  borderRadius: BorderRadius.circular(30.r)),
                              child: Text(
                                "Adjust",
                                style: style.copyWith(
                                    color: Shade2purple,
                                    fontSize: 18.sp,
                                    fontWeight: FontWeight.w600),
                              ),
                            ),
                          ),
                        )
                      : SizedBox.shrink()
                ],
              ),

              //  color: Colors.amber,
            ),
            Padding(
              padding: EdgeInsets.only(right: 12.h, left: 12.h, bottom: 30.h),
              child: customPostCreateBottomWidget(
                OnPressedNextButton: () {
                  setState(() {
                    widget.postModel.latLong =
                        GeoPoint(_latLng.latitude, _latLng.latitude);
                  });

                  widget.isConfirmPinScreen
                      ? Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => FeatureScreen(
                                    postModel: widget.postModel,
                                  )))
                      : Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => PropertyTextAddressScreen(
                                    postModel: widget.postModel,
                                  )));
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
}
