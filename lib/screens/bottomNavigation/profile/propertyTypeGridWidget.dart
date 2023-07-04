// import 'package:crypto_estate_tech/common/widgetConstants.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';

// import '../../../common/ColorConstants.dart';
// import '../../../components/grid_item_widet.dart';

// class PropertyTypeGridWidget extends StatefulWidget {
//   final Map<String, Widget> widgetMap;
//   final Function() onPressed;
//   final String selectedText;
//   const PropertyTypeGridWidget(
//       {super.key,
//       required this.widgetMap,
//       required this.onPressed,
//       required this.selectedText});

//   @override
//   State<PropertyTypeGridWidget> createState() => _PropertyTypeGridWidgetState();
// }

// class _PropertyTypeGridWidgetState extends State<PropertyTypeGridWidget> {
//   @override
//   Widget build(BuildContext context) {
//     return GridView.builder(
//       padding: EdgeInsets.zero,
//       gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//         crossAxisCount: 2,
//         childAspectRatio: 1.4,
//       ),
//       itemCount: widget.widgetMap.length,
//       itemBuilder: (BuildContext context, int index) {
//         return GestureDetector(
//           onTap: widget.onPressed,
//           child: GridItemWidget(
//               selectedText: widget.selectedText,
//               icon: widget.widgetMap.values.elementAt(index),
//               text: widget.widgetMap.keys.elementAt(index)),
//         );
//       },
//     );
//   }
//}
