import 'package:flutter/material.dart';

class CharacteristicProvider extends ChangeNotifier {
  void Function(String characteristicUuid, String text, bool isRead)
      getBLEfunctionaltity = (characteristicUuid, text, isRead) {};
  void Function(String characteristicUuid, String text, bool isRead)
      get onCharacteristicChecked => getBLEfunctionaltity;
  void getFunction(
      Future<void> Function(String characteristicUuid, String text, bool isRead)
          onCharacteristicChecked) {
    getBLEfunctionaltity = onCharacteristicChecked;
    notifyListeners();
  }
}
