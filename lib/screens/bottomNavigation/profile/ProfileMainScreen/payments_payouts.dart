import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../common/ColorConstants.dart';
import '../../../../common/widgetConstants.dart';

class PaymentsAndPayouts extends StatefulWidget {
  const PaymentsAndPayouts({super.key});

  @override
  State<PaymentsAndPayouts> createState() => _PaymentsAndPayoutsState();
}

class _PaymentsAndPayoutsState extends State<PaymentsAndPayouts> {
  String? selectedValue;
  final List<Map> _list = [
    {
      'id': '1',
      'image':
          'https://firebasestorage.googleapis.com/v0/b/crypto-estate-tech---app.appspot.com/o/icons8-tether-48.png?alt=media&token=1fa5fc33-523c-4c5e-8ab7-fb0ae97c7c09&_gl=1*1tkq80h*_ga*MzQ5NzczNzQxLjE2OTUzMTUzOTU.*_ga_CW55HF8NVT*MTY5ODIyODkwNS4xMDQuMS4xNjk4MjI5OTE4LjE5LjAuMA..',
      'name': 'Usdt'
    },
    {
      'id': '2',
      'image':
          'https://firebasestorage.googleapis.com/v0/b/grocers-c9010.appspot.com/o/cryptocoins%2Fbtc.png?alt=media&token=2f5df3fc-48ae-476c-89ec-90afecd907fe',
      'name': 'Btc'
    },
    {
      'id': '3',
      'image':
          'https://firebasestorage.googleapis.com/v0/b/grocers-c9010.appspot.com/o/cryptocoins%2Feth.png?alt=media&token=2f5df3fc-48ae-476c-89ec-90afecd907fe',
      'name': 'Eth'
    },
    {
      'id': '4',
      'image':
          'https://firebasestorage.googleapis.com/v0/b/grocers-c9010.appspot.com/o/cryptocoins%2Fxrp.png?alt=media&token=2f5df3fc-48ae-476c-89ec-90afecd907fe',
      'name': 'Ripple'
    },
    {
      'id': '5',
      'image':
          'https://firebasestorage.googleapis.com/v0/b/grocers-c9010.appspot.com/o/cryptocoins%2Fbnb.png?alt=media&token=2f5df3fc-48ae-476c-89ec-90afecd907fe',
      'name': 'Bnb'
    },
    {
      'id': '6',
      'image':
          'https://upload.wikimedia.org/wikipedia/commons/thumb/4/49/A_black_image.jpg/640px-A_black_image.jpg',
      'name': 'CET'
    },
    {
      'id': '7',
      'image':
          'https://upload.wikimedia.org/wikipedia/commons/thumb/4/49/A_black_image.jpg/640px-A_black_image.jpg',
      'name': 'GUDS'
    },
    {
      'id': '8',
      'image':
          'https://upload.wikimedia.org/wikipedia/commons/thumb/4/49/A_black_image.jpg/640px-A_black_image.jpg',
      'name': 'VEGA'
    },
    {
      'id': '9',
      'image':
          'https://upload.wikimedia.org/wikipedia/commons/thumb/4/49/A_black_image.jpg/640px-A_black_image.jpg',
      'name': 'GATO'
    }
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(left: 20.h, right: 20.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 70.h,
            ),
            GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Icon(
                Icons.arrow_back,
                size: 40.h,
                color: Colors.black54,
              ),
            ),
            SizedBox(
              height: 20.h,
            ),
            Padding(
              padding: EdgeInsets.only(left: 10.h),
              child: Text(
                "Payments And Payouts",
                style: style.copyWith(
                    fontSize: 25.sp,
                    color: Shade2purple,
                    fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(
              height: 20.h,
            ),
            Text(
              "Choose the currencies in which you would like to make your payments or receive your payouts.",
              style: style2.copyWith(color: Shade2purple, fontSize: 18.sp),
            ),
            SizedBox(
              height: 40.h,
            ),
            Container(
              width: MediaQuery.of(context)
                  .size
                  .width, // Set the width of the dropdown as needed
              decoration: BoxDecoration(
                borderRadius:
                    BorderRadius.circular(10), // Adjust border radius as needed
                border: Border.all(
                  color: Colors.black, // Border color
                  width: 0.5, // Border width
                ),
              ),

              child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: DropdownButtonHideUnderline(
                    child: ButtonTheme(
                      alignedDropdown: true,
                      child: DropdownButton(
                        hint: const Text("Select currency"),
                        value: selectedValue,
                        onChanged: (newValue) {
                          setState(() {
                            selectedValue = newValue! as String?;
                          });
                        },
                        items: _list.map((bankItem) {
                          return DropdownMenuItem(
                            value: bankItem['name'],
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                children: [
                                  CachedNetworkImage(
                                    imageUrl: bankItem['image'],
                                  ),
                                  Container(
                                    margin: const EdgeInsets.only(left: 10),
                                    child: Text(bankItem['name']),
                                  )
                                ],
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                  )),
            )
          ],
        ),
      ),
    );
  }
}
