import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class PostLikesProvider extends ChangeNotifier {
  List<String> likedPostIds = [];

  Future<void> initializeLikedPostIds(String currentUserId) async {
    likedPostIds =
        List<String>.from(await getLikedPostIdsForCurrentUser(currentUserId));
    notifyListeners();
  }

  void toggleLike(String postId, String currentUserId) {
    if (likedPostIds.contains(postId)) {
      disLikePost(postId, currentUserId);
    } else {
      likePost(postId, currentUserId);
    }
  }

  Future<void> likePost(String postId, String currentUserId) async {
    try {
      await FirebaseFirestore.instance.collection('posts').doc(postId).update({
        'likes': FieldValue.arrayUnion([currentUserId])
      });
      likedPostIds.add(postId);
      notifyListeners();
      print('Post $postId liked by user $currentUserId');
    } catch (e) {
      print('Error liking post: $e');
    }
  }

  Future<void> disLikePost(String postId, String currentUserId) async {
    try {
      await FirebaseFirestore.instance.collection('posts').doc(postId).update({
        'likes': FieldValue.arrayRemove([currentUserId])
      });
      likedPostIds.remove(postId);
      notifyListeners();
      print('Post $postId unliked by user $currentUserId');
    } catch (e) {
      print('Error unliking post: $e');
    }
  }

  Future<List<String>> getLikedPostIdsForCurrentUser(
      String currentUserId) async {
    List<String> likedPostIds = [];

    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('posts')
          .where('likes', arrayContains: currentUserId)
          .get();

      for (var doc in querySnapshot.docs) {
        likedPostIds.add(doc.id);
      }
    } catch (e) {
      print('Error fetching liked post IDs: $e');
    }

    return likedPostIds;
  }
}
