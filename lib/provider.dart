import 'package:flutter/cupertino.dart';

class themeprovider extends ChangeNotifier {
  int current_theme = 0;
  void toggle() {
    if (current_theme == 0)
      current_theme = 1;
    else
      current_theme = 0;

    notifyListeners();
  }
}
