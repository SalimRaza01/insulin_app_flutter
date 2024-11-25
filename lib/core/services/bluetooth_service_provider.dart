import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';

class BleManager extends ChangeNotifier {
  ValueNotifier<bool> ackNotifier = ValueNotifier(false);
  ValueNotifier<BluetoothDevice?> agvaDevice = ValueNotifier(null);
  ValueNotifier<bool> isScanningRunning = ValueNotifier(false);
  ValueNotifier<bool> isDeviceConnected = ValueNotifier(false);
  ValueNotifier<BluetoothAdapterState> adapterState =
      ValueNotifier(BluetoothAdapterState.unknown);

  static final BleManager _instance = BleManager._internal();
  factory BleManager() => _instance;

  BleManager._internal(); // Private constructor

  List<BluetoothService>? _services = [];
  final String characteristicUuid = "beb5483e-36e1-4688-b7f5-ea07361b26a8";
  String finalString = 'cm+hs';

  late StreamSubscription<List<ScanResult>> _scanResultsSubscription;
  late StreamSubscription<bool> _isScanningStream;

  void initializeBluetoothListeners() {
    FlutterBluePlus.adapterState.listen((state) {
      adapterState.value = state;
      if (state == BluetoothAdapterState.on) {
        startScanIfNotScanning();
        print('Bluetooth is on. Starting scan...');
      }
    });
  }

  void startScanIfNotScanning() {
    if (!isScanningRunning.value && !isDeviceConnected.value) {
      FlutterBluePlus.startScan(timeout: Duration(seconds: 3));
      _isScanningStream = FlutterBluePlus.isScanning.listen((state) {
        isScanningRunning.value = state;
        notifyListeners();
      });

      _scanResultsSubscription = FlutterBluePlus.scanResults.listen((results) {
        _processScanResults(results);
      });
    }
  }

  void _processScanResults(List<ScanResult> results) {
    for (ScanResult result in results) {
      if (result.device.platformName == 'AgVa insulin') {
        // agvaDevice.value = result.device;
        connectToDevice(result.device);
        FlutterBluePlus.stopScan();
        isScanningRunning.value = false;
        notifyListeners();
        return;
      }
    }
  }

  Future<void> connectToDevice(BluetoothDevice? device) async {
    await device!.connect();
    agvaDevice.value = device;
    notifyListeners();

    Future.delayed(Duration(seconds: 3), () {
      if (isDeviceConnected.value == true) {
        agvaDevice.value = null;
        notifyListeners();
      }
    });
  }

  void disconnectDevice(BluetoothDevice? device) async {
    await device!.disconnect();
    agvaDevice.value = null;
    isDeviceConnected.value = false;
    notifyListeners();
    startScanIfNotScanning();
  }

  void startConnectionCheckTimer(BluetoothDevice device) {
    Timer.periodic(Duration(seconds: 2), (timer) async {
      var state = await device.connectionState.first;
      if (state == BluetoothConnectionState.disconnected) {
        isDeviceConnected.value = false;
        agvaDevice.value = null;
        notifyListeners();
        timer.cancel();
        startScanIfNotScanning();
      }
    });
  }

  Future<void> discoverServices(BluetoothDevice device) async {
    _services = await device.discoverServices();
    if (_services != null) {
      isDeviceConnected.value = true;
      notifyListeners();
      readOrWriteCharacteristic(characteristicUuid, finalString, true);
      startConnectionCheckTimer(device);
    }
  }

  Future<void> readOrWriteCharacteristic(

      String characteristicUuid, String text, bool isRead) async {
    try {
      BluetoothCharacteristic? characteristic =
          findCharacteristic(characteristicUuid);

      if (characteristic != null) {
        await characteristic.write(utf8.encode(text), withoutResponse: false);
        if (isRead) {
          var data = await characteristic.read();
          var dataDecoded = utf8.decode(data);
          var startIndex = "IN@";
          var endIndex = "#";
          if(dataDecoded.startsWith(startIndex) && dataDecoded.endsWith(endIndex)){
           var finalData =  dataDecoded.split("|");

           for(final data in finalData){
            print(data[1]);
           }
           print(finalData);
          }
          print("DataPacket found $dataDecoded");




//   var data = "IN@123,44,12,44,33,53,663,23,45,65|33,53,663,23,45,65,16,75,23|32,44,232,665,112,841#";
//   var startIndex = "IN@";
//   List<List<String>> bolusPacket = [];
//   List<List<String>> basalPacket = [];
//   List<List<String>> smartBolus = [];
//   var checkData = data.substring(startIndex.length, data.length - 1);
//   print("The check data is $checkData");
//   var finalData = checkData.split("|");
//   var lists = <List<String>>[];
// print("the final Data is ${finalData}");
//   for (var values in finalData) {
//     var subList = values.split(",");
//     lists.add(subList);
//   }
//   for (var i = 0; i < lists.length; i++) {
//     if (i == 0) {
//       bolusPacket.add(lists[i]);
//     } else if (i == 1) {
//       basalPacket.add(lists[i]);
//     } else if (i == 2) {
//       smartBolus.add(lists[i]);
//     }
//   }
//   // Display the packets
//   print("The Bolus packet is $bolusPacket");
//   print("The Basal packet is $basalPacket");
//   print("The smartBolus packet is $smartBolus");



          print('ack found2 ${ackNotifier.value}');
          if (utf8.decode(data).contains('ACK')) {
            ackNotifier.value = true;
            notifyListeners();
          } else {
            ackNotifier.value = false;
            notifyListeners();
          }
        }
      }
    } catch (e) {
      print(e);
    }
  }

  BluetoothCharacteristic? findCharacteristic(String characteristicUuid) {
    for (BluetoothService service in _services!) {
      for (BluetoothCharacteristic characteristic in service.characteristics) {
        if (characteristic.uuid.toString() == characteristicUuid) {
          return characteristic;
        }
      }
    }
    return null;
  }

  void dispose() {
    _scanResultsSubscription.cancel();
    super.dispose();
  }
}
