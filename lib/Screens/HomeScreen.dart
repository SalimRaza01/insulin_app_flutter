// ignore_for_file: file_names, prefer_const_constructors, prefer_const_literals_to_create_immutables, unnecessary_new

import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:newproject/Screens/BasalWizard.dart';
import 'package:newproject/Screens/BolusWizard.dart';
import 'package:newproject/Screens/InsulinScreen.dart';
import 'package:newproject/Screens/NutritionScreen.dart';
import 'package:newproject/Screens/WeightScreen.dart';
import 'package:newproject/Screens/smartbolusScreen.dart';
import 'package:newproject/Widgets/BasalGraph.dart';
import 'package:newproject/Widgets/BatteryStatus.dart';
import 'package:newproject/Widgets/BolusGraph.dart';
import 'package:newproject/Widgets/InsulinChart.dart';
import 'package:newproject/Widgets/ShimmerEffect.dart';
import 'package:newproject/Widgets/WeightChart.dart';
import 'package:newproject/utils/SharedPrefsHelper.dart';
import 'package:newproject/utils/CharacteristicProvider.dart';
import 'package:newproject/utils/Colors.dart';
import 'package:newproject/utils/DeviceConnectProvider.dart';
import 'package:newproject/utils/DeviceProvider.dart';
import 'package:newproject/utils/Drawer.dart';
import 'package:newproject/utils/NutritionNotifier.dart';
import 'package:newproject/utils/ReadNotifier.dart';
import 'package:newproject/utils/config.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:top_modal_sheet/top_modal_sheet.dart';
import 'GlucoseScreen.dart';
import '../Widgets/GlucoseChart.dart';
import '../Widgets/TodaysStatus.dart';
import '../Widgets/SmartBolusWidget.dart';
import '../Widgets/ResservoirWidget.dart';

class HomeScreen extends StatefulWidget {
  // final BluetoothDevice device;

  HomeScreen({
    super.key,
  });

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<String> periods = ['24 Hours', 'Week', 'Month'];
  int currentIndex = 0;
  late Future<List<ExpenseData>> chartData;
  final pref = SharedPrefsHelper();

  BluetoothAdapterState _adapterState = BluetoothAdapterState.unknown;
  String ecn = '';
  Timer? _connectionCheckTimer;
  BluetoothDevice? agvaDevice;
  String finalString = 'cm+sync';
  static String characteristicUuid = "beb5483e-36e1-4688-b7f5-ea07361b26a8";
  late StreamSubscription<BluetoothConnectionState>? _stateSubscription;
  BluetoothConnectionState _connectionState =
      BluetoothConnectionState.disconnected;
  List<BluetoothService>? _services = [];
  List<ScanResult> _scanResults = [];
  late StreamSubscription<List<ScanResult>> _scanResultsSubscription;
  late StreamSubscription<bool> _isScanningSubscription;
  late StreamSubscription<BluetoothAdapterState> _adapterStateStateSubscription;

  bool _isScanning = false;
  String reservoirValue = '';
  bool isDeviceConnected = false;
  String? weight;
  var indexClicked = 0;

  Future<void> getUserDetails() async {
    print('API HIT');
    final _sharedPreference = SharedPrefsHelper();
    final dio = Dio();

    final String? userId = await _sharedPreference.getString('userId');
    print('$getprofile/$userId');

    final response = await dio.get('$getprofile/$userId');

    if (response.statusCode == 200) {
      var data = response.data['data'];
      SharedPrefsHelper().putString('firstName', data['firstName']);
      SharedPrefsHelper().putString('lastName', data['lastName']);
    } else {
      throw Exception('Failed to load profile data: ${response.statusCode}');
    }
  }

