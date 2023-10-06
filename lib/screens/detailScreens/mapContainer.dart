import 'dart:async';

import 'package:crypto_estate_tech/common/ColorConstants.dart';
import 'package:crypto_estate_tech/common/widgetConstants.dart';
import 'package:crypto_estate_tech/provider/postImagesProvider.dart';
import 'package:crypto_estate_tech/screens/detailScreens/Dialogs/dialogMortgage.dart';
import 'package:flutter/material.dart';
import 'package:crypto_estate_tech/model/postModel.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

class MapContainer extends StatefulWidget {
  final PostModel postModel;
  const MapContainer({super.key, required this.postModel});

  @override
  State<MapContainer> createState() => _MapContainerState();
}

class _MapContainerState extends State<MapContainer> {
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();

  LatLng _latLng = const LatLng(37.43296265331129, -122.08832357078792);
  LatLng demylatLng = const LatLng(37.43296265331129, -122.08832357078792);
  CameraPosition _kGooglePlex = const CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );

  _setMarker() {
    return Marker(
        markerId: const MarkerId("marker_1"),
        icon: BitmapDescriptor.defaultMarker,
        position: _latLng);
  }

  Future<bool> _handleLocationPermission() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      await Geolocator.openLocationSettings();
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
              'Location services are disabled. Please enable the services')));
      return false;
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Location permissions are denied')));
        return false;
      }
    }
    if (permission == LocationPermission.deniedForever) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
              'Location permissions are permanently denied, we cannot request permissions.')));
      return false;
    }
    return true;
  }

  Future<void> _getCurrentPosition() async {
    final hasPermission = await _handleLocationPermission();
    if (!hasPermission) return;

    print("the latitude is ${widget.postModel.latLong!.latitude}");

    setState(() {
      _latLng = LatLng(widget.postModel.latLong!.latitude,
          widget.postModel.latLong!.longitude);
      _kGooglePlex = CameraPosition(target: _latLng, zoom: 14.4746);
    });
    _kGooglePlex = CameraPosition(target: _latLng, zoom: 14.4746);

    await Future.delayed(const Duration(seconds: 1));
    final GoogleMapController controller = await _controller.future;
    setState(() {
      controller.animateCamera(CameraUpdate.newCameraPosition(_kGooglePlex));
    });

    // ... rest of your code
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getCurrentPosition();
  }

  @override
  Widget build(BuildContext context) {
    final fileProvider = Provider.of<XFileProvider>(context, listen: true);
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 450.h,
      padding: EdgeInsets.only(left: 20.h, right: 20.h),
      child: Column(
        children: [
          Text(
            "Map",
            style: style.copyWith(color: Shade2purple, fontSize: 20.sp),
          ),
          SizedBox(height: 10.h),
          Container(
            height: 170.h,
            decoration: BoxDecoration(
                border: Border.all(color: Colors.black, width: 1.0),
                borderRadius: BorderRadius.circular(20.r)),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20.r),
              child: GoogleMap(
                mapType: MapType.normal,
                initialCameraPosition: _kGooglePlex,
                markers: <Marker>{_setMarker()},
                onMapCreated: (GoogleMapController controller) {
                  _controller.complete(controller);
                },
              ),
            ),
          ),
          SizedBox(
            height: 10.h,
          ),
          Text(
            "Price Comparsions",
            style: style.copyWith(color: Shade2purple, fontSize: 18.sp),
          ),
          SizedBox(
            height: 10.h,
          ),
          Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: PriceContainers(
                      text: "${fileProvider.currency} 300,000",
                    ),
                  ),
                  SizedBox(
                    width: 10.h,
                  ),
                  const Expanded(
                    child: PriceContainers(text: "24 BTC"),
                  )
                ],
              ),
              SizedBox(
                height: 10.h,
              ),
              Row(
                children: [
                  const Expanded(
                    child: PriceContainers(text: "80,000 GUSD"),
                  ),
                  SizedBox(
                    width: 10.h,
                  ),
                  const Expanded(
                    child: PriceContainers(text: "450,000 CET"),
                  )
                ],
              )
            ],
          ),
          SizedBox(
            height: 20.h,
          ),
          GestureDetector(
            onTap: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return const MortgageDialog(); // Your custom dialog content
                },
              );
            },
            child: Container(
              width: double.infinity,
              height: 55.h,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  color: Shade2purple,
                  borderRadius: BorderRadius.circular(25.r),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5), // Shadow color
                      spreadRadius: 2, // Spread radius
                      blurRadius: 5, // Blur radius
                      offset: const Offset(0, 3), // Offset in x and y direction
                    ),
                  ]),
              child: Text(
                "Mortgage Calculator",
                style: style.copyWith(color: Colors.white, fontSize: 18.sp),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class PriceContainers extends StatelessWidget {
  final String text;

  const PriceContainers({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50.h,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.r),
          border: Border.all(color: Shade2purple)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            text,
            style: style.copyWith(color: Shade2purple, fontSize: 18.sp),
          )
        ],
      ),
    );
  }
}
