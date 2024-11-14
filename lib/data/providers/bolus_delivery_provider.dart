import 'package:flutter/material.dart';

class Bolusdelivery extends ChangeNotifier{
  bool deliveryStatus = false;
bool get statusFound => deliveryStatus;

  void updateStatus(bool statusFound){
deliveryStatus = statusFound;
notifyListeners();
  }
}