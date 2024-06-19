import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:crypto_estate_tech/provider/walletProvider.dart';
import 'package:provider/provider.dart';

class ClientOffersScreen extends StatefulWidget {
  const ClientOffersScreen({Key? key}) : super(key: key);

  @override
  _ClientOffersScreenState createState() => _ClientOffersScreenState();
}

class _ClientOffersScreenState extends State<ClientOffersScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  late String userId;

  @override
  void initState() {
    super.initState();
    userId = _auth.currentUser!.uid;
    print("User ID: $userId"); // Debug print for user ID
  }

  @override
  Widget build(BuildContext context) {
    final w3mServiceProvider = Provider.of<W3MServiceProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Your Offers"),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('posts').snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            print("No data in snapshot"); // Debug print for empty snapshot
            return const Center(child: CircularProgressIndicator());
          }
          final posts = snapshot.data!.docs;
          print(
              "Fetched ${posts.length} posts with offers"); // Debug print for number of posts fetched

          List<Widget> offerList = [];

          for (var post in posts) {
            var postId = post.id;
            print("Post ID: $postId"); // Debug print for post ID

            var data = post.data() as Map<String, dynamic>;
            var postTitle =
                data['propertyAddressLine1']; // Assuming you have a title field
            List<dynamic> offers = data['offers'] ?? [];

            for (var offer in offers) {
              if (offer['userId'] == userId) {
                print(
                    'Offer: ${offer['offer']}, Status: ${offer['status']}'); // Debug print for individual offer
                offerList.add(Card(
                  margin:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  child: ListTile(
                    title: Text("Property: $postTitle"),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Offer: \$${offer['offer']}"),
                        Text("Status: ${offer['status']}"),
                        if (offer['status'] == 'accepted')
                          ElevatedButton(
                            onPressed: () {
                              // Handle buy action
                              // Fluttertoast.showToast(msg: "Proceed to payment");
                              w3mServiceProvider.connect(context);
                            },
                            child: const Text("Buy"),
                          ),
                      ],
                    ),
                  ),
                ));
              }
            }
          }

          if (offerList.isEmpty) {
            print("No offers found"); // Debug print for no offers
            return const Center(child: Text("No offers found"));
          }

          return ListView(
            children: offerList,
          );
        },
      ),
    );
  }
}
