import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:newproject/Middleware/API.dart';
import 'package:newproject/Widgets/Buttons.dart';
import 'package:newproject/utils/CharacteristicProvider.dart';
import 'package:newproject/utils/Colors.dart';
import 'package:newproject/utils/DeviceProvider.dart';
import 'package:newproject/utils/Drawer.dart';
import 'package:newproject/utils/ReadNotifier.dart';
import 'package:newproject/utils/SharedPrefsHelper.dart';
import 'package:newproject/utils/popover.dart';
import 'package:provider/provider.dart';
import 'dart:convert';
import 'package:newproject/Widgets/BolusGraph.dart';

class DoseEntry {
  final double dose;
  final DateTime timestamp;

  DoseEntry({required this.dose, required this.timestamp});

  Map<String, dynamic> toJson() => {
        'dose': dose,
        'timestamp': timestamp.toIso8601String(),
      };

  static DoseEntry fromJson(Map<String, dynamic> json) => DoseEntry(
        dose: json['dose'],
        timestamp: DateTime.parse(json['timestamp']),
      );
}

class BolusWizard extends StatefulWidget {
  @override
  State<BolusWizard> createState() => _BolusWizardState();
}

class _BolusWizardState extends State<BolusWizard> {
  TextEditingController activeInsulinController = TextEditingController();
  bool showlist = false;
  double cb = 0.0;
  double ins = 0.0;
  double dose = 0.0;
  bool showDialogStatus = false;
  AlertDialog? dialogOne;
  String char = 'beb5483e-36e1-4688-b7f5-ea07361b26a8';
  String cmd = 'cm+sync';
  List<DoseEntry> doseHistory = [];
  final prefs = SharedPrefsHelper();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  double initialInsulinValue = 0.0;

  @override
  void initState() {
    super.initState();
    _loadDoseHistory();
    _loadInitialValue();
  }

  Future<void> _saveInitialValue(double value) async {
    double updatedValue = initialInsulinValue + value;
    await prefs.setDouble('dose', updatedValue);
    print('dosage updated');
    setState(() {
      initialInsulinValue = updatedValue;
    });
  }

  void _loadInitialValue() {
    double? storedValue = prefs.getDouble('dose');
    setState(() {
      initialInsulinValue = storedValue ?? 0.0;
    });
  }

  Future<void> _loadDoseHistory() async {
    final String? doseHistoryString = prefs.getString('doseHistory');
    if (doseHistoryString != null) {
      final List<dynamic> doseHistoryJson = jsonDecode(doseHistoryString);
      setState(() {
        doseHistory =
            doseHistoryJson.map((json) => DoseEntry.fromJson(json)).toList();
      });
    } else {
      setState(() {
        doseHistory = [];
      });
    }
  }

  Future<void> _saveDoseHistory() async {
    final String doseHistoryString =
        jsonEncode(doseHistory.map((entry) => entry.toJson()).toList());
    await prefs.putString('doseHistory', doseHistoryString);
  }

  Future<void> _deleteSharedPreference() async {
    await prefs.remove('doseHistory');

    _notifyUser('History Deleted');
  }

