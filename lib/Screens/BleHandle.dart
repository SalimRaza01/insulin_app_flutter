// import 'dart:async';
// import 'dart:convert';

// import 'package:flutter/material.dart';
// import 'package:flutter_blue_plus/flutter_blue_plus.dart';
// import 'package:newproject/Screens/BasalWizard.dart';
// import 'package:newproject/Screens/bluetooth_off_screen.dart';
// import 'package:newproject/utils/extra.dart';

// enum BleType { RF_BMS02, HM10, BLE_02, BLE_ESP32 }

// class Blehandler extends StatefulWidget {
//   final BluetoothDevice device;
//   const Blehandler({super.key, required this.device});

//   @override
//   State<Blehandler> createState() => _BlehandlerState();
// }

// class _BlehandlerState extends State<Blehandler> {
//   late BluetoothDevice device;
//   BluetoothConnectionState _connectionState = BluetoothConnectionState.disconnected;
//   List<BluetoothService> _services = [];

//   @override
//   void initState() {
//     super.initState();

//     device = widget.device;
//     getServices();
//     print('this is my device $device');
//   }

//   void getServices() async {
//     print('get Services from device');
//     _services = await device.discoverServices();
//     print('services obtained: $_services');
//   }

//   List<Widget> _buildServiceTiles(BuildContext context, BluetoothDevice d) {
//     return _services
//         .map(
//           (s) => ServiceTile(
//             service: s,
//             characteristicTiles: s.characteristics
//                 .map((c) => _buildCharacteristicTile(c))
//                 .toList(),
//           ),
//         )
//         .toList();
//   }

//   CharacteristicTile _buildCharacteristicTile(BluetoothCharacteristic c) {
//     return CharacteristicTile(
//       characteristic: c,
//       descriptorTiles:
//           c.descriptors.map((d) => DescriptorTile(descriptor: d)).toList(),
//     );
//   }

//   bool get isConnected {
//     return _connectionState == BluetoothConnectionState.connected;
//   }

//   BluetoothCharacteristic? findCharacteristic(String characteristicUuid) {
//     for (BluetoothService service in _services) {
//       for (BluetoothCharacteristic characteristic in service.characteristics) {
//         if (characteristic.uuid.toString() == characteristicUuid) {
//           return characteristic;
//         }
//       }
//     }
//     return null;
//   }

//   Future<void> onWritePressed(String characteristicUuid, String text) async {
//     try {
//       BluetoothCharacteristic? c = findCharacteristic(characteristicUuid);
//       if (c != null) {
//         await c.write(utf8.encode(text),
//             withoutResponse: c.properties.write);
//         print('Writing success');
//         if (c.properties.read) {
//           await c.read();
//         }
//       } else {
//         print('Characteristic not found');
//       }
//     } catch (e) {
//       print('Writing error: $e');
//     }
//   }



//   @override
//   Widget build(BuildContext context) {
//     return BasalWizard(onWritePressed: onWritePressed);
//   }
// }
