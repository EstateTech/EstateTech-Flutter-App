import 'package:crypto_estate_tech/common/ColorConstants.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Container(
      height: size.height,
      width: size.width,
      decoration: BoxDecoration(color: Colors.purple),
      child: Column(
        children: [
          ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, walkThroughPostScreenRoute);
              },
              child: Text("Upload Property"))
        ],
      ),
    );
  }
}
