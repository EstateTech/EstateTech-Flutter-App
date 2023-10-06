import 'package:crypto_estate_tech/common/ColorConstants.dart';
import 'package:crypto_estate_tech/common/list_constants.dart';
import 'package:crypto_estate_tech/common/widgetConstants.dart';
import 'package:crypto_estate_tech/provider/filterProvider.dart';
import 'package:crypto_estate_tech/screens/bottomNavigation/explore/search_pages/filterWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

class SellScreen extends StatefulWidget {
  const SellScreen({super.key});

  @override
  State<SellScreen> createState() => _SellScreenState();
}

class _SellScreenState extends State<SellScreen> {
    List<bool> isSelectedList =
      List.generate(bestlocations.length, (index) => false);
  bool _isExpanded = false;
  @override
  Widget build(BuildContext context) {
    final filterProvider = Provider.of<FilterProvider>(context, listen: true);
   // filterProvider.updateFilterAppliedField(false);
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                SellOption(() { }, "Offer\nTo Sell"),
                SellOption(() { }, "Offer\nTo Rent"),
                SellOption(() { }, "Short Term\nOptions")
                
      
              ],
            ),
      
                        SizedBox(
                height: 20.h,
              ),
              Padding(
                padding: EdgeInsets.only(left: 15.h,right: 15.h),
                child: LocationExpandableWidget(context)),
              SizedBox(
                height: 20.h,
              ),
              Padding(
                padding: EdgeInsets.only(left: 12.h,right: 12.h),
                child: Container(
                     decoration: BoxDecoration(
                      color: Colors.white,
                        boxShadow: [
                        BoxShadow(
                color: Colors.grey.withOpacity(0.3),
                spreadRadius: 5,
                blurRadius: 7,
                offset: Offset(0, 3), // changes the position of the shadow
                        ),
                      ],
                        borderRadius: BorderRadius.circular(10.r)),
              
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(25.r),
                        child: ExpansionTile(
                          backgroundColor: Colors.white,
                          title: Text(
                            "Customized search",
                            style: style.copyWith(
                                color: Shade2purple,
                                fontSize: 18.sp,
                                fontWeight: FontWeight.w700),
                          ),
                          // childrenPadding: EdgeInsets.zero,
                          trailing: SizedBox.shrink(),
                          onExpansionChanged: (value) {
                            setState(() {
                              _isExpanded = value;
                            });
                          },
              
                          children: <Widget>[
                            FilterWidget(),
                          ],
                        ))),
              ),
              SizedBox(
                height: 20.h,
              ),
              GestureDetector(
                onTap: () {
                  filterProvider.updateFilterAppliedField(false);
                  Navigator.pop(context);
                },
                child: Padding(
                  padding: EdgeInsets.only(left: 15.h,right: 15.h),
                  child: Container(
                                       decoration: BoxDecoration(
                        color: Colors.white,
                          boxShadow: [
                          BoxShadow(
                  color: Colors.grey.withOpacity(0.3),
                  spreadRadius: 5,
                  blurRadius: 7,
                  offset: Offset(0, 3), // changes the position of the shadow
                          ),
                        ],
                          borderRadius: BorderRadius.circular(10.r)),
                
                      width: double.infinity,
                      height: 55.h,
                      alignment: Alignment.centerLeft,
                      padding: EdgeInsets.only(left: 20.w),
                     
                      child: ClipRRect(
                          borderRadius: BorderRadius.circular(25.r),
                          child: Text(
                            "All",
                            textAlign: TextAlign.left,
                            style: style.copyWith(
                                color: Shade2purple,
                                fontSize: 18.sp,
                                fontWeight: FontWeight.w700),
                          ))),
                ),
              )
          ],
        ),
      ),
    );
  }


  Container LocationExpandableWidget(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
          boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.4),
            spreadRadius: 5,
            blurRadius: 7,
            offset: Offset(0, 3), // changes the position of the shadow
          ),
        ],
          borderRadius: BorderRadius.circular(10.r)),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10.r),
        child: ExpansionTile(
          backgroundColor: Colors.white,
          title: Text(
            "Locations",
            style: style.copyWith(
                color: Shade2purple,
                fontSize: 18.sp,
                fontWeight: FontWeight.w600),
          ),
          // childrenPadding: EdgeInsets.zero,
          trailing: SizedBox.shrink(),
          onExpansionChanged: (value) {
            setState(() {
              _isExpanded = value;
            });
          },
          children: <Widget>[
            Container(
              height: 250.h,
              width: MediaQuery.of(context).size.width,
              margin: EdgeInsets.only(top: 10.0),
              padding: EdgeInsets.only(left: 15.h),
              decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(15.r)),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 10.h,
                    ),
                    Container(
                      height: 50.h,
                      width: MediaQuery.of(context).size.width,
                      margin: EdgeInsets.only(right: 15.h),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.r),
                          border: Border.all(color: Colors.black)),
                      child: TextField(
                        keyboardType: TextInputType.text,
                        cursorColor: Colors.black,
                        decoration: InputDecoration(
                          prefixIcon: Icon(
                            Icons.search,
                            color: Colors.black,
                          ),
                          hintText: "Find locations in Dubai",
                          hintStyle: style.copyWith(
                              fontSize: 15.sp, color: textwalktrough),
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    SizedBox(height: 17.h),

                    Container(
                      height: 150.h,
                      child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: bestlocations.length,
                          itemBuilder: (BuildContext context, int index) {
                            return GestureDetector(
                              onTap: () {
                                setState(() {
                                  isSelectedList[index] =
                                      !isSelectedList[index];
                                });
                              },
                              child: LocationWidget(bestlocations[index].images,
                                  bestlocations[index].name, index),
                            );
                          }),
                    )

                    // LocationWidget(),
                  ]),
            )
          ],
        ),
      ),
    );
  }

  Widget LocationWidget(String imageurl, String placename, int index) {
    return Column(
      children: [
        Stack(
          children: [
            Container(
              width: 100.w,
              height: 110.h,
              margin: EdgeInsets.all(8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15.r),
                image: DecorationImage(
                    image: NetworkImage(imageurl), fit: BoxFit.cover),
              ),
            ),
            isSelectedList[index]
                ? Container(
                    width: 100.w,
                    height: 110.h,
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.6),
                      borderRadius: BorderRadius.circular(15.r),
                    ),
                    child: SvgPicture.asset("assets/images/check_icon.svg"),
                  )
                : SizedBox.shrink()
          ],
        ),
        Text(
          placename,
          style: style.copyWith(
              fontSize: 15.sp,
              color: Shade2purple,
              fontWeight: FontWeight.bold),
        )
      ],
    );
  }
}




Widget SellOption(VoidCallback onTap, String text) {
  return GestureDetector(
    onTap: onTap,
    child: Container(
      height: 70.h,
      alignment: Alignment.center,
      margin: EdgeInsets.only(top: 20.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.4),
            spreadRadius: 5,
            blurRadius: 7,
            offset: Offset(0, 3), // changes the position of the shadow
          ),
        ],
      ),
      child: Padding(
        padding:
            EdgeInsets.only(left:20.h, right: 20.h, top: 10.h, bottom: 10.h),
        child: Text(
          text,
          textAlign: TextAlign.center,
          style: style.copyWith(fontSize: 18.sp, color: Shade2purple),
        ),
      ),
    ),
  );
}