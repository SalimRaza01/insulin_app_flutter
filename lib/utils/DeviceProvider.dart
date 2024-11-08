import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';

class Deviceprovider extends ChangeNotifier{
  BluetoothDevice? getdevice;
  BluetoothDevice? get myagvaDevice => getdevice;

  void updateDevice(BluetoothDevice? myagvaDevice){
    getdevice = myagvaDevice;
    notifyListeners();
  }
}