import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fluttertoast/fluttertoast.dart';

class OfferScreen extends StatefulWidget {
  final String postId;
  const OfferScreen({Key? key, required this.postId}) : super(key: key);

  @override
  _OfferScreenState createState() => _OfferScreenState();
}

class _OfferScreenState extends State<OfferScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Offers on Property"),
      ),
      body: StreamBuilder<DocumentSnapshot>(
        stream: FirebaseFirestore.instance
            .collection('posts')
            .doc(widget.postId)
            .snapshots(),
        builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          if (!snapshot.hasData) {
            print("No data in snapshot"); // Debug print for empty snapshot
            return const Center(child: CircularProgressIndicator());
          }
          final post = snapshot.data!;
          if (!post.exists) {
            print("Post does not exist"); // Debug print for non-existent post
            return const Center(child: Text("No offers found"));
          }

          var data = post.data() as Map<String, dynamic>;
          print("Post ID: ${widget.postId}"); // Debug print for post ID

          if (!data.containsKey('offers')) {
            print(
                "Post ${widget.postId} does not contain offers field"); // Debug print for missing offers field
            return const Center(child: Text("No offers found"));
          }

          var postTitle =
              data['propertyAddressLine1']; // Assuming you have a title field
          List<dynamic> offers = data['offers'] ?? [];
          print(
              'Offers for Post ${widget.postId}: $offers'); // Debug print for offers

          List<Widget> offersList = [];

          for (var offer in offers) {
            print(
                'Offer: ${offer['offer']}, Status: ${offer['status']}'); // Debug print for individual offer
            offersList.add(Card(
              margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              child: ListTile(
                title: Text("Offer: \$${offer['offer']}"),
                subtitle: Text("Status: ${offer['status']}"),
                trailing: offer['status'] == 'pending'
                    ? ElevatedButton(
                        onPressed: () => _acceptOffer(widget.postId, offer),
                        child: const Text("Accept"),
                      )
                    : null,
              ),
            ));
          }

          if (offersList.isEmpty) {
            print("No offers found"); // Debug print for no offers
            return const Center(child: Text("No offers found"));
          }

          return ListView(
            children: offersList,
          );
        },
      ),
    );
  }

  void _acceptOffer(String postId, dynamic offer) async {
    try {
      await FirebaseFirestore.instance.collection('posts').doc(postId).update({
        'offers': FieldValue.arrayRemove([offer]),
      });

      offer['status'] = 'accepted';

      await FirebaseFirestore.instance.collection('posts').doc(postId).update({
        'offers': FieldValue.arrayUnion([offer]),
      });

      Fluttertoast.showToast(msg: "Offer accepted successfully");
      print(
          "Offer accepted: ${offer['offer']}"); // Debug print for accepted offer
    } catch (e) {
      Fluttertoast.showToast(msg: "An error occurred: $e");
      print("Error accepting offer: $e"); // Debug print for error
    }
  }
}
