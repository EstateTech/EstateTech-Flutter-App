import 'package:cloud_firestore/cloud_firestore.dart';

import '../model/signupSaveDataFirebase.dart';

class OwnFirebaseAuth {
  CollectionReference firebaseFirestoreCollectionReference =
      FirebaseFirestore.instance.collection('users');

  signSaveDataToFirebase(
      SignupSavepDataFirebase signupSavepDataFirebase) async {
    firebaseFirestoreCollectionReference
        .doc(signupSavepDataFirebase.userId)
        .set(signupSavepDataFirebase.toJson());
  }
}
