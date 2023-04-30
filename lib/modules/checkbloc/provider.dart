import 'package:flutter/material.dart';

class Model extends ChangeNotifier {
  int counter = 0;

  void plus() {
    counter++;
    notifyListeners();
  }

  int minus() {
    if (counter == 0) {
      return 0;
    }
    counter--;

    notifyListeners();
    return 1;
  }
}