  @override
  void initState() {
    super.initState();

    getUserDetails();
    chartData = _fetchChartData(periods[currentIndex]);
    _adapterStateStateSubscription =
        FlutterBluePlus.adapterState.listen((state) {
      _adapterState = state;
      onRefresh();
      print('adapterState $state');
    });

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final deviceNotifier =
          Provider.of<Deviceprovider>(context, listen: false);
      if (deviceNotifier.getdevice != null) {
        agvaDevice = deviceNotifier.getdevice;
        print('my new device $agvaDevice && ${deviceNotifier.getdevice}');
        getServices();
        _startConnectionCheckTimer(agvaDevice!);
      }
    });

    _scanResultsSubscription = FlutterBluePlus.scanResults.listen((results) {
          print('inside scanresult');
      _scanResults = results;
         print('inside scanresult 2 $results');
      for (ScanResult r in _scanResults) {
        print('inside scanresult 3 ${r.device.platformName}');
        if (r.device.platformName.contains('AgVa')) {
          agvaDevice = r.device;

          if (FlutterBluePlus.isScanningNow) {
                   print('inside scanresult 4');
            FlutterBluePlus.stopScan();
            Future.delayed(Duration(seconds: 2), () {
              popupDevice(context, agvaDevice!);
            });

            // onConnectPressed(r.device);
            _connectToDevice(r.device);
          }
          print('this is my device $agvaDevice');

          break;
        } else {
          print("HERE IT IS _scanResults outside");
        }
      }
    });

    _isScanningSubscription = FlutterBluePlus.isScanning.listen((state) {
      print('scanning is running');
      _isScanning = state;
      if (mounted) {
        setState(() {});
      }
    });
  }

  void _connectToDevice(BluetoothDevice device) async {
    await device.connect();

    _startConnectionCheckTimer(device);
  }

  void _notifyUser(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  void _startConnectionCheckTimer(BluetoothDevice device) {
    _connectionCheckTimer = Timer.periodic(Duration(seconds: 1), (timer) async {
      var state = await device.connectionState.first;
      if (state == BluetoothConnectionState.disconnected) {
        // _notifyUser("Device disconnected");
        onRefresh();
        BluetoothDevice? agvaDevice = null;
        Provider.of<Deviceprovider>(context, listen: false)
            .updateDevice(agvaDevice);
        setState(() {
          isDeviceConnected = false;
          Provider.of<Deviceconnection>(context, listen: false)
              .getDeviceConnection(isDeviceConnected);
        });
        timer.cancel();
      }
    });
  }

  @override
  void dispose() {
    _adapterStateStateSubscription.cancel();
    _scanResultsSubscription.cancel();
    _isScanningSubscription.cancel();
    super.dispose();
  }

  Future onRefresh() {
    print("Scanning is running");
    if (_isScanning == false) {
               print('Scanning');
      FlutterBluePlus.startScan(timeout: const Duration(seconds: 3));
    }
    if (mounted) {}
    return Future.delayed(Duration(milliseconds: 500));
  }

  getServices() async {
    print('get Services from device');
    _services = await agvaDevice?.discoverServices();
    print('services obtained: $_services');

    if (_services != null) {
      onCharacteristicChecked(characteristicUuid, finalString, true);
      Provider.of<CharacteristicProvider>(context, listen: false)
          .getFunction(onCharacteristicChecked);
      print('written code');
    } else {
      print('services are null');
    }
  }

  BluetoothCharacteristic? findCharacteristic(String characteristicUuid) {
    for (BluetoothService service in _services!) {
      for (BluetoothCharacteristic chr in service.characteristics) {
        print("the chracteristic is ${chr}");
        if (chr.uuid.toString() == characteristicUuid) {
          return chr;
        }
      }
    }
    return null;
  }

  Future<void> onCharacteristicChecked(
      String characteristicUuid, String text, bool isRead) async {
    try {
      BluetoothCharacteristic? c = findCharacteristic(characteristicUuid);

      if (c != null) {
        print('this is my BLE CHAR $c');
        if (agvaDevice != null) {
          setState(() {
            isDeviceConnected = true;
            Provider.of<Deviceconnection>(context, listen: false)
                .getDeviceConnection(isDeviceConnected);

            Provider.of<Deviceprovider>(context, listen: false)
                .updateDevice(agvaDevice);
          });
        }
        if (!isRead) {
          await c.write(utf8.encode(text), withoutResponse: false, timeout: 10);
          // await Future.delayed(Duration(seconds: 2), () {
          //   print('inside writing code');

          // setState(() {
          //   isDeviceConnected = true;
          //   if (agvaDevice != null) {
          //     Provider.of<Deviceprovider>(context, listen: false)
          //         .updateDevice(agvaDevice);
          //   }
          // });
          // });
        } else {
          var enco = await c.read();

          var dec = utf8.decode(enco);

          print("This is decoded data $dec");

          if (dec.contains('ACK')) {
            setState(() {
              bool ackFound = true;
              isDeviceConnected = true;
              Provider.of<ReadNotifier>(context, listen: false)
                  .updateDec(ackFound);
              if (agvaDevice != null) {
                Provider.of<Deviceprovider>(context, listen: false)
                    .updateDevice(agvaDevice);
              }
            });
          } else {}

          print('encoooo $dec');
        }
      } else {}
    } catch (e) {
      log("this is error ${e}");
    }
  }

  bool showBatteryInfo = false;
  bool showPatchInfo = false;
  String _topModalData = "";
  String _deviceStatus = "";

  void _notifyUserweight(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
          duration: Duration(milliseconds: 600),
          backgroundColor: Colors.blue,
          content: Center(
              child: Text(
            message,
            style: TextStyle(fontSize: 17),
          ))),
    );
  }

  Future<List<ExpenseData>> _fetchChartData(String period) async {
    final dio = Dio();
    String filter;

    if (period == "24 Hours") {
      filter = 'today';
    } else if (period == "Week") {
      filter = 'weekly';
    } else if (period == "Month") {
      filter = 'monthly';
    } else {
      throw Exception('Invalid period');
    }

    print(filter);

    final _sharedPreference = SharedPrefsHelper();
    final String? userId = await _sharedPreference.getString('userId');

    final response = await dio.get(
      '$nutritionalData/$userId',
      queryParameters: {'filter': filter},
    );
    if (response.statusCode == 200) {
      print('api hit nutrition');
      final responseData = response.data['data'] as List;
      return responseData.map((item) => ExpenseData.fromJson(item)).toList();
    } else {
      throw Exception('Failed to load data');
    }
  }

  void _updateChartData() {
    setState(() {
      currentIndex = (currentIndex + 1) % periods.length;
      chartData = _fetchChartData(periods[currentIndex]);
    });
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return Consumer<NutritionChartNotifier>(builder: (context, value, child) {
      if (value.nutritionStatus == true) {
        chartData = _fetchChartData(periods[currentIndex]);
        Provider.of<NutritionChartNotifier>(context, listen: false)
            .nutritionUpdate(false);
      }

      return Scaffold(
        backgroundColor: Theme.of(context).colorScheme.onPrimary,
        appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.white),
          backgroundColor: Theme.of(context).colorScheme.secondary,
          actions: <Widget>[
            GestureDetector(
              onTap: () => {
                // print('this is show dialog box $agvaDevice'),
                if (_adapterState == BluetoothAdapterState.off)
                  {
                    print('this show BluetoothAdapterState $_adapterState'),
                    showModalBottomSheet<void>(
                      context: context,
                      builder: (BuildContext context) {
                        return Container(
                          height: height * 0.2,
                          decoration: BoxDecoration(
                            color: Color.fromARGB(255, 31, 29, 87),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(20),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Bluetooth is turned off",
                                      style: TextStyle(
                                        fontSize: 20,
                                        color: Theme.of(context)
                                            .colorScheme
                                            .primary,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    Text(
                                      "Please turn on your bluetooth to connect insulin ",
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: Theme.of(context)
                                            .colorScheme
                                            .primary,
                                      ),
                                    ),
                                  ],
                                ),
                                Icon(
                                  Icons.bluetooth_disabled,
                                  size: 40,
                                  color: Theme.of(context).colorScheme.primary,
                                )
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  }
                else if (isDeviceConnected == false && agvaDevice == null)
                  {print("Device not connected"), onRefresh()}
              },
              child: Image.asset(
                setImage(isDeviceConnected),
                width: 25,
              ),
            ),
            SizedBox(
              width: 25,
            ),
            GestureDetector(
              onTap: _addBloodCount,
              child: Image.asset(
                'assets/images/notifi.png',
                height: 22,
              ),
            ),
            SizedBox(
              width: 20,
            )
          ],
        ),
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Column(
              children: [
                //Today's_Status_Widget
                SizedBox(height: height * 0.020),
                GestureDetector(child: TodaysStatus()),

                SizedBox(height: height * 0.015),
                //Avarage_Insulin_Intake_Widget

                GestureDetector(
                    onTap: () {
                      if (isDeviceConnected == true) {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SmartBolusScreen()));
                      } else {
                        _noDeviceFoundTopModel();
                      }
                    },
                    child: SmartBolusWidget()),

                SizedBox(height: height * 0.015),
                GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => NutritionScreen()));
                    },
                    child: newMethod(height, width)),

                SizedBox(height: height * 0.015),

                GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => WeightScreen()));
                    },
                    child: WeightChart()),

                SizedBox(height: height * 0.015),

                //GlucoseChart_Widget
                GestureDetector(
                    onTap: () {
                      if (isDeviceConnected == true) {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => GlucoseScreen(
                                      agvaDevice: agvaDevice,
                                    )));
                      } else {
                        _noDeviceFoundTopModel();
                      }
                    },
                    child: Glucosechart()),

                SizedBox(height: height * 0.015),
                GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => InsulinScreen()));
                    },
                    child: Insulinchart()),

                SizedBox(height: height * 0.015),
                //InsulinkChart_Widget
                GestureDetector(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => BasalWizard()));
                  },
                  child: Basalgraph(),
                ),
                SizedBox(height: height * 0.015),

                GestureDetector(
                  onTap: () async {
                    await Navigator.push(context,
                        MaterialPageRoute(builder: (context) => BolusWizard()));
                  },
                  child: Bolusgraph(),
                ),
                SizedBox(height: height * 0.015),

                RessorvoirWidget(),

                SizedBox(height: height * 0.015),
                //Bettery_Widget
                BatteryStatus(),
                SizedBox(height: height * 0.015),
                //Patch_Widget
              ],
            ),
          ),
        ),
        drawer: AppDrawerNavigation('HOMESCREEN'),
      );
    });
  }

  newMethod(double height, double width) {
    return Container(
      height: height * 0.28,
      width: width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: Theme.of(context).colorScheme.primary,
      ),
      child: Padding(
        padding: EdgeInsets.only(top: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'NUTRITION',
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.primaryContainer,
                      fontSize: height * 0.015,
                      fontWeight: AppColor.weight600,
                    ),
                  ),
                  GestureDetector(
                    onTap: _updateChartData,
                    child: Text(
                      periods[currentIndex],
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.primaryContainer,
                        fontSize: height * 0.015,
                        fontWeight: AppColor.weight600,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: height * 0.01),
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _buildLegend('Carbs', quickWorkoutColor),
                    _buildLegend('Protein', cyclingColor),
                    _buildLegend('Fats', pilateColor),
                  ],
                ),
                FutureBuilder<List<ExpenseData>>(
                  future: chartData,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return ShimmereffectGraph();
                    } else if (snapshot.hasError) {
                      return _buildErrorWidget(height, 'Error found');
                    } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                      return _buildErrorWidget(height, 'No Data found');
                    } else {
                      return SizedBox(
                        height: height * 0.19,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 30),
                          child: SfCartesianChart(
                            margin: EdgeInsets.all(0),
                            plotAreaBorderWidth: 0.0,
                            legend: Legend(isVisible: false),
                            series: <CartesianSeries>[
                              StackedColumnSeries<ExpenseData, String>(
                                  borderRadius: BorderRadius.circular(50),
                                  color: quickWorkoutColor,
                                  width: periods[currentIndex] == 'Week'
                                      ? 0.2
                                      : 0.7,
                                  dataSource: snapshot.data,
                                  xValueMapper: (ExpenseData exp, _) =>
                                      exp.expenseCategory,
                                  yValueMapper: (ExpenseData exp, _) =>
                                      exp.carbs,
                                  markerSettings: MarkerSettings(
                                    isVisible: false,
                                  )),
                              StackedColumnSeries<ExpenseData, String>(
                                  borderRadius: BorderRadius.circular(50),
                                  color: cyclingColor,
                                  width: periods[currentIndex] == 'Week'
                                      ? 0.2
                                      : 0.7,
                                  dataSource: snapshot.data,
                                  xValueMapper: (ExpenseData exp, _) =>
                                      exp.expenseCategory,
                                  yValueMapper: (ExpenseData exp, _) =>
                                      exp.protein,
                                  markerSettings: MarkerSettings(
                                    isVisible: false,
                                  )),
                              StackedColumnSeries<ExpenseData, String>(
                                  borderRadius: BorderRadius.circular(50),
                                  color: pilateColor,
                                  width: periods[currentIndex] == 'Week'
                                      ? 0.2
                                      : 0.7,
                                  dataSource: snapshot.data,
                                  xValueMapper: (ExpenseData exp, _) =>
                                      exp.expenseCategory,
                                  yValueMapper: (ExpenseData exp, _) => exp.fat,
                                  markerSettings: MarkerSettings(
                                    isVisible: false,
                                  )),
                            ],
                            primaryXAxis: CategoryAxis(
                              labelAlignment: LabelAlignment.center,
                              labelPlacement: LabelPlacement.onTicks,
                              interval: 1,
                              axisLine: AxisLine(width: 0.0),
                              placeLabelsNearAxisLine: false,
                              labelStyle: TextStyle(
                                  color: Theme.of(context)
                                      .colorScheme
                                      .primaryContainer),
                              borderColor: Theme.of(context)
                                  .colorScheme
                                  .primaryContainer,
                              majorTickLines: const MajorTickLines(width: 0),
                              majorGridLines: MajorGridLines(
                                width: 0.0,
                              ),
                            ),
                            primaryYAxis: CategoryAxis(
                              isVisible: false,
                              axisLine: AxisLine(width: 0.0),
                            ),
                          ),
                        ),
                      );
                    }
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLegend(String label, Color color) {
    return Row(
      children: [
        Text(
          label,
          style: TextStyle(
            color: Theme.of(context).colorScheme.primaryContainer,
            fontSize: 13,
            fontWeight: AppColor.weight600,
          ),
        ),
        SizedBox(width: 10),
        Container(
          decoration: BoxDecoration(
              color: color, borderRadius: BorderRadius.circular(50)),
          height: 12,
          width: 12,
        ),
      ],
    );
  }

  Widget _buildErrorWidget(double height, String message) {
    return SizedBox(
      height: height * 0.15,
      child: Center(
        child: Text(
          message,
          style: TextStyle(
              color: Theme.of(context).colorScheme.secondaryContainer),
        ),
      ),
    );
  }

  Future<void> popupDevice(BuildContext context, BluetoothDevice device) {
    return showModalBottomSheet<void>(
        context: context,
        builder: (BuildContext context) {
          final height = MediaQuery.of(context).size.height;
          final width = MediaQuery.of(context).size.width;
          return Container(
            height: height * 0.42,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(35),
                    topRight: Radius.circular(35))),
            child: Padding(
                padding: EdgeInsets.all(16),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: width * 0.06,
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 10),
                          child: Text(
                            "AgVa Insul",
                            style: TextStyle(
                              fontSize: height * 0.035,
                              fontWeight: FontWeight.w300,
                              color: const Color.fromARGB(150, 0, 0, 0),
                              // fontFamily: 'Adventure',
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Image.asset(
                            'assets/images/ic_remove.png',
                            width: width * 0.06,
                          ),
                        ),
                      ],
                    ),
                    Container(
                        height: height * 0.25,
                        width: width * 0.7,
                        child: Image.asset(
                          'assets/images/insulin4D.gif',
                          // fit: BoxFit.cover,
                        )),
                    Center(
                      child: GestureDetector(
                        onTap: () {
                          getServices();

                          Navigator.pop(context);
                        },
                        child: Container(
                          height: height * 0.05,
                          width: width * 0.7,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: AppColor.backgroundColor,
                            border: Border.all(
                              color: Color.fromARGB(255, 255, 255, 255),
                            ),
                          ),
                          child: Center(
                              child: Text(
                            'Connect',
                            style: TextStyle(
                                color: const Color.fromARGB(150, 0, 0, 0),
                                fontSize: height * 0.02),
                          )),
                        ),
                      ),
                    ),
                  ],
                )),
          );
        });
  }

  String setImage(isDeviceConnected) {
    if (isDeviceConnected) {
      return 'assets/images/insulin_connected.png';
    }   else if (_isScanning) {
      return 'assets/images/scanning.gif';
    } else {
      return 'assets/images/insulinIcon.png';
    }
  }



  void showPopupMenu(BuildContext context) {
    showMenu(
      context: context,
      position: RelativeRect.fromLTRB(80, 180, 20, 0),
      items: [
        PopupMenuItem(
          child: Text(
            'Battery Info',
            style: TextStyle(
              color: Theme.of(context).colorScheme.primary,
              // fontSize: 14,
            ),
          ),
          onTap: () {
            setState(() {
              showBatteryInfo = true;
            });
          },
        ),
        PopupMenuItem(
          child: Text(
            'Insulin Patch',
            style: TextStyle(
              color: Theme.of(context).colorScheme.primary,
              // fontSize: 14,
            ),
          ),
          onTap: () {
            setState(() {
              showPatchInfo = true;
            });
          },
        ),
      ],
      elevation: 8.0,
      color: Theme.of(context).colorScheme.secondary,
    );
  }

  Future<void> _addBloodCount() async {
    final value = await showTopModalSheet<String?>(
      context,
      BloodCount(),
      backgroundColor: Theme.of(context).colorScheme.primary,
      borderRadius: const BorderRadius.vertical(
        bottom: Radius.circular(20),
      ),
    );

    if (value != null) setState(() => _topModalData = value);
  }

  Future<void> _noDeviceFoundTopModel() async {
    final value = await showTopModalSheet<String?>(
      context,
      NoDeviceFound(),
      backgroundColor: Theme.of(context).colorScheme.primary,
      borderRadius: const BorderRadius.vertical(
        bottom: Radius.circular(20),
      ),
    );

    if (value != null) setState(() => _topModalData = value);
  }

  Future<void> _insulintopModel() async {
    final value = await showTopModalSheet<String?>(
      context,
      InsulinTopModel(),
      backgroundColor: Theme.of(context).colorScheme.primary,
      borderRadius: const BorderRadius.vertical(
        bottom: Radius.circular(20),
      ),
    );

    if (value != null) setState(() => _topModalData = value);
  }

  Future _showDeviceModal() async {
    final value = await showTopModalSheet<String?>(
      context,
      DeviceStatusModal(),
      backgroundColor: Theme.of(context).colorScheme.primary,
      borderRadius: const BorderRadius.vertical(
        bottom: Radius.circular(20),
      ),
    );

    if (value != null) setState(() => _deviceStatus = value);
  }
}

