import 'package:crypto_estate_tech/helperclass/dataFromFirestore.dart';
import 'package:flutter/material.dart';

class ChatProvider extends ChangeNotifier {
  List<String> _userIds = [];

  List<String> get userIds => _userIds;

  set userIds(List<String> value) {
    _userIds = value;
  }

  Future<void> fetchData(String currentUserId) async {
    // Fetch your data and update the userIds list
    userIds = await getReceiverIdsBySenderId(currentUserId);
    // Notify listeners that the data has changed
    notifyListeners();
  }

  



}
