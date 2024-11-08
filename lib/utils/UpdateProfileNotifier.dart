
import 'package:flutter/material.dart';

class ProfileUpdateNotifier extends ChangeNotifier {
  bool updatedProfile = false;

  bool get _updatedProfile => updatedProfile;

  void updateProfile(bool _updatedProfile) {
    updatedProfile = _updatedProfile;
    print('inside provider $updatedProfile');
    notifyListeners();
  }
}
