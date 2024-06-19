import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crypto_estate_tech/common/ColorConstants.dart';
import 'package:crypto_estate_tech/helperclass/dataFromFirestore.dart';
import 'package:crypto_estate_tech/notification/notification_screen.dart';
import 'package:crypto_estate_tech/screens/bottomNavigation/profile/AddPropertyScreens/rentalTypeScreen.dart';
import 'package:crypto_estate_tech/screens/bottomNavigation/profile/ProfileMainScreen/NotificationsSettingsScreen.dart';
import 'package:crypto_estate_tech/screens/bottomNavigation/profile/ProfileMainScreen/PersonalInformationScreen.dart';
import 'package:crypto_estate_tech/screens/bottomNavigation/profile/ProfileMainScreen/loginSecurityScreen.dart';
import 'package:crypto_estate_tech/screens/bottomNavigation/profile/ProfileMainScreen/payments_payouts.dart';
import 'package:crypto_estate_tech/screens/bottomNavigation/profile/ProfileMainScreen/profileButton.dart';
import 'package:crypto_estate_tech/screens/bottomNavigation/profile/myPropertyScreen.dart';
import 'package:crypto_estate_tech/screens/bottomNavigation/profile/swap_page_screen.dart';
import 'package:crypto_estate_tech/screens/walkthroughScreens/walkthroughPostScreen2.dart';
import 'package:crypto_estate_tech/screens/detailScreens/services.dart';
import 'package:crypto_estate_tech/screens/detailScreens/policies.dart';
import 'package:crypto_estate_tech/screens/detailScreens/offerScreen.dart';
import 'package:crypto_estate_tech/screens/detailScreens/postOffers.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:crypto_estate_tech/components/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:crypto_estate_tech/provider/walletProvider.dart';
import 'package:crypto_estate_tech/provider/cryptoProvider.dart';
import '../../../common/widgetConstants.dart';
import '../../../model/postModel.dart';
import '../../../model/signupSaveDataFirebase.dart';
import '../../../provider/authProvider.dart';
import 'package:web3modal_flutter/services/w3m_service/w3m_service.dart';
import 'package:web3modal_flutter/web3modal_flutter.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  void initState() {
    super.initState();
    // Fetch the coin markets and ETH price when the widget is initialized
    final cryptoProvider = Provider.of<CryptoProvider>(context, listen: false);

    cryptoProvider.fetchEthPrice();
    cryptoProvider.fetchBtcPrice();
  }

  String shortenAddress(String address,
      {int startLength = 6, int endLength = 4}) {
    if (address.length <= startLength + endLength) {
      return address;
    }
    final start = address.substring(0, startLength);
    final end = address.substring(address.length - endLength, address.length);
    return '$start...$end';
  }

  @override
  Widget build(BuildContext context) =>
      OrientationBuilder(builder: (context, orientation) {
        var size = MediaQuery.of(context).size;
        final w3mServiceProvider = Provider.of<W3MServiceProvider>(context);
        final cryptoProvider = Provider.of<CryptoProvider>(context);
        return Scaffold(
          body: SafeArea(
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.only(top: 15.h, right: 10.h, left: 20.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Profile",
                      style: style.copyWith(
                          fontSize: MediaQuery.of(context).orientation ==
                                  Orientation.portrait
                              ? 25.sp
                              : 20.sp,
                          color: Shade2purple,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 30.h,
                    ),
                    Material(
                      child: Container(
                        height: 100.h,
                        decoration: const BoxDecoration(),
                        child: Row(
                          children: [
                            StreamBuilder<DocumentSnapshot>(
                                stream: getUserDataStream(
                                    FirebaseAuth.instance.currentUser!.uid),
                                builder: (context, snapshot) {
                                  if (snapshot.connectionState ==
                                      ConnectionState.waiting) {
                                    return Text(
                                      "Loading....",
                                      style: style.copyWith(
                                        fontSize: 15.sp,
                                        color: Shade2purple,
                                      ),
                                    );
                                  }

                                  if (!snapshot.hasData ||
                                      !snapshot.data!.exists) {
                                    return Text(
                                      "Data not found",
                                      style: style.copyWith(
                                        fontSize: 15.sp,
                                        color: Shade2purple,
                                      ),
                                    );
                                  }

                                  final userData =
                                      SignupSavepDataFirebase.fromJson(
                                    snapshot.data!.data()
                                        as Map<String, dynamic>,
                                  );

                                  return Container(
                                    height: 70.h,
                                    width: 70.h,
                                    clipBehavior: Clip.antiAlias,
                                    decoration: const BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Colors.black),
                                    child: CachedNetworkImage(
                                      key: UniqueKey(),
                                      imageUrl: userData.photoUrl!,
                                      fit: BoxFit.cover,
                                      placeholder: (context, url) => Container(
                                        child: Lottie.asset(
                                          'assets/images/loading_animation.json',
                                          width: 70.h,
                                          height: 70.h,
                                        ),
                                      ),
                                    ),
                                  );
                                }),
                            SizedBox(
                              width: 10.h,
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  StreamBuilder<DocumentSnapshot>(
                                      stream: getUserDataStream(FirebaseAuth
                                          .instance.currentUser!.uid),
                                      builder: (context, snapshot) {
                                        if (snapshot.connectionState ==
                                            ConnectionState.waiting) {
                                          return Text(
                                            "Loading....",
                                            style: style.copyWith(
                                              fontSize: 15.sp,
                                              color: Shade2purple,
                                            ),
                                          );
                                        }

                                        if (!snapshot.hasData ||
                                            !snapshot.data!.exists) {
                                          return Text(
                                            "Data not found",
                                            style: style.copyWith(
                                              fontSize: 15.sp,
                                              color: Shade2purple,
                                            ),
                                          );
                                        }

                                        final userData =
                                            SignupSavepDataFirebase.fromJson(
                                          snapshot.data!.data()
                                              as Map<String, dynamic>,
                                        );

                                        final firstName = userData.firstName;
                                        final lastName = userData.lastName;

                                        return Column(
                                          children: [
                                            Text(
                                              "$firstName $lastName",
                                              style: style.copyWith(
                                                fontSize: 15.sp,
                                                color: Shade2purple,
                                              ),
                                            ),
                                            GestureDetector(
                                              onTap: () {
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            const PersonalInformation()));
                                              },
                                              child: Text(
                                                "See profile",
                                                style: style.copyWith(
                                                  fontSize: MediaQuery.of(
                                                                  context)
                                                              .orientation ==
                                                          Orientation.portrait
                                                      ? 15.sp
                                                      : 10.sp,
                                                  color: greyShadeColor,
                                                ),
                                              ),
                                            ),
                                          ],
                                        );
                                      }),
                                ],
                              ),
                            ),
                            SizedBox(
                                height: 25.h,
                                width: 25.h,
                                child: IconButton(
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const PersonalInformation()));
                                  },
                                  icon: Icon(
                                    Icons.arrow_forward_ios_outlined,
                                    color: Shade2purple,
                                  ),
                                )),
                            SizedBox(
                              width: 15.h,
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      height: 1.h,
                      decoration: const BoxDecoration(
                        color: Color(0xff959595),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black,
                            blurRadius: 5.0,
                            offset: Offset(0, 0),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Token Balance",
                                style: style.copyWith(
                                    color: Shade2purple,
                                    fontSize: 20.sp,
                                    fontWeight: FontWeight.bold),
                              ),
                              Row(
                                children: [
                                  const Icon(Icons.note_outlined),
                                  SizedBox(
                                    width: 10.h,
                                  ),
                                  Text(
                                    shortenAddress(w3mServiceProvider.address ??
                                        'Wallet is not connected'),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                        Column(
                          children: [
                            Text(
                              w3mServiceProvider.balance != null
                                  ? '${w3mServiceProvider.balance}'
                                  : '0',
                              style: numberStyle.copyWith(
                                color: Shade2purple,
                                fontSize: 25.sp,
                              ),
                            ),
                            Text(
                              "CET",
                              style: numberStyle.copyWith(
                                  color: Shade2purple,
                                  fontSize: 18.sp,
                                  fontWeight: FontWeight.bold),
                            ),
                            // Text('ETH Price: \$${cryptoProvider.ethPrice}'),
                            // Text('BTC Price: \$${cryptoProvider.btcPrice}'),
                          ],
                        ),
                        SizedBox(
                          width: 30.w,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 30.h,
                    ),
                    GestureDetector(
                      onTap: () async {
                        try {
                          if (w3mServiceProvider.isConnected) {
                            await w3mServiceProvider.disconnect();
                          } else {
                            await w3mServiceProvider.connect(context);
                          }
                        } catch (e) {
                          print("Error connecting to wallet: $e");
                        }
                      },
                      child: CustomButton1(
                          boxShadowContainer: true,
                          title: w3mServiceProvider.isConnected
                              ? "Disconnect Wallet"
                              : "Connect Wallet"),
                    ),
                    SizedBox(
                      height: 40.h,
                    ),
                    ProfileImageButtons(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SwapPageScreen()));
                      },
                      imagePath: "assets/images/profileSet3.png",
                      text: "Get CET Tokens",
                    ),
                    SizedBox(
                      height: 40.h,
                    ),
                    Container(
                      height: 1.h,
                      decoration: const BoxDecoration(
                        color: Color(0xff959595),
                      ),
                    ),
                    SizedBox(
                      height: 40.h,
                    ),
                    ProfileImageButtons(
                      onTap: () {},
                      imagePath: "assets/images/profileSet2.png",
                      text: "Dream Houses",
                    ),
                    SizedBox(
                      height: 40.h,
                    ),
                    Container(
                      height: 1.h,
                      decoration: const BoxDecoration(
                        color: Color(0xff959595),
                      ),
                    ),
                    SizedBox(
                      height: 40.h,
                    ),
                    ProfileImageButtons(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => WalkThroughScreenPost2(
                                      postmodel: PostModel(),
                                      isEdited: false,
                                    )));
                      },
                      imagePath: "assets/images/profileSet1.png",
                      text: "Advertise your Property",
                    ),
                    SizedBox(
                      height: 40.h,
                    ),
                    Container(
                      height: 1.h,
                      decoration: const BoxDecoration(
                        color: Color(0xff959595),
                      ),
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    Text(
                      "Settings",
                      style: style.copyWith(
                          color: Shade2purple,
                          fontSize: 20.sp,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    ListTileProfileOptions(
                      text: "My Property",
                      imagepath: 'assets/images/single_room_icon.svg',
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    const MyPropertyScreen()));
                      },
                    ),
                    ListTileProfileOptions(
                      text: "Personal Information",
                      imagepath: 'assets/images/icon_profile.svg',
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    const PersonalInformation()));
                      },
                    ),
                    ListTileProfileOptions(
                      text: "Login & Security",
                      imagepath: 'assets/images/security_icon.svg',
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    const LoginSecurityScreen()));
                      },
                    ),
                    ListTileProfileOptions(
                      text: "Payments & Payouts",
                      imagepath: 'assets/images/payment_icon.svg',
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    const PaymentsAndPayouts()));
                      },
                    ),
                    ListTileProfileOptions(
                      text: "Notifications",
                      imagepath: 'assets/images/notification_icon.svg',
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => NotificationScreen()));
                      },
                    ),
                    ListTileProfileOptions(
                      text: "Privacy & Sharing",
                      imagepath: 'assets/images/privacy_icon.svg',
                      onTap: () {},
                    ),
                    ListTileProfileOptions(
                      text: "Legal",
                      imagepath: 'assets/images/legal_icon.svg',
                      onTap: () {},
                    ),
                    ListTileProfileOptions(
                      text: "Services",
                      imagepath: 'assets/images/legal_icon.svg',
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ServicePage()));
                      },
                    ),
                    ListTileProfileOptions(
                      text: "Policies",
                      imagepath: 'assets/images/legal_icon.svg',
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => PoliciesPage()));
                      },
                    ),
                    ListTileProfileOptions(
                      text: "Offers",
                      imagepath: 'assets/images/legal_icon.svg',
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => PostListScreen()));
                      },
                    ),
                    ListTileProfileOptions(
                      text: "Logout",
                      imagepath: 'assets/images/logout_icon.svg',
                      onTap: () {
                        final ap =
                            Provider.of<AuthProviderr>(context, listen: false);
                        ap.LogOut();
                        Navigator.pushNamed(context, welcomeScreenRoute);
                      },
                    )
                  ],
                ),
              ),
            ),
          ),
        );
      });
}

class ListTileProfileOptions extends StatelessWidget {
  final String text;
  final String imagepath;
  final VoidCallback onTap;
  const ListTileProfileOptions({
    super.key,
    required this.text,
    required this.imagepath,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 10.h, right: 10.h, top: 20.h),
      child: GestureDetector(
        onTap: onTap,
        child: Column(
          children: [
            Row(
              children: [
                SizedBox(
                  height: 20.h,
                  width: 20.h,
                  child: SvgPicture.asset(imagepath),
                ),
                SizedBox(
                  width: 10.w,
                ),
                Expanded(
                    child: Text(
                  text,
                  style: style.copyWith(color: Shade2purple, fontSize: 15.sp),
                )),
                const Icon(
                  Icons.arrow_forward_ios_rounded,
                  color: Shade2purple,
                )
              ],
            ),
            SizedBox(
              height: 10.h,
            ),
            Container(
              height: 1.h,
              decoration: const BoxDecoration(
                color: Color(0xff959595),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
