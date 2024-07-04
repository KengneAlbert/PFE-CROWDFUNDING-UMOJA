import 'package:flutter/material.dart';

class TextProvider with ChangeNotifier {
  String _text = '';

  String get text => _text;

  void setText(String newText) {
    _text = newText;
    notifyListeners();
  }
}
