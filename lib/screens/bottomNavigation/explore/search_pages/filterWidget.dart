import 'package:crypto_estate_tech/provider/filterProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FilterWidget extends StatefulWidget {
  final bool isPeriodTimeRequired;
  final String OptionSelected;
  const FilterWidget(
      {super.key,
      required this.isPeriodTimeRequired,
      this.OptionSelected = ""});

  @override
  State<FilterWidget> createState() => _FilterWidgetState();
}

class _FilterWidgetState extends State<FilterWidget> {
  List<String> colors = [
    'House',
    'Appartment',
    'Villa',
    'Flat',
    'Palace',
    'Single room'
  ];
  List<int> bedrooms = [1, 2, 3, 4, 5];
  List<int> bathrooms = [1, 2, 3, 4, 5, 6];
  List<String> periods = ['Yearly', 'Monthly', 'Weekly'];

  @override
  Widget build(BuildContext context) {
    final filterProvider = Provider.of<FilterProvider>(context);
    String selectedColor = filterProvider.propertyType ?? 'House';
    int selectedBedroom = filterProvider.bedrooms ?? -1;
    int selectedBathroom = filterProvider.bathrooms ?? -1;
    String selectedPeriod = filterProvider.period ?? "";
    double minPrice = 420;
    double maxPrice = 135500;
    return Container(
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DropdownButton<String>(
              value: selectedColor,
              hint: Text('Select a color'),
              onChanged: (newValue) {
                setState(() {
                  selectedColor = newValue!;
                });
                filterProvider.updatePropertyType(newValue);
              },
              items: colors.map((color) {
                return DropdownMenuItem<String>(
                  value: color,
                  child: Text(color),
                );
              }).toList(),
            ),
            SizedBox(height: 20.0),
            Text(
              'Bedrooms:',
              style: TextStyle(fontSize: 16.0),
            ),
            SizedBox(height: 10.0),
            Container(
              height: 50.0,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: bedrooms.length,
                itemBuilder: (context, index) {
                  bool isSelected = selectedBedroom == bedrooms[index];
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedBedroom = bedrooms[index];
                      });
                      filterProvider.updateBedrooms(bedrooms[index]);
                    },
                    child: Container(
                      width: 50.0,
                      height: 50.0,
                      margin: EdgeInsets.only(right: 10.0),
                      decoration: BoxDecoration(
                        color: isSelected ? Colors.purple : Colors.transparent,
                        border: Border.all(
                          color: Colors.grey,
                          width: 1.0,
                        ),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: Center(
                        child: Text(
                          bedrooms[index].toString(),
                          style: TextStyle(
                            color: isSelected ? Colors.white : Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            SizedBox(height: 20.0),
            Text(
              'Bathrooms:',
              style: TextStyle(fontSize: 16.0),
            ),
            SizedBox(height: 10.0),
            Container(
              height: 50.0,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: bathrooms.length,
                itemBuilder: (context, index) {
                  bool isSelected = selectedBathroom == bathrooms[index];
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedBathroom = bathrooms[index];
                      });
                      filterProvider.updateBathrooms(bathrooms[index]);
                    },
                    child: Container(
                      width: 50.0,
                      height: 50.0,
                      margin: EdgeInsets.only(right: 10.0),
                      decoration: BoxDecoration(
                        color: isSelected ? Colors.purple : Colors.transparent,
                        border: Border.all(
                          color: Colors.grey,
                          width: 1.0,
                        ),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: Center(
                        child: Text(
                          bathrooms[index].toString(),
                          style: TextStyle(
                            color: isSelected ? Colors.white : Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            SizedBox(height: 20.0),
            widget.isPeriodTimeRequired
                ? Text(
                    'Period:',
                    style: TextStyle(fontSize: 16.0),
                  )
                : SizedBox.shrink(),
            widget.isPeriodTimeRequired
                ? SizedBox(height: 10.0)
                : SizedBox.shrink(),
            widget.isPeriodTimeRequired
                ? Container(
                    height: 50.0,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: periods.length,
                      itemBuilder: (context, index) {
                        bool isSelected = selectedPeriod == periods[index];
                        bool isEnabled = false; // Initialize as disabled

                        if (widget.OptionSelected == "Long-term") {
                          // Enable yearly and monthly for long-term
                          isEnabled = (periods[index] == "Yearly" ||
                              periods[index] == "Monthly");
                        } else if (widget.OptionSelected == "Short-term") {
                          // Enable weekly for short-term
                          isEnabled = (periods[index] == "Weekly");
                        } else if(widget.OptionSelected == "") {
                          isEnabled = true;
                        }

                        return IgnorePointer(
                          ignoring: !isEnabled,
                          child: GestureDetector(
                            onTap: () {
                              if (isEnabled) {
                                setState(() {
                                  selectedPeriod = periods[index];
                                });

                                print(selectedPeriod);
                                filterProvider.updatePeriod(periods[index]);
                              }
                            },
                            child: Container(
                              width: 100.0,
                              height: 50.0,
                              margin: EdgeInsets.only(right: 10.0),
                              decoration: BoxDecoration(
                                color: widget.OptionSelected == "Long-term" &&
                                        index == 2
                                    ? Colors.grey
                                    : widget.OptionSelected == "Short-term" &&
                                            index == 0
                                        ? Colors.grey
                                        : widget.OptionSelected ==
                                                    "Short-term" &&
                                                index == 1
                                            ? Colors.grey
                                            : isSelected
                                                ? Colors.purple
                                                : Colors.transparent,
                                border: Border.all(
                                  color: Colors.grey,
                                  width: 1.0,
                                ),
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                              child: Center(
                                child: Text(
                                  periods[index],
                                  style: TextStyle(
                                    color:
                                        widget.OptionSelected == "Long-term" &&
                                                index == 2
                                            ? Colors.black
                                            : widget.OptionSelected ==
                                                        "Short-term" &&
                                                    index == 0
                                                ? Colors.black
                                                : widget.OptionSelected ==
                                                            "Short-term" &&
                                                        index == 1
                                                    ? Colors.black
                                                    : isSelected
                                                        ? Colors.white
                                                        : Colors.black,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  )
                : SizedBox.shrink(),
            SizedBox(height: 20.0),
            Text(
              'Price Range:',
              style: TextStyle(fontSize: 16.0),
            ),
            SizedBox(height: 10.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '\$${minPrice.toStringAsFixed(2)}',
                  style: TextStyle(fontSize: 16.0),
                ),
                Text(
                  '\$${maxPrice.toStringAsFixed(2)}',
                  style: TextStyle(fontSize: 16.0),
                ),
              ],
            ),
            RangeSlider(
              values: RangeValues(minPrice, maxPrice),
              min: 420,
              max: 135500,
              divisions: 100,
              activeColor: Colors.purple,
              inactiveColor: Colors.grey,
              onChanged: (RangeValues values) {
                setState(() {
                  minPrice = values.start;
                  maxPrice = values.end;
                });
                // filterProvider.price = values.start;
              },
            ),
          ],
        ),
      ),
    );
  }
}
