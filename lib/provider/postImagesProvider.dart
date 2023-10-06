import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class XFileProvider with ChangeNotifier {
  String currency = 'AED';

  List<XFile> _xFiles = [];

  List<XFile> get xFiles => _xFiles;

  void setXFiles(List<XFile> files) {
    _xFiles = files;
    notifyListeners();
  }

  updateCurrency(String newCurrency) {
    currency = newCurrency;
    notifyListeners();
  }
}
