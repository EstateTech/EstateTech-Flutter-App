import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crypto_estate_tech/model/postModel.dart';
import 'package:crypto_estate_tech/model/signupSaveDataFirebase.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';

// class DataFromFirestore {
//   Stream<List<PostModel>> getPostsallStream() {
//     return FirebaseFirestore.instance.collection('posts').snapshots().map(
//         (snapshot) => snapshot.docs
//             .map((doc) => PostModel.fromJson(doc.data()))
//             .toList());
//   }
// }

String getFirstThreeWords(String sentence) {
  // Split the sentence into individual words
  List<String> words = sentence.split(' ');

  // Take the first three words or less if the sentence has fewer than three words
  List<String> firstThreeWords = words.take(3).toList();

  // Join the words back into a sentence
  String result = firstThreeWords.join(' ');

  return result;
}

String joinWithComma(List<String> strings) {
  String result = strings.join(', ');
  return result;
}

String Convertdate(Timestamp? timestamp) {
// Converting the Timestamp to DateTime
  DateTime dateTime = timestamp?.toDate() ?? DateTime.now();

// Formatting the DateTime to the desired format
  String formattedDate = DateFormat('yy/dd MMM').format(dateTime);

  print(formattedDate); // Output: 24/05 May

  return formattedDate;
}

Future<String> getMemberType(String userId) async {
  // Initialize Firestore
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  // Document reference to the user document
  DocumentReference userRef = firestore.collection('users').doc(userId);
  print("the user id is  in the get member method is ${userId}");

  try {
    // Get the user document from Firestore
    DocumentSnapshot userSnapshot = await userRef.get();

    // Check if the user document exists
    if (userSnapshot.exists) {
      // Get the member type field from the user document
      String memberType = userSnapshot.get('memberType');
      return memberType;
    } else {
      return 'Unknown'; // Default value if user document doesn't exist
    }
  } catch (e) {
    print('Error getting member type: $e');
    return 'Error';
  }
}








