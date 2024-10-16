import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:insulin_app_flutter/utils/Colors.dart';
import 'package:insulin_app_flutter/utils/Drawer.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class ReportScreen extends StatefulWidget {
  const ReportScreen({super.key});

  @override
  State<ReportScreen> createState() => _ReportScreenState();
}

class _ReportScreenState extends State<ReportScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
    drawer: AppDrawerNavigation('REPORT'),
        backgroundColor: Theme.of(context).colorScheme.onPrimary,
        appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.white),
         
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Report',
                  style: TextStyle(
                      fontSize: 30,
                      color:  AppColor.appbarColor),
                ),
                SizedBox(
                  height: 30,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).restorablePush(_modalBuilder);
                  },
                  child: ReportTile(
                    title: 'WEEKLY REPORT',
                    date: 'Last generated 21/05/21',
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                ReportTile(
                  title: 'MONTHLY REPORT',
                  date: 'Last generated 21/05/21',
                ),
                SizedBox(
                  height: 30,
                ),
                ReportTile(
                  title: 'YEARLY REPORT',
                  date: 'Last generated 21/05/21',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ReportTile extends StatelessWidget {
  final String title;
  final String date;

  ReportTile({required this.title, required this.date});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 350,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
              bottomLeft: Radius.circular(20),
              bottomRight: Radius.circular(50)),
          color: Theme.of(context).colorScheme.primary,
          boxShadow: [
            BoxShadow(
              color: Colors.grey,
              blurRadius: 10,
            ),
          ]),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title,
                style: TextStyle(
                    fontSize: 15,
                    color:  AppColor.appbarColor)),
            Text(
              date,
              style: TextStyle(fontSize: 10),
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Image.asset(
                  'assets/images/ReportTile.png',
                  width: 200,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

Route<Object?> _modalBuilder(BuildContext context, Object? arguments) {
  return CupertinoModalPopupRoute<void>(
    builder: (BuildContext context) {
      return Container(
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.primary,
        ),
        height: 700,
        child: Scaffold(
            body: SingleChildScrollView(
          child: Container(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  Text(
                    'InsuLink Report',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    width: 130,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                            width: 35,
                            child: Image.asset('assets/images/downlode.png')),
                        SizedBox(
                            width: 35,
                            child: Image.asset('assets/images/share.png')),
                        GestureDetector(
                          onTap: () => {Navigator.pop(context)},
                          child: SizedBox(
                              width: 35,
                              child: Image.asset('assets/images/cross.png')),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Patient Name',
                            style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.w500),
                          ),
                          Text(
                            'Age',
                            style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.w500),
                          ),
                          Text(
                            'Gender',
                            style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.w500),
                          ),
                          Text(
                            'Export Date',
                            style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.w500),
                          ),
                          Text(
                            'Accession No',
                            style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.w500),
                          ),
                          Text(
                            'Reported on',
                            style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            'Saurav Singh',
                            style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.w500),
                          ),
                          Text(
                            '25 years',
                            style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.w500),
                          ),
                          Text(
                            'Male',
                            style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.w500),
                          ),
                          Text(
                            '24/05/2021',
                            style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.w500),
                          ),
                          Text(
                            '9917544648',
                            style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.w500),
                          ),
                          Text(
                            'Weekly',
                            style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.w500),
                          ),
                        ],
                      )
                    ],
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  SizedBox(
                      width: 350,
                      child: Image.asset('assets/images/report.png')),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      chartdata(),
                      chartdata(),
                      chartdata(),
                    ],
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  Text(
                    'Contrary to popular belief, Lorem Ipsum is not simply random text. It has roots in a piece of classical Latin literature from 45 BC.',
                    style: TextStyle(fontSize: 10),
                  )
                ],
              ),
            ),
          ),
        )),
      );
    },
  );
}

class chartdata extends StatelessWidget {
  const chartdata({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      width: 115,
      padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
      child: SfCartesianChart(
        primaryXAxis: CategoryAxis(
          labelRotation: 0,
          majorGridLines: MajorGridLines(width: 0),
          labelStyle: TextStyle(fontSize: 8),
        ),
        primaryYAxis: NumericAxis(
          majorGridLines: MajorGridLines(width: 0),
          labelStyle: TextStyle(fontSize: 8),
        ),
        series: <CartesianSeries<dynamic, dynamic>>[
          ColumnSeries<ChartDataInfo, String>(
            dataSource: indexChart,
            pointColorMapper: (ChartDataInfo data, _) => data.color,
            xValueMapper: (ChartDataInfo data, _) => data.year,
            yValueMapper: (ChartDataInfo data, _) => data.value,
            enableTooltip: true,
            dataLabelSettings: DataLabelSettings(
              isVisible: false,
              angle: 0,
            ),
          ),
        ],
      ),
    );
  }
}

class ChartData {
  ChartData(this.mobile, this.sale, [this.color]);

  final String mobile;
  final double sale;
  final Color? color;
}

class ChartDataInfo {
  ChartDataInfo(this.year, this.value, [this.color]);

  final String year;
  final double value;
  final Color? color;
}

final List<ChartDataInfo> indexChart = [
  ChartDataInfo('01', 25.5, Colors.grey),
  ChartDataInfo('02', 50, Colors.grey),
  ChartDataInfo('03', 50, Colors.grey),
  ChartDataInfo('04', 24, Colors.grey),
  ChartDataInfo('05', 84, Colors.grey),
  ChartDataInfo('06', 50, Colors.grey),
  ChartDataInfo('07', 50, Colors.grey),
  ChartDataInfo('08', 24, Colors.grey),
  ChartDataInfo('09', 84, Colors.grey),
  ChartDataInfo('10', 84, Colors.grey),
];
