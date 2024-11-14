import 'package:flutter/material.dart';

class SmartBolusDelivery extends ChangeNotifier {
  bool sbolusStatus = false;
  bool get sbolusfound => sbolusStatus;

  void updateSmartBolusValue(bool sbolusfound) {
    sbolusStatus = sbolusfound;
    notifyListeners();
  }
}
