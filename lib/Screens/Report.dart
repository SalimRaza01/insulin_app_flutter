import 'package:flutter/material.dart';
import 'package:newproject/utils/Colors.dart';
import 'package:newproject/utils/Drawer.dart';

class ReportScreen extends StatefulWidget {
  const ReportScreen({super.key});

  @override
  State<ReportScreen> createState() => _ReportScreenState();
}

class _ReportScreenState extends State<ReportScreen> {
  int touchedIndex = -1;
  String _selectedText = 'WEEKLY';
  Color? activeColor;
  Color? activeText;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      drawer: AppDrawerNavigation('REPORT'),
      backgroundColor: Theme.of(context).colorScheme.onPrimary,
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: Theme.of(context).colorScheme.secondary,
        elevation: 1,
        centerTitle: true,
        title: Text(
          "REPORT",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(15),
          child: Column(
            children: [
              Center(
                child: Container(
                  width: width / 1.2,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(3),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          _selectButton('WEEKLY', height, width),
                          _selectButton('MONTHLY', height, width),
                          _selectButton('YEARLY', height, width),
                        ]),
                  ),
                ),
              ),
              Column(
                children: [
                  SizedBox(
                    height: height * 0.02,
                  ),
                  HeadingText(height, 'DEMOGRAPHIC DETAILS'),
                  SizedBox(
                    height: height * 0.02,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Theme.of(context).colorScheme.primary,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(15),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Name :',
                                style: TextStyle(
                                  fontFamily: 'Avenir',
                                  color: Theme.of(context)
                                      .colorScheme
                                      .primaryContainer,
                                  fontSize: height * 0.015,
                                ),
                              ),
                              SizedBox(height: 10),
                              Text(
                                'Age :',
                                style: TextStyle(
                                  fontFamily: 'Avenir',
                                  color: Theme.of(context)
                                      .colorScheme
                                      .primaryContainer,
                                  fontSize: height * 0.015,
                                ),
                              ),
                              SizedBox(height: 10),
                              Text(
                                'Gender :',
                                style: TextStyle(
                                  fontFamily: 'Avenir',
                                  color: Theme.of(context)
                                      .colorScheme
                                      .primaryContainer,
                                  fontSize: height * 0.015,
                                ),
                              ),
                              SizedBox(height: 10),
                              Text(
                                'Generated On :',
                                style: TextStyle(
                                  fontFamily: 'Avenir',
                                  color: Theme.of(context)
                                      .colorScheme
                                      .primaryContainer,
                                  fontSize: height * 0.015,
                                ),
                              ),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                '-',
                                style: TextStyle(
                                  fontFamily: 'Avenir',
                                  color: Theme.of(context)
                                      .colorScheme
                                      .primaryContainer,
                                  fontSize: height * 0.015,
                                ),
                              ),
                              SizedBox(height: 10),
                              Text(
                                '-',
                                style: TextStyle(
                                  fontFamily: 'Avenir',
                                  color: Theme.of(context)
                                      .colorScheme
                                      .primaryContainer,
                                  fontSize: height * 0.015,
                                ),
                              ),
                              SizedBox(height: 10),
                              Text(
                                '-',
                                style: TextStyle(
                                  fontFamily: 'Avenir',
                                  color: Theme.of(context)
                                      .colorScheme
                                      .primaryContainer,
                                  fontSize: height * 0.015,
                                ),
                              ),
                              SizedBox(height: 10),
                              Text(
                                '-',
                                style: TextStyle(
                                  fontFamily: 'Avenir',
                                  color: Theme.of(context)
                                      .colorScheme
                                      .primaryContainer,
                                  fontSize: height * 0.015,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: height * 0.02,
                  ),
                  HeadingText(height, 'INSULIN REPORT OVERVIEW'),
                  SizedBox(
                    height: height * 0.02,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Theme.of(context).colorScheme.primary,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(15),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Total Glucose Level :',
                                style: TextStyle(
                                  fontFamily: 'Avenir',
                                  color: Theme.of(context)
                                      .colorScheme
                                      .primaryContainer,
                                  fontSize: height * 0.015,
                                ),
                              ),
                              SizedBox(height: 10),
                              Text(
                                'Total Insulin Delivered :',
                                style: TextStyle(
                                  fontFamily: 'Avenir',
                                  color: Theme.of(context)
                                      .colorScheme
                                      .primaryContainer,
                                  fontSize: height * 0.015,
                                ),
                              ),
                              SizedBox(height: 10),
                              Text(
                                'Total Bolus Delivered :',
                                style: TextStyle(
                                  fontFamily: 'Avenir',
                                  color: Theme.of(context)
                                      .colorScheme
                                      .primaryContainer,
                                  fontSize: height * 0.015,
                                ),
                              ),
                              SizedBox(height: 10),
                              Text(
                                'Total Basal Delivered :',
                                style: TextStyle(
                                  fontFamily: 'Avenir',
                                  color: Theme.of(context)
                                      .colorScheme
                                      .primaryContainer,
                                  fontSize: height * 0.015,
                                ),
                              ),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                '-',
                                style: TextStyle(
                                  fontFamily: 'Avenir',
                                  color: Theme.of(context)
                                      .colorScheme
                                      .primaryContainer,
                                  fontSize: height * 0.015,
                                ),
                              ),
                              SizedBox(height: 10),
                              Text(
                                '-',
                                style: TextStyle(
                                  fontFamily: 'Avenir',
                                  color: Theme.of(context)
                                      .colorScheme
                                      .primaryContainer,
                                  fontSize: height * 0.015,
                                ),
                              ),
                              SizedBox(height: 10),
                              Text(
                                '-',
                                style: TextStyle(
                                  fontFamily: 'Avenir',
                                  color: Theme.of(context)
                                      .colorScheme
                                      .primaryContainer,
                                  fontSize: height * 0.015,
                                ),
                              ),
                              SizedBox(height: 10),
                              Text(
                                '-',
                                style: TextStyle(
                                  fontFamily: 'Avenir',
                                  color: Theme.of(context)
                                      .colorScheme
                                      .primaryContainer,
                                  fontSize: height * 0.015,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                     SizedBox(
                    height: height * 0.04,
                  ),
                  Center(
                    child: GestureDetector(
                      onTap: () {},
                      child: Container(
                        height: height * 0.045,
                        width: width * 0.35,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: Theme.of(context).colorScheme.secondary,
                        ),
                        child: Center(
                            child: Text(
                          'DOWNLOAD',
                          style: TextStyle(
                              color: Colors.white, fontSize: height * 0.016),
                        )),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _selectButton(String text, double height, double width) {
    Color activeColor;
    Color activeText;

    if (_selectedText == text) {
      activeColor = Colors.green;
      activeText = Theme.of(context).colorScheme.primary;
    } else {
      activeColor = Theme.of(context).colorScheme.onPrimary;
      activeText = Theme.of(context).colorScheme.secondaryContainer;
    }

    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedText = text;
        });
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: activeColor,
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: width * 0.06, vertical: 5),
          child: Text(
            text,
            style: TextStyle(
                color: activeText,
                fontSize: height * 0.015,
                fontWeight: AppColor.lightWeight),
          ),
        ),
      ),
    );
  }
}

class HeadingText extends StatelessWidget {
  HeadingText(this.height, this.text);

  final double height;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
          color: Colors.black54,
          fontSize: height * 0.015,
          fontWeight: AppColor.lightWeight),
    );
  }
}
