import 'package:flutter/material.dart';

class Profileupdatednotifier extends ChangeNotifier{
bool? submitted;
  bool? get success => submitted;

  void updateProfileNotifier(bool? success){
    submitted = success;
    notifyListeners();
  }
}