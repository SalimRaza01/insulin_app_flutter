import 'package:flutter/foundation.dart';

class Deviceconnection extends ChangeNotifier {
  bool isDeviceConnected = false;

  bool get deviceConnectionStatus => isDeviceConnected;

  void getDeviceConnection(bool deviceConnectionStatus) {
    isDeviceConnected = deviceConnectionStatus;
    notifyListeners();
  }
}
