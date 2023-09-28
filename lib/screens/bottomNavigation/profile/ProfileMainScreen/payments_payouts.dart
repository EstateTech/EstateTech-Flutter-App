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
    {'id': '1', 'image': Icons.star, 'name': 'Option 1'},
    {'id': '2', 'image': Icons.abc, 'name': 'Option 2'},
    {'id': '3', 'image': Icons.access_alarm, 'name': 'Option 3'},
    {'id': '4', 'image': Icons.face, 'name': 'Option 4'}
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
                            child: Row(
                              children: [
                                Icon(bankItem['image'] as IconData),
                                Container(
                                  margin: const EdgeInsets.only(left: 10),
                                  child: Text(bankItem['name']),
                                )
                              ],
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
