import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:newproject/utils/Colors.dart';
import 'package:newproject/utils/DeviceConnectProvider.dart';
import 'package:newproject/utils/DeviceProvider.dart';
import 'package:newproject/utils/Drawer.dart';
import 'package:provider/provider.dart';

class DevicesScreen extends StatefulWidget {
  @override
  State<DevicesScreen> createState() => _DevicesScreenState();
}

class _DevicesScreenState extends State<DevicesScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<Deviceprovider>(
      builder: (context, value, child) {
        return Scaffold(
          appBar: AppBar(
            iconTheme: IconThemeData(color: Colors.white),
            title: Text(
              "DEVICES",
              style: TextStyle(color: Theme.of(context).colorScheme.primary),
            ),
            backgroundColor: Theme.of(context).colorScheme.secondary,
          ),
          drawer: AppDrawerNavigation('DEVICES'),
          body: Container(
            color: Theme.of(context).colorScheme.onPrimary,
            height: MediaQuery.of(context).size.height,
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Paired Device",
                        style: TextStyle(
                            color:
                                Theme.of(context).colorScheme.primaryContainer,
                            fontSize: 20),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Visibility(
                        visible: value.getdevice != null,
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Theme.of(context).colorScheme.primary,
                          ),
                          child: ExpansionTile(
                            shape: Border(),
                            leading: Icon(
                              Icons.bluetooth_connected,
                              color: Theme.of(context)
                                  .colorScheme
                                  .primaryContainer,
                            ),
                            title: Text("AgVa Insul",
                                style: TextStyle(
                                  color: Theme.of(context)
                                      .colorScheme
                                      .primaryContainer,
                                  fontWeight: AppColor.lightWeight,
                                )),
                            trailing: SizedBox(),
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Theme.of(context).colorScheme.primary,
                                ),
                                child: Column(
                                  children: [
                                    ListTile(
                                      shape: Border(),
                                      title: Text("Disconnect",
                                          style: TextStyle(
                                            color: Theme.of(context)
                                                .colorScheme
                                                .secondaryContainer,
                                            fontWeight: AppColor.lightWeight,
                                          )),
                                      trailing: SizedBox(),
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        showModalBottomSheet(
                                          backgroundColor: Colors.transparent,
                                          context: context,
                                          builder: (BuildContext context) {
                                            return CupertinoActionSheet(
                                              actions: <Widget>[
                                                ListTile(
                                                  title: Text(
                                                    'Forget Device',
                                                    style: TextStyle(
                                                      color: Colors.red,
                                                    ),
                                                  ),
                                                  onTap: () {
                                                    setState(() {
                                                      value.getdevice!
                                                          .disconnect();
                                                      bool isDeviceConnected =
                                                          false;
                                                      print(
                                                          'device is disconnected ');
                                                      BluetoothDevice?
                                                          myagvaDevice = null;
                                                      Provider.of<Deviceprovider>(
                                                              context,
                                                              listen: false)
                                                          .updateDevice(
                                                              myagvaDevice);
                                                      Provider.of<Deviceconnection>(
                                                              context,
                                                              listen: false)
                                                          .getDeviceConnection(
                                                              isDeviceConnected);
                                                      Navigator.of(context)
                                                          .pop();
                                                    });
                                                  },
                                                ),
                                                ListTile(
                                                  leading: Icon(
                                                    Icons.cancel,
                                                    color: Colors.red,
                                                  ),
                                                  title: Text(
                                                    'Cancel',
                                                    style: TextStyle(
                                                      color: Colors.red,
                                                    ),
                                                  ),
                                                  onTap: () {
                                                    Navigator.of(context).pop();
                                                  },
                                                ),
                                              ],
                                            );
                                          },
                                        );
                                      },
                                      child: ListTile(
                                        shape: Border(),
                                        title: Text("Forget This Device",
                                            style: TextStyle(
                                              color: Color.fromARGB(
                                                  255, 197, 13, 0),
                                              fontWeight: AppColor.lightWeight,
                                            )),
                                        trailing: SizedBox(),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Visibility(
                        visible: value.getdevice == null,
                        child: Container(
                          height: MediaQuery.of(context).size.height / 2,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Center(
                                child: Text(
                                  'No Paired Device Found',
                                  style: TextStyle(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .primaryContainer,
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
