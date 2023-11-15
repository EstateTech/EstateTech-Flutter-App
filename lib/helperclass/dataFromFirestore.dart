import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crypto_estate_tech/model/message.dart';
import 'package:crypto_estate_tech/model/signupSaveDataFirebase.dart';
import 'package:crypto_estate_tech/provider/chatProvider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';










String Convertdate(Timestamp? timestamp) {
// Converting the Timestamp to DateTime
  DateTime dateTime = timestamp?.toDate() ?? DateTime.now();

// Formatting the DateTime to the desired format
  String formattedDate = DateFormat('yy/dd MMM').format(dateTime);

 // print(formattedDate); // Output: 24/05 May

  return formattedDate;
}

Future<String> getMemberType(String userId) async {
  // Initialize Firestore
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  // Document reference to the user document
  DocumentReference userRef = firestore.collection('users').doc(userId);
  print("the user id is  in the get member method is $userId");

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

Stream<QuerySnapshot<Map<String, dynamic>>> getPostsForCurrentUser(String currentUserId) {
  return FirebaseFirestore.instance
      .collection('posts')
      .where('userid', isEqualTo: currentUserId)
      .snapshots();
}

Future<void> deletePost(String postId) async {
  try {
    // Assuming you're using Firebase Firestore.
    await FirebaseFirestore.instance.collection('posts').doc(postId).delete();
  } catch (e) {
    print("Error deleting post: $e");
    // Handle any errors that occur during deletion.
  }
}

Stream<QuerySnapshot<Map<String, dynamic>>> getPostsStream(String postFeature) {
  return FirebaseFirestore.instance
      .collection('posts')
      .where('postFeature', isEqualTo: postFeature)
      .snapshots();
}

Stream<QuerySnapshot> getQueryStream(
    String propertyType, int bedrooms, int bathrooms, 
    String rentalPeriod, 
    String rentalSubtype ,
     String rentalType    ) {
  return FirebaseFirestore.instance
      .collection('posts')
      .where('propertyType', isEqualTo: propertyType)
      .where('bedrooms', isEqualTo: bedrooms)
      .where('bathrooms', isEqualTo: bathrooms)
      .where('rentalPeriod' , isEqualTo:  rentalPeriod)
      .where('rentalSubtype' , isEqualTo: rentalSubtype)
      .where('rentalType',isEqualTo: rentalType)
      .snapshots();
      
}

Stream<QuerySnapshot> getAllUsersInInbox() {
 return FirebaseFirestore.instance
                                .collection('users')
                                .where('userId',
                                    isNotEqualTo:
                                        FirebaseAuth.instance.currentUser!.uid)
                                .snapshots();
}












// get similar post
Stream<QuerySnapshot> getSimilarPostsStream(String propertyType) {
  return FirebaseFirestore.instance
      .collection('posts')
      .where('propertyType', isEqualTo: propertyType)
      .snapshots();
}

final CollectionReference _usersCollection =
    FirebaseFirestore.instance.collection('users');

Stream<DocumentSnapshot> getUserDataStream(String userId) {
  return _usersCollection.doc(userId).snapshots();
}



Stream<QuerySnapshot <Map<String,dynamic>>> getAllMessages(SignupSavepDataFirebase signuser) {
  return FirebaseFirestore.instance.collection('chats/${getConversationID(signuser.userId!)}/messages/').snapshots();
}
User? user = FirebaseAuth.instance.currentUser;
String getConversationID(String id) => user!.uid.hashCode <= id.hashCode ? '${user!.uid}_$id' : '${id}_${user!.uid}'; 

 


 Future<void> sendMessage(SignupSavepDataFirebase signUser , String msg,BuildContext context) async{
  final time = DateTime.now().millisecondsSinceEpoch.toString();

  final Message message = Message(toId: signUser.userId!,
   msg: msg, read: '', type: Type.text, fromId: user!.uid, sent: time);

   final ref = FirebaseFirestore.instance.collection('chats/${getConversationID(signUser.userId!)}/messages/');
   await ref.doc(time).set(message.toJson());

   final ref2 = FirebaseFirestore.instance.collection("chats");
   await ref2.doc('${getConversationID(signUser.userId!)}').set({
      'receiverId': signUser.userId!,
    'FromId': user!.uid
    
   });
 final chatProvider = Provider.of<ChatProvider>(context, listen: false);
  chatProvider.fetchData(user!.uid);


 }


 Future<void> deleteChatDocument(String receiverIdd,BuildContext context) async {
  //print(" the id in delete method is ${getConversationID(receiverIdd)}");
  print("${user!.uid}_----${receiverIdd}");
 

 final batch = FirebaseFirestore.instance.batch();

  // Delete the parent document
  final parentDocumentRef = FirebaseFirestore.instance.collection('chats').doc(receiverIdd);
  batch.delete(parentDocumentRef);

  // Delete the subcollection
  final subcollectionRef = parentDocumentRef.collection('messages');
  final subcollectionSnapshot = await subcollectionRef.get();
  subcollectionSnapshot.docs.forEach((doc) {
    batch.delete(doc.reference);
  });

  try {
    // Commit the batched write operation
    await batch.commit();

    // Update the UI or perform any other necessary operations
    final chatProvider = Provider.of<ChatProvider>(context, listen: false);
    chatProvider.fetchData(user!.uid);
  } catch (e) {
    print('Error deleting document and subcollection: $e');
  }
  }







Future<List<String>> getReceiverIdsBySenderId(String currentUserId) async {
  try {
    // Create a reference to the 'chat' collection
    CollectionReference chatCollection = FirebaseFirestore.instance.collection('chats');

    List<String> userIds = [];

    // Query for documents where 'senderId' matches the currentUserId
    QuerySnapshot senderQuerySnapshot = await chatCollection
        .where('FromId', isEqualTo: currentUserId)
        .get();

    // Iterate through the sender documents and add 'receiverId' to the list
    for (QueryDocumentSnapshot doc in senderQuerySnapshot.docs) {
      String receiverId = doc['receiverId'] as String;
      if (receiverId != currentUserId) {
        userIds.add(receiverId);
      }
    }

    // Query for documents where 'receiverId' matches the currentUserId
    QuerySnapshot receiverQuerySnapshot = await chatCollection
        .where('receiverId', isEqualTo: currentUserId)
        .get();

    // Iterate through the receiver documents and add 'senderId' to the list
    for (QueryDocumentSnapshot doc in receiverQuerySnapshot.docs) {
      String senderId = doc['FromId'] as String;
      if (senderId != currentUserId) {
        userIds.add(senderId);
      }
    }

    // Remove duplicate user IDs if any
    userIds = userIds.toSet().toList();

    return userIds;
  } catch (e) {
    print('Error getting user IDs with matching IDs: $e');
    return [];
  }
}




Future<void> updatePost(String postId, String rentalPeriod, String rentalSubtype, String rentalType) async {
  try {
    await FirebaseFirestore.instance.collection('posts').doc(postId).update({
      'rentalPeriod': rentalPeriod,
      'rentalSubtype': rentalSubtype,
      'rentalType': rentalType,
    });
    print('Post updated successfully');
  } catch (e) {
    print('Error updating post: $e');
  }
}

// // follower part 

// Future<void> followUser(String currentUserId, String profileUserId) async {
//   // Update the profile user's followers list
//   await FirebaseFirestore.instance.collection('users').doc(profileUserId).update({
//     'followers': FieldValue.arrayUnion([currentUserId]),
//   });

//   // Update the current user's following list
//   await FirebaseFirestore.instance.collection('users').doc(currentUserId).update({
//     'following': FieldValue.arrayUnion([profileUserId]),
//   });
// }



// Future<void> unfollowUser(String currentUserId, String profileUserId) async {
//   // Update the profile user's followers list
//   await FirebaseFirestore.instance.collection('users').doc(profileUserId).update({
//     'followers': FieldValue.arrayRemove([currentUserId]),
//   });

//   // Update the current user's following list
//   await FirebaseFirestore.instance.collection('users').doc(currentUserId).update({
//     'following': FieldValue.arrayRemove([profileUserId]),
//   });
// }

// Future<int> getFollowersCount(String userId) async {
//   try {
//     DocumentSnapshot<Map<String, dynamic>> userSnapshot = await FirebaseFirestore
//         .instance
//         .collection('users')
//         .doc(userId)
//         .get();

//     // Get the followers list from the user document
//     List<dynamic>? followersList = userSnapshot.data()?['followers'];

//     // Return the count of followers
//     return followersList?.length ?? 0;
//   } catch (e) {
//     print('Error counting followers: $e');
//     return 0; // Return 0 in case of an error
//   }
// }

// Future<int> getFollowingCount(String userId) async {
//   try {
//     // You can implement a similar logic for 'following'
//     // Adjust the field name based on your actual structure
//     DocumentSnapshot<Map<String, dynamic>> userSnapshot = await FirebaseFirestore
//         .instance
//         .collection('users')
//         .doc(userId)
//         .get();

//     // Get the following list from the user document
//     List <dynamic>? followingList = userSnapshot.data()?['following'];

//     // Return the count of following
//     return followingList?.length ?? 0;
//   } catch (e) {
//     print('Error counting following: $e');
//     return 0; // Return 0 in case of an error
//   }
// }

Future<int> getPostCountForUser(String userId) async {
  try {
    QuerySnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore.instance
        .collection('posts')
        .where('userid', isEqualTo: userId)
        .get();
        print("in the post count method ${snapshot.size}" );

    return snapshot.size;
  } catch (e) {
    print('Error getting post count: $e');
    return 0; // Return 0 in case of an error
  }
}














