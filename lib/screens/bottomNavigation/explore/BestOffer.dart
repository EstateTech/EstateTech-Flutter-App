// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:crypto_estate_tech/screens/bottomNavigation/explore/postdisplaywidgets/gridViewDisplay.dart';
import 'package:crypto_estate_tech/screens/bottomNavigation/explore/postdisplaywidgets/listViewDisplay.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:crypto_estate_tech/provider/cryptoProvider.dart';
import 'package:provider/provider.dart';

class BestOffers extends StatefulWidget {
  final String postFeature;
  final int currentViewIndex;
  const BestOffers({
    Key? key,
    required this.postFeature,
    required this.currentViewIndex,
  }) : super(key: key);

  @override
  State<BestOffers> createState() => _BestOffersState();
}

class _BestOffersState extends State<BestOffers> {
  @override
  void initState() {
    super.initState();
    // Fetch the coin markets and ETH price when the widget is initialized
    final cryptoProvider = Provider.of<CryptoProvider>(context, listen: false);

    cryptoProvider.fetchEthPrice();
  }

  FirebaseFirestore firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    //FilterProvider filterProvider = Provider.of<FilterProvider>(context);

    return Column(
      children: [
        SizedBox(
          height: 10.h,
        ),
        widget.currentViewIndex == 0
            ? GridViewWidget(postFeature: widget.postFeature)
            : ListViewWidget(postFeature: widget.postFeature)
      ],
    );
  }
}
