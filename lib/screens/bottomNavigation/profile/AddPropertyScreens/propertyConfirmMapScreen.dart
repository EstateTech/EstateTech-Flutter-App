import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geocode/geocode.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:crypto_estate_tech/common/ColorConstants.dart';
import 'package:crypto_estate_tech/common/custom_create_post_header.dart';
import 'package:crypto_estate_tech/common/custom_post_create_bottom.dart';
import 'package:crypto_estate_tech/screens/bottomNavigation/profile/AddPropertyScreens/featuresScreen.dart';
import 'package:crypto_estate_tech/screens/bottomNavigation/profile/AddPropertyScreens/propertyTextAdressScreen.dart';

import '../../../../common/widgetConstants.dart';
import '../../../../model/postModel.dart';



class PropertyConfirmedMappedScreen extends StatefulWidget {
  

  final PostModel postModel;
  final LatLng latLng;
  const PropertyConfirmedMappedScreen({super.key, required this.postModel , required this.latLng});

  @override
  State<PropertyConfirmedMappedScreen> createState() => _PropertyConfirmedMappedScreenState();
}

class _PropertyConfirmedMappedScreenState extends State<PropertyConfirmedMappedScreen> {

  TextEditingController addressController = TextEditingController();
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();
  bool isLoading = false;
  GeoCode geoCode = GeoCode();

