import 'package:flutter/material.dart';

class WeightSetup extends ChangeNotifier {
  bool weightStatus = false;
  bool get weightFound => weightStatus;

  void weightUpdate(bool weightFound){
    weightStatus = weightFound;
    notifyListeners();
  }
}