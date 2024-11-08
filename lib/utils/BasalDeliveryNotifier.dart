import 'package:flutter/material.dart';

class BasalDelivery extends ChangeNotifier {
  bool basalStatus = false;
  bool get basalFound => basalStatus;

  void updateBasalGraph(bool basalFound) {
    basalStatus = basalFound;
    notifyListeners();
  }
}