  LatLng _latLng = const LatLng(37.43296265331129, -122.08832357078792);
  CameraPosition _kGooglePlex = const CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );
  Set<Marker> _markers = Set<Marker>();

  _setMarker() {
    return Marker(
        markerId: const MarkerId("marker_1"),
        icon: BitmapDescriptor.defaultMarker,
        position: _latLng);
  }

  @override
  void dispose() {
    // TODO: implement dispose

    super.dispose();
  }

  @override
  void initState() {
    super.initState();
  
        _getCurrentPosition();

   

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
    setState(() {
      isLoading = true;
    });

    final hasPermission = await _handleLocationPermission();
    if (!hasPermission) return;
   

      setState(() {
        _latLng = LatLng(widget.latLng.latitude, widget.latLng.longitude);
        _kGooglePlex = CameraPosition(target: _latLng, zoom: 14.4746);
        // postMdl.getCurrentWeather(position.latitude, position.longitude);
        // postMdl.setUserPostion(position);
      });
      _kGooglePlex = CameraPosition(target: _latLng, zoom: 14.4746);

      await Future.delayed(const Duration(seconds: 1));
      final GoogleMapController controller = await _controller.future;
      Marker newMarker = Marker(
        markerId: MarkerId('selected_location'),
        position: _latLng,
      );
      setState(() {
        isLoading = false;
        _markers.clear();
        _markers.add(newMarker);
        controller.animateCamera(CameraUpdate.newCameraPosition(_kGooglePlex));
      });

     
        await getAddress(_latLng.latitude, _latLng.longitude);
       
       
      
  
  }


  Future getAddress(double latitude, double longitude) async {
    try {
      print("${latitude} , ${longitude}");
      List<Placemark> placemarks =
          await placemarkFromCoordinates(latitude, longitude);

      Placemark place = placemarks[0];

      Marker newMarker = Marker(
        markerId: MarkerId('selected_location'),
        position: LatLng(latitude, longitude),
      );

      //  Address coordinates =
      //  await geoCode.reverseGeocoding(latitude: latitude,longitude: longitude);
      //  print(coordinates.toString());

      setState(() {
        _markers.clear();
        _markers.add(newMarker);
        addressController.text =
            "${place.locality}, ${place.subLocality}, ${place.country}";
        isLoading = false;
      });

      print("===${addressController.text}");
    } catch (e) {
      print("!!!!$e");
    }
  }

  //this method is for the  address  to map location
  Future<void> _updateMapLocation(String address) async {
    try {
      setState(() {
        isLoading = true;
      });

      for (int i = 0; i < 2; i++) {
        Coordinates coordinates =
            await geoCode.forwardGeocoding(address: address);
        print("latitude ${coordinates.latitude}");
        print("longitude ${coordinates.longitude}");

        if (coordinates.latitude != null || coordinates.longitude != null) {
          setState(() {
            _latLng = LatLng(
                coordinates.latitude ?? 0.0, coordinates.longitude ?? 0.0);
            _kGooglePlex = CameraPosition(target: _latLng, zoom: 14.4746);
          });
          _kGooglePlex = CameraPosition(target: _latLng, zoom: 14.4746);

          await Future.delayed(const Duration(seconds: 1));
          final GoogleMapController controller = await _controller.future;
          Marker newMarker = Marker(
            markerId: MarkerId('selected_location'),
            position: LatLng(coordinates.latitude!, coordinates.longitude!),
          );
          setState(() {
            _markers.clear();
            _markers.add(newMarker);
            controller
                .animateCamera(CameraUpdate.newCameraPosition(_kGooglePlex));
          });

          List<Placemark> placemarks = await placemarkFromCoordinates(
              _latLng.latitude, _latLng.longitude);

          Placemark place = placemarks[0];

          setState(() {
            addressController.text =
                "${place.locality}, ${place.subLocality}, ${place.country}";
            isLoading = false;
          });
          break;
        } else {
          _getCurrentPosition();
        }
      }
    } catch (e) {
      print(e);

      // ScaffoldMessenger.of(context).showSnackBar(
      //   SnackBar(
      //     content: Text('Location not found for $address'),
      //   ),
      // );

      setState(() {
        isLoading = false;
      });
    }
  }

  void _onMapTapped(LatLng location) {
    // Create a marker at the tapped location
    Marker newMarker = Marker(
      markerId: MarkerId('selected_location'),
      position: location,
    );

    setState(() {
      // Update the markers set
      _markers.clear();
      _markers.add(newMarker);
    });

    // Reverse geocode the location to get the address
    getAddress(location.latitude, location.longitude);
  }
  @override
  Widget build(BuildContext context) {

        return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        padding: EdgeInsets.only(left: 20.h, right: 20.h),
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        alignment: Alignment.center,
        decoration: const BoxDecoration(gradient: appBackgroundGradient),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const CustomCreatePostHeader(),
            // SizedBox(
            //   height: 20.h,
            // ),
            Text(
             
                  "Is the pin on the right spot?",
                 
              style: style.copyWith(
                  fontSize: 25.sp,
                  color: textwalktrough,
                  fontWeight: FontWeight.w500),
            ),
            SizedBox(
              height: 400.h,
              width: double.infinity,
              child: Stack(
                children: [
                  GoogleMap(
                    myLocationButtonEnabled: false,

                    mapType: MapType.normal,
                    initialCameraPosition: _kGooglePlex,
                    //markers: <Marker>{_setMarker()},
                    markers: _markers,
                    onMapCreated: (GoogleMapController controller) {
                      _controller.complete(controller);
                    },
                    onTap: _onMapTapped,
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
                        controller: addressController,
                        decoration: InputDecoration(
                            hintText: "Enter your address",
                            hintStyle: style.copyWith(
                                color: textwalktrough, fontSize: 15.sp),
                            contentPadding: EdgeInsets.only(top: 4.h),
                            border: InputBorder.none,
                            prefixIcon: const Icon(
                              Icons.location_on,
                              color: Colors.black,
                            )),
                        onSubmitted: (value) {
                          _updateMapLocation(value.toString());
                        },
                      )),
                  //Adjust container

                       Align(
                          alignment: Alignment.bottomRight,
                          child: GestureDetector(
                            onTap: () async {
                              if (_markers.isNotEmpty) {
                                LatLng selectedLocation =
                                    _markers.first.position;
                                final GoogleMapController controller =
                                    await _controller.future;
                                controller.animateCamera(
                                  CameraUpdate.newLatLng(selectedLocation),
                                );
                              }
                            },
                            child: Container(
                              height: 50.h,
                              width: 90.w,
                              margin: EdgeInsets.only(bottom: 5.h, right: 5.h),
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
                     
                ],
              ),

              //  color: Colors.amber,
            ),
            Padding(
              padding: EdgeInsets.only(right: 12.h, left: 12.h, bottom: 30.h),
              child: isLoading
                  ? Container(
                      child: Column(
                        children: [
                          const CircularProgressIndicator(
                            color: Colors.white,
                          ),
                          Text(
                            "Please Wait.... Address is fetching",
                            style: style.copyWith(color: Colors.white),
                          )
                        ],
                      ),
                    )
                  : customPostCreateBottomWidget(
                      OnPressedNextButton: () {
                        if (addressController.text.isNotEmpty) {
                          setState(() {
                            widget.postModel.latLong =
                                GeoPoint(_latLng.latitude, _latLng.longitude);

                            widget.postModel.city =
                                addressController.text.split(',').first;

                            widget.postModel.propertyAddressLine2 =
                                addressController.text;

                            widget.postModel.country =
                                addressController.text.split(',').last;
                          });

                          
                               Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => FeatureScreen(
                                            postModel: widget.postModel,
                                          )));
                             
                        } else {
                          Fluttertoast.showToast(
                              msg: 'Please wait unitl system fetch addreess');
                        }
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