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

  print(formattedDate); // Output: 24/05 May

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














