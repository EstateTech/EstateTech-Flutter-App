import 'package:crypto_estate_tech/common/ColorConstants.dart';
import 'package:crypto_estate_tech/common/custom_create_post_header.dart';
import 'package:crypto_estate_tech/common/custom_post_create_bottom.dart';
import 'package:crypto_estate_tech/common/widgetConstants.dart';
import 'package:crypto_estate_tech/model/postModel.dart';
import 'package:crypto_estate_tech/screens/bottomNavigation/profile/AddPropertyScreens/additionalinfoScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class WalkthroughStep3 extends StatefulWidget {
  const WalkthroughStep3({super.key, required this.postModel, required this.isEdited});

  final PostModel postModel;
  final bool isEdited;

  @override
  State<WalkthroughStep3> createState() => _WalkthroughStep3State();
}

class _WalkthroughStep3State extends State<WalkthroughStep3> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        height: size.height,
        width: size.width,
        padding: EdgeInsets.only(top: 50.h, left: 20.h),
        decoration: const BoxDecoration(
          gradient: appBackgroundGradient,
        ),
        child: CustomScrollView(
          slivers: [
            
            SliverFillRemaining(
              hasScrollBody: false,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  const CustomCreatePostHeader(),
                  Text(
                    "Finish up and publish",
                    style: style.copyWith(
                        fontSize: 30.sp,
                        color: textwalktrough,
                        fontWeight: FontWeight.w600),
                  ),
                  Center(
                    child: Container(
                      height: 250.h,
                      width: 250.h,
                      decoration: const BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage("assets/images/living_room3.png"),
                              fit: BoxFit.contain)),
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Step 3",
                        style: style.copyWith(color: textwalktrough),
                      ),
                      Text(
                        "Tell us about your property",
                        style: style.copyWith(
                            color: textwalktrough,
                            fontSize: 18.sp,
                            fontWeight: FontWeight.w700),
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      SizedBox(
                        height: 150.h,
                        width: 300.h,
                        child: Text(
                          "Finally, you’ll chose whether you’d like to start with an experienced guest, then you’ll set your price and currency. Answer a few questions and publish when you’re ready.",
                          style:
                              style.copyWith(color: textwalktrough, fontSize: 18.sp),
                        ),
                      ),
                      Padding(
                        padding:
                            EdgeInsets.only(right: 12.h, left: 12.h, bottom: 30.h),
                        child: customPostCreateBottomWidget(
                          OnPressedNextButton: () {
                            // Navigator.pushNamed(context, additionalInfoScreen);
            
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => AdditionalInfoScreen(
                                        postModel: widget.postModel, 
                                        isEdited: widget.isEdited,
                                        
                                        
                                        
                                        )));
                          },
                          OnPressedbackButton: () {
                            Navigator.pop(context);
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
