import 'package:crypto_estate_tech/common/ColorConstants.dart';
import 'package:crypto_estate_tech/common/custom_create_post_header.dart';
import 'package:crypto_estate_tech/common/custom_post_create_bottom.dart';
import 'package:crypto_estate_tech/common/widgetConstants.dart';
import 'package:crypto_estate_tech/model/postModel.dart';
import 'package:crypto_estate_tech/screens/walkthroughScreens/walkthroughPostScreen2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CounterItem {
  String title;
  int counter;

  CounterItem({required this.title, required this.counter});
}

class FeatureScreen extends StatefulWidget {
  const FeatureScreen({super.key, required this.postModel});

  final PostModel postModel;

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

  void _incrementCounter(int index) {
    setState(() {
      setState(() {
        counterItems[index].counter++;
      });
    });
  }

  void _decrementCounter(int index) {
    if (counterItems[index].counter > 0) {
      if (counterItems[index].counter > 120) {
        setState(() {
          counterItems[index].counter--;
        });
      } else {
        if (counterItems[index].counter != 120) {
          setState(() {
            counterItems[index].counter--;
          });
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.only(left: 20.h, right: 20.h, top: 25.h),
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: const BoxDecoration(gradient: appBackgroundGradient),
        child: SingleChildScrollView(
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
                  children: counterItems.map((item) {
                    return FeatureCounterWidget(
                        onValueChanged: (v) {
                          counterItems[counterItems.indexOf(item)].counter ==
                              int.parse(v);
                          ;
                        },
                        onIcreament: () {
                          _incrementCounter(counterItems.indexOf(item));
                        },
                        onDecreament: () {
                          _decrementCounter(counterItems.indexOf(item));
                        },
                        title: item.title,
                        counter: item.counter,
                        paddingToggle: item.counter >= 120 || item.counter >= 9
                            ? true
                            : false);
                  }).toList(),
                ),
              ),

              Padding(
                padding: EdgeInsets.only(right: 12.h, left: 12.h, bottom: 30.h),
                child: customPostCreateBottomWidget(
                  OnPressedNextButton: () {
                    widget.postModel.guest = counterItems[0].counter;
                    widget.postModel.bedrooms = counterItems[1].counter;
                    widget.postModel.bathrooms = counterItems[2].counter;
                    widget.postModel.propertyArea = counterItems[3].counter;
                    widget.postModel.propertyBuildArea =
                        counterItems[4].counter;
                    widget.postModel.propertyPlotArea = counterItems[5].counter;

                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => WalkThroughScreenPost2(
                                  isStep2: true,
                                  postmodel: widget.postModel,
                                )));
                  },
                  OnPressedbackButton: () {
                    print(widget.postModel.toJson());
                    //  Navigator.pop(context);
                  },
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
      bool paddingToggle = false}) {
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
                      controller: TextEditingController(
                        text: counter.toString(),
                      ),
                      textAlign: TextAlign.center,
                      decoration: InputDecoration(
                          fillColor: Colors.purple, focusColor: Colors.purple),
                      keyboardType: TextInputType.number,
                      onChanged: onValueChanged,
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
