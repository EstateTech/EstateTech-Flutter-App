import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class XFileProvider with ChangeNotifier {
  String currency = 'AED';
  String currencySign = "\$";
  String _postid = "";

  String get postid => _postid;

  
  void setEditedpostId (String postId) {
    this._postid = postId;
    notifyListeners();
  }

  List<XFile> _xFiles = [];

  List<XFile> get xFiles => _xFiles;


  List<String> _networkImages = [];

  List<String> get networkImages => _networkImages;

  void setXFiles(List<XFile> files) {
    _xFiles = files;
    notifyListeners();
  }

  updateCurrency(String newCurrency) {
    currency = newCurrency;
    notifyListeners();
  }

  updateCurrencySign(String sign) {
    currencySign = sign;
    notifyListeners();
  
}


void updateImages(List<XFile> newImages, List<String> newNetworkImages) {
    _xFiles.addAll(newImages);
    _networkImages.addAll(newNetworkImages);
    notifyListeners();
  }




}


