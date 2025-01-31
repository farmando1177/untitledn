import 'package:flutter/material.dart';

class DarkMode with ChangeNotifier {
  bool darkMode = false; // الوضع الافتراضي

  void changemode() {
    darkMode = !darkMode;
    notifyListeners(); // إخطار المستمعين بالتغيير
  }
}