import 'package:flutter/foundation.dart';

class ReadNotifier extends ChangeNotifier {
  bool getack = false;

  bool get ackFound => getack;

  void updateDec(bool ackFound) {
    getack = ackFound;
    notifyListeners();
  }
}
