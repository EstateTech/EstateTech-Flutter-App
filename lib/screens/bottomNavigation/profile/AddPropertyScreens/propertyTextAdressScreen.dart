import 'package:crypto_estate_tech/common/ColorConstants.dart';
import 'package:crypto_estate_tech/common/custom_create_post_header.dart';
import 'package:crypto_estate_tech/common/custom_post_create_bottom.dart';
import 'package:crypto_estate_tech/common/widgetConstants.dart';
import 'package:crypto_estate_tech/screens/bottomNavigation/explore/postdisplaywidgets/postListWidget.dart';

import 'package:crypto_estate_tech/screens/bottomNavigation/profile/AddPropertyScreens/propertyConfirmMapScreen.dart';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../../model/postModel.dart';

class PropertyTextAddressScreen extends StatefulWidget {
  const PropertyTextAddressScreen({
    required this.postModel,
    super.key,
    required this.latLng,
    required this.isEdited,
    required this.Addressline1,
  });

  final PostModel postModel;
  final LatLng latLng;
  final bool isEdited;
  final String Addressline1;

  @override
  State<PropertyTextAddressScreen> createState() =>
      _PropertyTextAddressScreenState();
}

class _PropertyTextAddressScreenState extends State<PropertyTextAddressScreen> {
  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  final List<String> hintTexts = [
    "Address line 1",
    "Address line 2 (if applicable)",
    "Address line 3 (if applicable)",
    "City / Village (if applicable)",
    "State/Province/District (if applicable)",
    "Postal Code (if applicable)",
  ];

  final List<TextEditingController> controllers = List.generate(
    6,
    (index) => TextEditingController(),
  );
  PostModel postModel = PostModel();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    

    controllers[1].text = widget.Addressline1;
    postModel = widget.postModel;

    if (widget.isEdited) {
      controllers[0].text = postModel.propertyAddressLine1!;

      controllers[3].text = postModel.city!;
      controllers[4].text = postModel.state!;
      controllers[5].text = postModel.postalCode!;
    }
  }

  @override
  Widget build(BuildContext context) {
   
   print("the initially asigned modeled is  ${postModel.toJson().toString()}");
    return GestureDetector(
      onTap: (() {
        FocusScope.of(context).unfocus();
      }),
      child: Scaffold(
        body: Container(
          padding: EdgeInsets.only(left: 20.h, right: 20.h, top: 25.h),
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          decoration: const BoxDecoration(gradient: appBackgroundGradient),
          child: CustomScrollView(
            slivers: [
              SliverFillRemaining(
                hasScrollBody: false,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    SizedBox(
                      height: 5.h,
                    ),
                    const CustomCreatePostHeader(),
                    Column(
                      children: [
                        Text(
                          "Confirm is the address of your property",
                          style: style.copyWith(
                              fontSize: 25.sp,
                              color: textwalktrough,
                              fontWeight: FontWeight.w600),
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                        Text(
                          "Your address is only shared with users after they’ve made a reservation",
                          style: style.copyWith(
                              fontSize: 15.sp,
                              color: textwalktrough,
                              fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                    AddressInTextFields(),
                    Padding(
                      padding: EdgeInsets.only(
                          right: 12.h, left: 12.h, bottom: 30.h),
                      child: customPostCreateBottomWidget(
                        OnPressedNextButton: () {
                          if (_key.currentState!.validate()) {
                          postModel.propertyAddressLine1 =
                                controllers[0].text;
                            postModel.propertyAddressLine2 =
                                controllers[1].text;
                             postModel.city = controllers[3].text;
                            postModel.state = controllers[4].text;
                          postModel.postalCode = controllers[5].text;

                            print(postModel.toJson());

                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        PropertyConfirmedMappedScreen(
                                          isEdited: widget.isEdited,
                                          postModel: postModel,
                                          latLng: widget.latLng,
                                        )));
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
            ],
          ),
        ),
      ),
    );
  }

  Widget AddressInTextFields() {
    return Column(
      children: [
        Container(
          height: 50.h,
          margin: EdgeInsets.all(5.h),
          width: MediaQuery.of(context).size.width,
          padding: EdgeInsets.only(left: 24.h, right: 24.h),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15.r),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "United Arab Emirates(+971)",
                style: style.copyWith(color: Colors.black, fontSize: 14.sp),
              ),
              Icon(
                Icons.keyboard_arrow_down_outlined,
                size: 25.h,
              )
            ],
          ),
        ),
        Form(
          key: _key,
          child: SingleChildScrollView(
            child: Column(
              children: List.generate(
                hintTexts.length,
                (index) => CustomWhiteTextField(
                    hintText: hintTexts[index], controller: controllers[index]),
              ),
            ),
          ),
        )
      ],
    );
  }

  Container CustomWhiteTextField(
      {required String hintText, required TextEditingController controller}) {
    return Container(
        height: 50.h,
        margin: EdgeInsets.all(5.h),
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.only(left: 24.h, right: 24.h),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15.r),
        ),
        child: TextFormField(
          style: style.copyWith(fontSize: 15.sp,color: Colors.black),
          controller: controller,
          validator: (v) {
            if (v!.isEmpty) {
              return 'field shouldn\'t be empty';
            }
            return null;
          },
          decoration: InputDecoration(
           
            hintText: hintText,
            hintStyle: style.copyWith(color: textwalktrough, fontSize: 14.sp),
            border: InputBorder.none,
          ),
        ));
  }
}
