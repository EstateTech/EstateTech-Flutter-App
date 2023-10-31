import 'dart:io';

import 'package:crypto_estate_tech/common/ColorConstants.dart';
import 'package:crypto_estate_tech/common/custom_create_post_header.dart';
import 'package:crypto_estate_tech/common/custom_post_create_bottom.dart';
import 'package:crypto_estate_tech/common/widgetConstants.dart';
import 'package:crypto_estate_tech/model/postModel.dart';
import 'package:crypto_estate_tech/screens/bottomNavigation/profile/AddPropertyScreens/rentalTypeScreen.dart';
import 'package:crypto_estate_tech/screens/walkthroughScreens/walkthroughPostScreen2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pinput/pinput.dart';

class CounterItem {
  String title;
  int counter;

  CounterItem({required this.title, required this.counter});
}

class FeatureScreen extends StatefulWidget {
  const FeatureScreen(
      {super.key, required this.postModel, required this.isEdited});

  final PostModel postModel;
  final bool isEdited;

  @override
  State<FeatureScreen> createState() => _FeatureScreenState();
}

class _FeatureScreenState extends State<FeatureScreen> {
  List<CounterItem> counterItems = [
    CounterItem(title: 'Guests', counter: 2),
    CounterItem(title: 'Bedrooms', counter: 1),
    CounterItem(title: "Bathrooms", counter: 2),
    CounterItem(title: 'Property surface area(m2)', counter: 120),
    CounterItem(title: 'Built up area(m2)', counter: 120),
    CounterItem(title: 'Plot area(m2)', counter: 120),
  ];
  List<TextEditingController> textControllers = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    for (int i = 0; i < counterItems.length; i++) {
      textControllers.add(TextEditingController());
      textControllers[i].text = counterItems[i].counter.toString();
    }
    print(widget.postModel.guest);

    if (widget.isEdited) {
      textControllers[0].text = widget.postModel.guest!.toString();
      textControllers[1].text = widget.postModel.bedrooms!.toString();
      textControllers[2].text = widget.postModel.bathrooms!.toString();

      textControllers[3].text = widget.postModel.propertyArea!.toString();

      textControllers[4].text = widget.postModel.propertyBuildArea!.toString();
      textControllers[5].text = widget.postModel.propertyPlotArea!.toString();
    }
  }

  void _incrementCounter(int index , int i) {
   
      setState(() {
        index ++;
        textControllers[i].setText(index.toString());
      });
 
  }

  void _decrementCounter(int index , int i) {
    if (index > 0) {
      if (index > 120) {
        setState(() {
         index--;
          textControllers[i].setText(index.toString());
        });
      } else {
        if (index != 120) {
          setState(() {
            index--;
             textControllers[i].setText(index.toString());
          });
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
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
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    const CustomCreatePostHeader(),
                    // SizedBox(
                    //   height: 20.h,
                    // ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Share some basics about your place",
                          style: style.copyWith(
                              fontSize: 25.sp,
                              color: textwalktrough,
                              fontWeight: FontWeight.w600),
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                        Text(
                          "You can add more details later",
                          style: style.copyWith(
                              fontSize: 15.sp,
                              color: textwalktrough,
                              fontWeight: FontWeight.w400),
                        ),
                      ],
                    ),

                    SingleChildScrollView(
                      child: Column(
                        children: counterItems.asMap().entries.map((entry) {
                          int index = entry.key;
                          CounterItem item = entry.value;

                          return FeatureCounterWidget(
                              controller: textControllers[index],
                              onValueChanged: (v) {
                                counterItems[counterItems.indexOf(item)]
                                        .counter ==
                                    int.parse(v);
                                ;
                              },
                              onIcreament: () {
                                print("heelo");
                                print(counterItems.indexOf(item));
                                _incrementCounter(int.parse(textControllers[index].text) , index);

                              },
                              onDecreament: () {
                                print("bye");
                                _decrementCounter(int.parse(textControllers[index].text) , index);
                              },
                              title: item.title,
                              counter: item.counter,
                              paddingToggle:
                                  item.counter >= 120 || item.counter >= 9
                                      ? true
                                      : false);
                        }).toList(),
                      ),
                    ),

                    Padding(
                      padding: EdgeInsets.only(
                          right: 12.h, left: 12.h, bottom: 30.h),
                      child: customPostCreateBottomWidget(
                        OnPressedNextButton: () {
                          widget.postModel.guest = counterItems[0].counter;
                          widget.postModel.bedrooms = counterItems[1].counter;
                          widget.postModel.bathrooms = counterItems[2].counter;
                          widget.postModel.propertyArea =
                              counterItems[3].counter;
                          widget.postModel.propertyBuildArea =
                              counterItems[4].counter;
                          widget.postModel.propertyPlotArea =
                              counterItems[5].counter;

                              print(widget.postModel.toJson());

                          // Navigator.push(
                          //     context,
                          //     MaterialPageRoute(
                          //         builder: (context) => WalkThroughScreenPost2(
                          //               isStep2: true,
                          //               postmodel: widget.postModel,
                          //             )));

                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => RentalTypeScreen(
                                        postModel: widget.postModel,
                                        isEdited : widget.isEdited
                                      )));
                        },
                        OnPressedbackButton: () {
                          print(widget.postModel.toJson());

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

  Widget FeatureCounterWidget(
      {required VoidCallback onIcreament,
      required VoidCallback onDecreament,
      required String title,
      required int counter,
      required ValueChanged<String> onValueChanged,
      bool paddingToggle = false,
      required TextEditingController controller}) {
    return Container(
      height: 55.h,
      margin: EdgeInsets.only(top: 10.h, bottom: 10.h),
      decoration: const BoxDecoration(
          border: Border(bottom: BorderSide(color: textwalktrough))),
      alignment: Alignment.topCenter,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            width: 150.w,
            child: Text(
              title,
              style: style.copyWith(
                  color: textwalktrough,
                  fontSize: 15.sp,
                  fontWeight: FontWeight.w600),
            ),
          ),
          Row(
            children: [
              Container(
                alignment: Alignment.center,
                height: 40.h,
                decoration: BoxDecoration(
                    border: Border.all(color: textwalktrough),
                    shape: BoxShape.circle),
                child: IconButton(
                  padding: EdgeInsets.zero,
                  icon: const Icon(Icons.remove),
                  onPressed: onDecreament,
                ),
              ),
              Container(
                  padding: paddingToggle
                      ? EdgeInsets.symmetric(horizontal: 4.h)
                      : EdgeInsets.symmetric(horizontal: 4.h),
                  child: Container(
                    width: 50.w,
                    height: 50.h,
                    child: TextFormField(
                      controller: controller,
                      textAlign: TextAlign.center,
                      decoration: InputDecoration(
                          fillColor: Colors.purple, focusColor: Colors.purple),
                      keyboardType: Platform.isIOS
                          ? TextInputType.numberWithOptions(
                              signed: true, decimal: true)
                          : TextInputType.number,
                      onChanged: onValueChanged,
                      onFieldSubmitted: (value) {
                        print("object");
                      },
                    ),
                  )),

              //      Text(
              //   counter.toString(),
              //   style: style.copyWith(fontSize: 20.sp, color: textwalktrough),
              // ),
              Container(
                alignment: Alignment.center,
                height: 40.h,
                decoration: BoxDecoration(
                    border: Border.all(color: textwalktrough),
                    shape: BoxShape.circle),
                child: IconButton(
                  padding: EdgeInsets.zero,
                  icon: const Icon(Icons.add),
                  onPressed: onIcreament,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