class InsulinTopModel extends StatelessWidget {
  const InsulinTopModel({Key? key}) : super(key: key);

  static const _values = ["CF Cruz Azul", "Monarcas FC"];

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: const Color.fromARGB(255, 204, 16, 2)),
      child: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              SizedBox(
                height: 30,
              ),
              Text(
                "Insulin battery remaining",
                style: TextStyle(
                    fontSize: 20, color: Theme.of(context).colorScheme.primary),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                "10 %",
                style: TextStyle(
                    fontSize: 35,
                    color: Theme.of(context).colorScheme.primary,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                "updated at 10:30 AM ",
                style: TextStyle(
                    fontSize: 15, color: Theme.of(context).colorScheme.primary),
              ),
            ]),
            Icon(
              Icons.warning_rounded,
              size: 70,
              color: Theme.of(context).colorScheme.primary,
            )
          ],
        ),
      ),
    );
  }
}

class BloodCount extends StatelessWidget {
  TextEditingController bloodCountController = TextEditingController();
  TextEditingController bloodPressureController = TextEditingController();
  SharedPrefsHelper pref = SharedPrefsHelper();

  BloodCount({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Container(
      width: width,
      decoration: BoxDecoration(
        color: Color.fromARGB(255, 226, 122, 0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          SizedBox(
            height: height * 0.035,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "WANT TO ADD",
                    style: TextStyle(
                        fontSize: height * 0.02,
                        color: Colors.white,
                        fontWeight: FontWeight.w300),
                  ),
                  Text(
                    "Blood count & Blood pressure !".toUpperCase(),
                    style: TextStyle(
                        fontSize: height * 0.015,
                        color: Colors.white,
                        fontWeight: FontWeight.w500),
                  ),
                ],
              ),
              SizedBox(
                width: width * 0.01,
              ),
              Icon(
                Icons.water_drop,
                size: height * 0.05,
                color: Colors.white,
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20, top: 30),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Text(
                    'NOT NOW',
                    style: TextStyle(
                      fontSize: height * 0.015,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                    showModalBottomSheet(
                        backgroundColor: Theme.of(context).colorScheme.primary,
                        context: context,
                        builder: (BuildContext context) {
                          final height = MediaQuery.of(context).size.height;
                          final width = MediaQuery.of(context).size.width;
                          return StatefulBuilder(builder:
                              (BuildContext context, StateSetter setState) {
                            return Container(
                              height: height * 0.36,
                              width: width,
                              child: Padding(
                                padding: EdgeInsets.all(20),
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.all(10),
                                      child: Container(
                               
                                        decoration: BoxDecoration(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .onSurface,
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        child: Row(
                                          children: [
                                            SizedBox(
                                              width: width * 0.03,
                                            ),
                                            Icon(Icons.water_drop_outlined),
                                            SizedBox(
                                              width: width * 0.03,
                                            ),
                                            SizedBox(
                                                             width: width / 6,
                                              child: TextField(
                                                keyboardType:
                                                    TextInputType.number,
                                                cursorColor: Theme.of(context)
                                                    .colorScheme
                                                    .onInverseSurface,
                                                style: TextStyle(
                                                  color: Theme.of(context)
                                                      .colorScheme
                                                      .onInverseSurface,
                                                ),
                                                controller: bloodCountController,
                                                decoration: InputDecoration(
                                                    border: InputBorder.none,
                                                    hintText: 'Enter Blood Count'
                                                        .toUpperCase(),
                                                    hintStyle: TextStyle(
                                                        fontWeight:
                                                            FontWeight.w200)),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: height * 0.01,
                                    ),
                                    Padding(
                                      padding: EdgeInsets.all(10),
                                      child: Container(
                               
                                        decoration: BoxDecoration(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .onSurface,
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        child: Row(
                                          children: [
                                            SizedBox(
                                              width: width * 0.03,
                                            ),
                                            Icon(Icons.water_drop_outlined),
                                            SizedBox(
                                              width: width * 0.03,
                                            ),
                                            SizedBox(
                                                             width: width / 6,
                                              child: TextField(
                                                keyboardType:
                                                    TextInputType.number,
                                                cursorColor: Theme.of(context)
                                                    .colorScheme
                                                    .onInverseSurface,
                                                style: TextStyle(
                                                  color: Theme.of(context)
                                                      .colorScheme
                                                      .onInverseSurface,
                                                ),
                                                controller: bloodPressureController,
                                                decoration: InputDecoration(
                                                    border: InputBorder.none,
                                                    hintText: 'Enter Blood Pressure'
                                                        .toUpperCase(),
                                                    hintStyle: TextStyle(
                                                        fontWeight:
                                                            FontWeight.w200)),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: height * 0.05,
                                    ),
                                    Center(
                                      child: GestureDetector(
                                        onTap: () {
                                          pref.putString('BloodSugarCount',
                                              bloodCountController.text);
                                          pref.putString('BloodPressure',
                                              bloodPressureController.text);
                                          Navigator.pop(context);
                                        },
                                        child: Container(
                                          height: height * 0.05,
                                          width: width * 0.4,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            color:
                                                Color.fromARGB(255, 5, 53, 93),
                                          ),
                                          child: Center(
                                              child: Text(
                                            'SUBMIT',
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: height * 0.02),
                                          )),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          });
                        });
                  },
                  child: Text(
                    'CHECK',
                    style: TextStyle(
                      fontSize: height * 0.015,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          )
        ]),
      ),
    );
  }
}

class DeviceStatusModal extends StatelessWidget {
  const DeviceStatusModal({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: Color.fromARGB(255, 4, 137, 239)),
      child: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              SizedBox(
                height: 30,
              ),
              Text(
                "Bluetooth is turned off",
                style: TextStyle(
                    fontSize: 20, color: Theme.of(context).colorScheme.primary),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                "Please turn your Bluetooth",
                style: TextStyle(
                    fontSize: 10, color: Theme.of(context).colorScheme.primary),
              ),
            ]),
            Icon(Icons.bluetooth_disabled)
          ],
        ),
      ),
    );
  }
}

final pilateColor = const Color.fromARGB(255, 255, 0, 92); // Fat
final cyclingColor = const Color.fromARGB(255, 0, 156, 156); // Protein
final quickWorkoutColor = const Color.fromARGB(255, 236, 170, 0); // Carbs
final betweenSpace = 0.2;

class ExpenseData {
  ExpenseData(this.expenseCategory, this.carbs, this.protein, this.fat);
  final String expenseCategory;
  final num carbs;
  final num protein;
  final num fat;

  factory ExpenseData.fromJson(Map<String, dynamic> json) {
    return ExpenseData(
      json['time'],
      num.parse(json['Carbs']),
      num.parse(json['Protein']),
      num.parse(json['Fat']),
    );
  }
}
