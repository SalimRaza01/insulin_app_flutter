import 'package:flutter/material.dart';

class GlucoseDelivery extends ChangeNotifier{
  bool glucoseStatus = false;
  bool get glucoseFound => glucoseStatus;


  void glucoseUpdate(bool glucoseFound){
    glucoseStatus = glucoseFound;
    notifyListeners();
  } 
}