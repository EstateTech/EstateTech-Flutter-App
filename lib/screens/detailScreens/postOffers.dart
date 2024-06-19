import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:crypto_estate_tech/screens/detailScreens/offerScreen.dart';

class PostListScreen extends StatefulWidget {
  const PostListScreen({Key? key}) : super(key: key);

  @override
  _PostListScreenState createState() => _PostListScreenState();
}

class _PostListScreenState extends State<PostListScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  late String userId;
  String userName = '';

  @override
  void initState() {
    super.initState();
    userId = _auth.currentUser!.uid;
    print("User ID: $userId"); // Debug print for user ID
    _fetchUserName();
  }

  Future<void> _fetchUserName() async {
    try {
      DocumentSnapshot userDoc = await FirebaseFirestore.instance
          .collection('users') // Make sure this matches your users collection
          .doc(userId)
          .get();

      if (userDoc.exists) {
        setState(() {
          userName = userDoc['firstName']; // Assuming the name field exists
        });
        print("User Name: $userName"); // Debug print for user name
      }
    } catch (e) {
      print("Error fetching user name: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Your Properties"),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('posts')
            .where('userid', isEqualTo: userId)
            .snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            print("No data in snapshot"); // Debug print for empty snapshot
            return const Center(child: CircularProgressIndicator());
          }
          final posts = snapshot.data!.docs;
          print(
              "Fetched ${posts.length} posts"); // Debug print for number of posts fetched

          List<Widget> postList = [];

          for (var post in posts) {
            var postId = post.id;
            print("Post ID: $postId"); // Debug print for post ID

            var data = post.data() as Map<String, dynamic>;
            var postTitle =
                data['propertyAddressLine1']; // Assuming you have a title field
            postList.add(Card(
              margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              child: ListTile(
                title: Text(postTitle),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => OfferScreen(postId: postId),
                    ),
                  );
                },
              ),
            ));
          }

          if (postList.isEmpty) {
            print("No posts found"); // Debug print for no posts
            return const Center(child: Text("No posts found"));
          }

          return ListView(
            children: postList,
          );
        },
      ),
    );
  }
}
