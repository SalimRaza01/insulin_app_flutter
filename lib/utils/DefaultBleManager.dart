// import 'dart:async';
// import 'dart:convert';

// import 'package:flutter_blue_plus/flutter_blue_plus.dart';
// import 'package:newproject/utils/BLE_AbstractClass.dart';

// class DefaultBleManager extends BleManager {
//   List<BluetoothService>? _services = [];
//   late StreamSubscription<List<ScanResult>> _scanResultsSubscription;
//   List<ScanResult> _scanResults = [];

//   @override
//   void initializeBluetoothListeners() {
//     FlutterBluePlus.adapterState.listen((state) {
//       adapterState.value = state;
//       if (state == BluetoothAdapterState.on) {
//         startScanIfNotScanning();
//         print('Bluetooth is on. Starting scan...');
//       }
//     });
//   }

//   @override
//   void startScanIfNotScanning() {
//   _scanResults = [];
//   print('Starting scan for AgVa device.');

//   if (!isScanningRunning.value && !isDeviceConnected.value) {
//     FlutterBluePlus.startScan();
//     isScanningRunning.value = true;

//     _scanResultsSubscription = FlutterBluePlus.scanResults.listen((results) {
//       print('Scan results: $results');
//       _scanResults = results;

//       for (ScanResult result in _scanResults) {
//         print("Device found: ${result.device.platformName}");

//         if (result.device.platformName == 'AgVa insulin') {
//           FlutterBluePlus.stopScan();
//           agvaDevice.value = result.device;
//           notifyListeners();  // Notify listeners after updating agvaDevice
//           print('AgVa Device found: ${agvaDevice.value}');
//           isScanningRunning.value = false;
//           _scanResultsSubscription.cancel();
//           break;
//         }
//       }
//     });
//   }
// }

//   // void startScanIfNotScanning() {
//   //   _scanResults = [];
//   //   print('Starting scan for AgVa device.');
//   //   if (!isScanningRunning.value && !isDeviceConnected.value) {
//   //     FlutterBluePlus.startScan();
//   //     isScanningRunning.value = true;
//   //     _scanResultsSubscription = FlutterBluePlus.scanResults.listen((results) {
//   //       print('scan result $results');
//   //       _scanResults = results;
//   //       for (ScanResult result in _scanResults) {
//   //             print("AgVa Device result ${result.device.platformName}");
//   //             if(result.device.platformName == 'AgVa insulin'){
//   //                FlutterBluePlus.stopScan();
              

//   //               agvaDevice.value = result.device;
//   //               notifyListeners();
//   //                 print('device found ${agvaDevice.value} ${result.device}');
//   //               if(agvaDevice.value == true){
                 
//   //               }
//   //             }
//   //         // if (result.advertisementData.advName.contains('AgVa')) {
//   //         //      if (result.device.platformName.contains('AgVa')) {
//   //         //          print('device found');
//   //         //   agvaDevice.value = result.device;
//   //         //   FlutterBluePlus.stopScan();
//   //         //   isScanningRunning.value = false;
//   //         //   _scanResultsSubscription.cancel();
//   //         // } else {
//   //         //   // print('device not found');
//   //         //   //             agvaDevice.value = null;
//   //         //   // FlutterBluePlus.stopScan();
//   //         //   // isScanningRunning.value = false;
//   //         //   // _scanResultsSubscription.cancel();
//   //         // }
//   //       }
//   //     });
//   //   }
//   // }

//   @override
//   Future<void> connectToDevice(BluetoothDevice? device) async {
//     await device!.connect();
//     discoverServices(device);
//     isDeviceConnected.value = true;
//   }

//   @override
//   void disconnectDevice(BluetoothDevice? device) async {
//     await device!.disconnect();
//     agvaDevice.value = null;
//     isDeviceConnected.value = false;
//   }

//   @override
//   void startConnectionCheckTimer(BluetoothDevice device) {
//     Timer.periodic(Duration(seconds: 1), (timer) async {
//       var state = await device.connectionState.first;
//       if (state == BluetoothConnectionState.disconnected) {
//         _scanResults = [];
//         isDeviceConnected.value = false;
//         agvaDevice.value = null;
//         startScanIfNotScanning();
//         timer.cancel();
//       }
//     });
//   }

//   @override
//   Future<void> discoverServices(BluetoothDevice device) async {
//     _services = await device.discoverServices();
//     if (_services != null) {
//       readOrWriteCharacteristic(characteristicUuid, finalString, true);
//       isDeviceConnected.value = true;
//       startConnectionCheckTimer(device);
//     }
//   }

//   @override
//   BluetoothCharacteristic? findCharacteristic(String characteristicUuid) {
//     for (BluetoothService service in _services!) {
//       for (BluetoothCharacteristic characteristic in service.characteristics) {
//         if (characteristic.uuid.toString() == characteristicUuid) {
//           return characteristic;
//         }
//       }
//     }
//     return null;
//   }

//   @override
//   Future<void> readOrWriteCharacteristic(
//       String characteristicUuid, String text, bool isRead) async {
//     try {
//       BluetoothCharacteristic? characteristic =
//           findCharacteristic(characteristicUuid);
//       if (characteristic != null) {
//         await characteristic.write(utf8.encode(text), withoutResponse: false);
//         if (isRead) {
//           var data = await characteristic.read();
//           var decodedData = utf8.decode(data);
//           ackNotifier.value = decodedData.contains('ACK');
//         }
//       }
//     } catch (e) {
//       print(e);
//     }
//   }
// }