  _waitingDialogBox() {
    return showDialog<void>(
      context: _scaffoldKey.currentContext!,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Consumer<ReadNotifier>(
          builder: (context, readNotifier, child) {
            Future.delayed(Duration(seconds: 4), () {
              if (readNotifier.getack == true) {
                       _saveInitialValue(dose);
                addBolusUnit(activeInsulinController.text, context);

                ins = double.parse(activeInsulinController.text.toString());
                dose = ins;
                activeInsulinController.clear();
                // Save dose to history
                setState(() {
                  doseHistory.insert(
                      0, DoseEntry(dose: dose, timestamp: DateTime.now()));
                });
         
                _saveDoseHistory();
                Navigator.of(context).pop();
                _successDialogBox();
              } else {
                Navigator.of(context).pop();
                _failedDialogBox();
              }
            });

            return AlertDialog(
              title: Text(
                'BOLUS STATUS',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              icon: Icon(
                Icons.medical_information_sharp,
                color: Colors.white,
              ),
              backgroundColor: Theme.of(context).colorScheme.secondary,
              content: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'CHECK INSULIN DEVICE',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      'Please confirm on insulin device to deliver bolus instantly..',
                      style: TextStyle(color: Colors.white),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  void _notifyUser(String message) {
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

  _successDialogBox() {
    return showDialog<void>(
      context: _scaffoldKey.currentContext!,
      barrierDismissible: false,
      builder: (BuildContext context) {
        Future.delayed(Duration(seconds: 2), () {
          Navigator.of(context).pop();
          bool ackFound = false;
          Provider.of<ReadNotifier>(context, listen: false).updateDec(ackFound);
        });
        return AlertDialog(
          title: Text(
            'BOLUS STATUS',
            style: TextStyle(color: Colors.white),
          ),
          icon: Icon(
            Icons.verified,
            color: Colors.white,
          ),
          backgroundColor: Color.fromARGB(255, 6, 168, 0),
          content: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'BOLUS DELIVER SUCCESSFULL',
                  style: TextStyle(color: Colors.white),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  _failedDialogBox() {
    return showDialog<void>(
      context: _scaffoldKey.currentContext!,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'FAILED',
            style: TextStyle(color: Colors.white),
          ),
          icon: Icon(
            Icons.clear,
            color: Colors.white,
          ),
          backgroundColor: Color.fromARGB(255, 219, 0, 0),
          content: Text(
            'Please check your device and retry',
            style: TextStyle(color: Colors.white),
          ),
          actions: [
            ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text(
                  'close',
                  style: TextStyle(color: Colors.black),
                ))
          ],
        );
      },
    );
  }

  @override
  void dispose() {
    activeInsulinController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return Consumer2<CharacteristicProvider, Deviceprovider>(
        builder: (context, value, device, child) {
      return Scaffold(
        key: _scaffoldKey,
        drawer: AppDrawerNavigation('INSULIN'),
        backgroundColor: Theme.of(context).colorScheme.onPrimary,
        appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.white),
          actions: <Widget>[
            IconButton(
              icon: Icon(
                size: 30,
                Icons.history,
                color: Colors.white,
              ),
              tooltip: 'Comment Icon',
              onPressed: () {
                _loadDoseHistory();
                doseHistory.isNotEmpty
                    ? showModalBottomSheet(
                        context: context,
                        builder: (context) {
                          return Popover(
                            height: height * 0.4,
                            child: StatefulBuilder(
                              builder: (BuildContext context, setState) {
                                return Padding(
                                    padding: EdgeInsets.only(
                                        right: 30,
                                        left: 30,
                                        bottom: 10,
                                        top: 11),
                                    child: Column(
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              "Bolus History",
                                              style: TextStyle(
                                                  color: Theme.of(context)
                                                      .colorScheme
                                                      .onInverseSurface,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: height * 0.02),
                                            ),
                                            IconButton(
                                              onPressed: () {
                                                setState(
                                                  () {
                                                    _deleteSharedPreference();
                                                  },
                                                );
                                                Navigator.pop(context);
                                              },
                                              icon: Icon(
                                                Icons.delete,
                                                color: Theme.of(context)
                                                    .colorScheme
                                                    .onInverseSurface,
                                              ),
                                            )
                                          ],
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 0),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                'Dosage',
                                                style: TextStyle(
                                                  color: Theme.of(context)
                                                      .colorScheme
                                                      .onInverseSurface,
                                                ),
                                              ),
                                              Text(
                                                'Date',
                                                style: TextStyle(
                                                  color: Theme.of(context)
                                                      .colorScheme
                                                      .onInverseSurface,
                                                ),
                                              ),
                                              Text(
                                                'Time',
                                                style: TextStyle(
                                                  color: Theme.of(context)
                                                      .colorScheme
                                                      .onInverseSurface,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        SizedBox(
                                          width: width,
                                          child: Divider(
                                            thickness: 1,
                                            color: Colors.grey,
                                          ),
                                        ),
                                        SingleChildScrollView(
                                          child: Container(
                                            height: height * 0.24,
                                            child: ListView.builder(
                                              itemCount: doseHistory.length,
                                              itemBuilder:
                                                  (BuildContext context,
                                                      int index) {
                                                final entry =
                                                    doseHistory[index];
                                                final formattedTime =
                                                    DateFormat('HH:mm').format(
                                                        entry.timestamp);
                                                final formattedDate =
                                                    DateFormat('dd-MMM-yy')
                                                        .format(
                                                            entry.timestamp);
                                                return Padding(
                                                  padding: const EdgeInsets
                                                      .symmetric(vertical: 10),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Text(
                                                        ' Dose ${entry.dose}',
                                                        style: TextStyle(
                                                          color: Theme.of(
                                                                  context)
                                                              .colorScheme
                                                              .onInverseSurface,
                                                        ),
                                                      ),
                                                      Text(
                                                        formattedDate,
                                                        style: TextStyle(
                                                          color: Theme.of(
                                                                  context)
                                                              .colorScheme
                                                              .onInverseSurface,
                                                        ),
                                                      ),
                                                      Text(
                                                        formattedTime,
                                                        style: TextStyle(
                                                          color: Theme.of(
                                                                  context)
                                                              .colorScheme
                                                              .onInverseSurface,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                );
                                              },
                                            ),
                                          ),
                                        )
                                      ],
                                    ));
                              },
                            ),
                          );
                        },
                      )
                    : _notifyUser('No History Found');
              },
            ),
          ],
          backgroundColor: Theme.of(context).colorScheme.secondary,
          bottom: device.getdevice == null
              ? PreferredSize(
                  preferredSize: Size.fromHeight(35),
                  child: Container(
                    height: 35,
                    color: Colors.redAccent,
                    child: Center(
                      child: Text(
                        'DEVICE NOT CONNECTED',
                        style: TextStyle(
                          fontSize: height * 0.015,
                          fontWeight: FontWeight.w500,
                          color: Color.fromARGB(255, 255, 255, 255),
                        ),
                      ),
                    ),
                  ),
                )
              : PreferredSize(
                  preferredSize: Size.fromHeight(0),
                  child: SizedBox(),
                ),
        ),
        body: SingleChildScrollView(
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Bolus Wizard',
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.tertiary,
                          fontSize: height * 0.03),
                    ),
                  ],
                ),
                SizedBox(
                  height: height * 0.01,
                ),
                Bolusgraph(),
                SizedBox(
                  height: height * 0.02,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Icon(
                      Icons.info_outline,
                      color: Theme.of(context).colorScheme.tertiary,
                    ),
                    SizedBox(
                      child: Text(
                        'Basal Wizard automatically calculate the recommended dosage of insulin based on your meal intake',
                        style: TextStyle(
                            color: Theme.of(context).colorScheme.tertiary,
                            fontSize: height * 0.012),
                      ),
                      width: width * 0.8,
                    ),
                  ],
                ),
                SizedBox(
                  height: height * 0.02,
                ),
                device.getdevice != null
                    ? newMethod(
                        context, 'INSULIN', activeInsulinController, height)
                    : inActiveTextFields(context, 'INSULIN', height),
                SizedBox(
                  height: height * 0.04,
                ),
                Center(
                  child: device.getdevice != null
                      ? Buttons(
                          action: () {
                            // addBolusUnit(activeInsulinController.text, context);

                            // ins = double.parse(
                            //     activeInsulinController.text.toString());
                            // dose = ins;
                            // activeInsulinController.clear();
                            // // Save dose to history
                            // setState(() {
                            //   doseHistory.insert(
                            //       0,
                            //       DoseEntry(
                            //           dose: dose, timestamp: DateTime.now()));
                            // });

                            // _saveDoseHistory();
                            showModalBottomSheet(
                              context: context,
                              builder: (context) {
                                return Scaffold(
                                  backgroundColor:
                                      Theme.of(context).colorScheme.primary,
                                  body: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(20),
                                        topRight: Radius.circular(20),
                                      ),
                                    ),
                                    height: 650,
                                    child: Padding(
                                      padding: const EdgeInsets.all(20),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text(
                                                    'Recommendation',
                                                    style: TextStyle(
                                                      color: Theme.of(context)
                                                          .colorScheme
                                                          .tertiary,
                                                      fontSize: 20,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              SizedBox(
                                                height: 30,
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text(
                                                    'Estimated Bolus Units',
                                                    style: TextStyle(
                                                      color: Theme.of(context)
                                                          .colorScheme
                                                          .tertiary,
                                                      fontSize: 20,
                                                    ),
                                                  ),
                                                  Text(
                                                    '${dose.toInt()} units',
                                                    style: TextStyle(
                                                      color: Theme.of(context)
                                                          .colorScheme
                                                          .tertiary,
                                                      fontSize: 25,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              SizedBox(
                                                height: 30,
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceAround,
                                                children: [
                                                  SizedBox(
                                                    child: Icon(
                                                      Icons.info_outline,
                                                      color: Theme.of(context)
                                                          .colorScheme
                                                          .tertiary,
                                                    ),
                                                    height: 20,
                                                  ),
                                                  SizedBox(
                                                    child: Text(
                                                      'There values are calculated on basis of input provided to bolus wizard.',
                                                      style: TextStyle(
                                                        color: Theme.of(context)
                                                            .colorScheme
                                                            .tertiary,
                                                        fontSize: 10,
                                                      ),
                                                    ),
                                                    width: 300,
                                                  ),
                                                ],
                                              ),
                                              SizedBox(
                                                height: 30,
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceAround,
                                                children: [
                                                  SizedBox(
                                                    child: Icon(
                                                      Icons.info_outline,
                                                      color: Theme.of(context)
                                                          .colorScheme
                                                          .tertiary,
                                                    ),
                                                    height: 20,
                                                  ),
                                                  SizedBox(
                                                    child: Text(
                                                      'Use the recommended setting after taking the approval from your medical consultant (or doctor)',
                                                      style: TextStyle(
                                                        color: Theme.of(context)
                                                            .colorScheme
                                                            .tertiary,
                                                        fontSize: 10,
                                                      ),
                                                    ),
                                                    width: 300,
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                          GestureDetector(
                                            onTap: () {
                                              // widget.onCharacteristicChecked(
                                              //     char, cmd, false);

                                              Navigator.pop(context);
                                              _waitingDialogBox();

                                              value.getBLEfunctionaltity(
                                                  char, cmd, false);

                                              Future.delayed(
                                                  Duration(seconds: 2), () {
                                                value.getBLEfunctionaltity(
                                                    char, cmd, true);
                                                // widget.onCharacteristicChecked(
                                                //     char, cmd, true);
                                              });
                                            },
                                            child: Container(
                                              height: height * 0.06,
                                              width: width * 0.6,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                color: Theme.of(context)
                                                    .colorScheme
                                                    .tertiary,

                                                // boxShadow: [
                                                //   BoxShadow(
                                                //     color: Colors.grey,
                                                //     blurRadius: 10,
                                                //   ),
                                                // ]
                                              ),
                                              child: Center(
                                                  child: Text(
                                                'DELIVER BOLUS',
                                                style: TextStyle(
                                                    color: Theme.of(context)
                                                        .colorScheme
                                                        .onPrimary,
                                                    fontSize: height * 0.02),
                                              )),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              },
                            );
                          },
                          title: 'CALCULATE',
                        )
                      : Center(
                          child: Container(
                            height: height * 0.06,
                            width: width * 0.6,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: const Color.fromARGB(76, 158, 158, 158),
                            ),
                            child: Center(
                                child: Text(
                              'SUBMIT',
                              style: TextStyle(
                                  color: Color.fromARGB(77, 255, 255, 255),
                                  fontSize: height * 0.02),
                            )),
                          ),
                        ),
                )
              ],
            ),
          ),
        ),
      );
    });
  }

  newMethod(BuildContext context, String title,
      TextEditingController controller, double height) {
    return Container(
        height: 50,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Theme.of(context).colorScheme.primary,
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: TextStyle(
                    color: Theme.of(context).colorScheme.tertiary,
                    fontSize: 16),
              ),
              Icon(
                Icons.info_outline,
                color: Theme.of(context).colorScheme.tertiary,
              ),
              SizedBox(
                width: 100,
                height: 30,
                child: TextField(
                  cursorColor: Theme.of(context).colorScheme.onInverseSurface,
                  selectionControls: CupertinoTextSelectionControls(),
                  style: TextStyle(
                      color: Theme.of(context).colorScheme.onInverseSurface),
                  onTapOutside: (PointerDownEvent event) {
                    FocusManager.instance.primaryFocus?.unfocus();
                  },
                  controller: controller,
                  keyboardType: TextInputType.number,
                  textAlign: TextAlign.right,
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: '0 unit',
                      hintStyle: TextStyle(
                          fontWeight: AppColor.lightWeight,
                          color:
                              Theme.of(context).colorScheme.onInverseSurface)),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 4),
                child: Container(
                  height: 40,
                  width: 2,
                  color: Colors.grey,
                ),
              ),
              SizedBox(
                child: Icon(
                  Icons.edit,
                  color: Theme.of(context).colorScheme.tertiary,
                ),
              ),
            ],
          ),
        ));
  }

  inActiveTextFields(BuildContext context, String title, double height) {
    return Container(
        height: 50,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: const Color.fromARGB(76, 158, 158, 158),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: TextStyle(
                    color: Color.fromARGB(77, 255, 255, 255), fontSize: 16),
              ),
              Icon(
                Icons.info_outline,
                color: Color.fromARGB(77, 255, 255, 255),
              ),
              SizedBox(
                width: 100,
                height: 30,
                child: TextField(
                    readOnly: true,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 4),
                child: Container(
                  height: 40,
                  width: 2,
                  color: Color.fromARGB(77, 255, 255, 255),
                ),
              ),
              SizedBox(
                child: Icon(
                  Icons.edit,
                  color: Color.fromARGB(77, 255, 255, 255),
                ),
              ),
            ],
          ),
        ));
  }
}
