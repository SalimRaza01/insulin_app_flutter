// import 'dart:async';
// import 'package:flutter/material.dart';
// import 'package:flutter_blue_plus/flutter_blue_plus.dart';

// abstract class BleManager extends ChangeNotifier {
//   ValueNotifier<bool> ackNotifier = ValueNotifier(false);
//   ValueNotifier<BluetoothDevice?> agvaDevice = ValueNotifier(null);
//   ValueNotifier<bool> isScanningRunning = ValueNotifier(false);
//   ValueNotifier<bool> isDeviceConnected = ValueNotifier(false);
//   ValueNotifier<BluetoothAdapterState> adapterState =
//       ValueNotifier(BluetoothAdapterState.unknown);

//   String characteristicUuid = "beb5483e-36e1-4688-b7f5-ea07361b26a8";
//   String finalString = 'cm+sync';

//   void initializeBluetoothListeners();
//   void startScanIfNotScanning();
//   Future<void> connectToDevice(BluetoothDevice? device);
//   void disconnectDevice(BluetoothDevice? device);
//   void startConnectionCheckTimer(BluetoothDevice device);
//   Future<void> discoverServices(BluetoothDevice device);
//   BluetoothCharacteristic? findCharacteristic(String characteristicUuid);
//   Future<void> readOrWriteCharacteristic(
//       String characteristicUuid, String text, bool isRead);
// }
