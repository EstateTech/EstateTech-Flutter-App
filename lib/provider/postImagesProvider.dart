import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class XFileProvider with ChangeNotifier {
  List<XFile> _xFiles = [];

  List<XFile> get xFiles => _xFiles;

  void setXFiles(List<XFile> files) {
    _xFiles = files;
    notifyListeners();
  }
}
