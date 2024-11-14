// // ignore_for_file: prefer_const_constructors

// import 'package:accordion/accordion.dart';
// import 'package:accordion/controllers.dart';
// import 'package:flutter/material.dart';
// import 'package:fl_chart/fl_chart.dart';
// import 'package:flutter_blue_plus/flutter_blue_plus.dart';
// import 'package:newproject/presentation/screens/HomeScreen.dart';
// import '../../core/theme/Colors.dart';


// class Faq extends StatelessWidget {


//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Theme.of(context).colorScheme.primary,
//       appBar: AppBar(
//         backgroundColor: Theme.of(context).colorScheme.primary,
//         centerTitle: true,
//         title: Center(
//           child: Text(
//             'Frequently Asked Questions',
//             style: TextStyle(
//               fontFamily: 'Avenir',
//               fontSize: 24,
//               color: Theme.of(context).colorScheme.secondary,
//             ),
//           ),
//         ),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 20),
//         child: Accordion(
//           headerBackgroundColor: Theme.of(context).colorScheme.secondary,
//           headerBackgroundColorOpened: Theme.of(context).colorScheme.secondary,
//           contentBorderColor: Theme.of(context).colorScheme.secondary,
//           contentBackgroundColor: Theme.of(context).colorScheme.secondary,
//           contentBorderWidth: 3,
//           contentHorizontalPadding: 20,
//           scaleWhenAnimating: true,
//           openAndCloseAnimation: true,
//           headerPadding:
//               const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
//           sectionOpeningHapticFeedback: SectionHapticFeedback.heavy,
//           sectionClosingHapticFeedback: SectionHapticFeedback.light,
//           children: [
//             AccordionSection(
//               isOpen: false,
//               contentVerticalPadding: 20,
//               // leftIcon:
//               //     const Icon(Icons.text_fields_rounded, color: Theme.of(context).colorScheme.primary),
//               header: Text(
//                 'FAQ 1',
//                 style: TextStyle(color: Theme.of(context).colorScheme.primary),
//               ),
//               content:  Text(
//                 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.',
//                 style: TextStyle(
//       color: Theme.of(context).colorScheme.primary, fontSize: 14, fontWeight: FontWeight.normal),
//               ),
//             ),
//             AccordionSection(
//               isOpen: false,
//               contentVerticalPadding: 20,
//               // leftIcon:
//               //     const Icon(Icons.text_fields_rounded, color: Theme.of(context).colorScheme.primary),
//               header:  Text(
//                 'FAQ 2',
//                 style: TextStyle(color: Theme.of(context).colorScheme.primary),
//               ),
//               content:  Text(
//                 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.',
//                 style: TextStyle(
//       color: Theme.of(context).colorScheme.primary, fontSize: 14, fontWeight: FontWeight.normal),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }







// //nutrition data old code



// class GlucoseScreen extends StatefulWidget {
//   final BluetoothDevice? agvaDevice;
//   const GlucoseScreen({this.agvaDevice});

//   @override
//   State<GlucoseScreen> createState() => _GlucoseScreenState();
// }

// class _GlucoseScreenState extends State<GlucoseScreen> {
//   TextEditingController enterBgcontroller = TextEditingController();
//   int containerIndex = 0;
//   int touchedIndex = -1;
//   BluetoothDevice? agvaDevice;
//   bool deviceStatus = false;
//   String glucose = '50';
//   bool isBgEditable = false;
//   FocusNode bgFocusNode = FocusNode();
//   String _selectedtext = 'Day';
//   Color? activeColor;
//   String selected = 'Day';

//   void toggleBGEdit() {
//     setState(() {
//       isBgEditable = !isBgEditable;
//       // if (isBgEditable) {r
//       //   FocusScope.of(context).requestFocus(bgFocusNode);
//       // }
//     });
//   }

//   void _forwardtoggleContainer() {
//     setState(() {
//       containerIndex = (containerIndex + 1) % 3;
//       print('Container index toggled: $containerIndex');
//     });
//   }

//   void _backwardtoggleContainer() {
//     setState(() {
//       containerIndex = (containerIndex - 1) % 3;
//       print('Container index toggled: $containerIndex');
//     });
//   }

//   List<PieChartSectionData> _showingSections() {
//     return List.generate(3, (i) {
//       final isTouched = i == touchedIndex;
//       final fontSize = isTouched ? 20.0 : 12.0;
//       final radius = isTouched ? 50.0 : 40.0;
//       switch (i) {
//         case 0:
//           return PieChartSectionData(
//             color: const Color(0xff0293ee),
//             value: 60,
//             title: '60 gms',
//             radius: radius,
//             titleStyle: TextStyle(
//               fontSize: fontSize,
//               fontWeight: FontWeight.bold,
//               color: const Color(0xffffffff),
//             ),
//           );
//         case 1:
//           return PieChartSectionData(
//             color: const Color(0xfff8b250),
//             value: 30,
//             title: '30 gms',
//             radius: radius,
//             titleStyle: TextStyle(
//               fontSize: fontSize,
//               fontWeight: FontWeight.bold,
//               color: const Color(0xffffffff),
//             ),
//           );
//         case 2:
//           return PieChartSectionData(
//             color: const Color(0xff845bef),
//             value: 10,
//             title: '10 gms',
//             radius: radius,
//             titleStyle: TextStyle(
//               fontSize: fontSize,
//               fontWeight: FontWeight.bold,
//               color: const Color(0xffffffff),
//             ),
//           );
//         default:
//           throw Error();
//       }
//     });
//   }

//   _showDialog(BuildContext context, int containerIndex) {
//     showDialog(
//       context: context,
//       barrierColor: Theme.of(context).colorScheme.secondary,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           backgroundColor: Color.fromARGB(255, 255, 255, 255),
//           elevation: BorderSide.strokeAlignOutside,
//           content: Stack(children: [
//             if (containerIndex == 0) _buildContainer(),
//             if (containerIndex == 1) _buildContainerTwo(),
//             if (containerIndex == 2) _buildContainerThree(),
//           ]),
//         );
//       },
//     );
//   }

//   @override
//   void initState() {
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       if (widget.agvaDevice == null) {
//             _showDialog(context, containerIndex);
//         // newMethod(context);
//       } else {
//         _showDialog(context, containerIndex);
//       }
//     });

//     return newMethod(context);
//   }

//   Scaffold newMethod(BuildContext context) {
//     final height = MediaQuery.of(context).size.height;
//     final width = MediaQuery.of(context).size.width;
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Theme.of(context).colorScheme.secondary,
//         leading: IconButton(
//           icon: Icon(
//             Icons.arrow_back,
//             color: Theme.of(context).colorScheme.primary,
//           ),
//           onPressed: () {
//             Navigator.pushAndRemoveUntil<dynamic>(
//               context,
//               MaterialPageRoute<dynamic>(
//                   builder: (BuildContext context) => HomeScreen()),
//               (route) => false,
//             );
//           },
//         ),
//       ),
//       body: Column(
      
//         children: [
//           Container(
//             decoration: BoxDecoration(
//                 color: Theme.of(context).colorScheme.secondary,
//                 borderRadius: BorderRadius.only(
//                     bottomLeft: Radius.circular(30),
//                     bottomRight: Radius.circular(30))),
//             child: Padding(
//               padding: EdgeInsets.only(left: 20, right: 20, bottom: 20),
//               child: Column(
//              mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Text("My Glucose",
//                           style: TextStyle(
//                               color: Theme.of(context).colorScheme.primary, fontSize: height * 0.03)),
//                       Image.asset(
//                         'assets/images/heart.png',
//                         height: height*0.05,
//                         // width: width * 0.1,
//                         // height: 50,
//                       )
//                     ],
//                   ),
//                   SizedBox(height: height * 0.02),
//                   Container(
//                     child: Column(
//                       children: [
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children: [
//                             selectedBUtton('Day'),
//                             selectedBUtton('Month'),
//                             selectedBUtton('Year'),
//                           ],
//                         ),
//                      SizedBox(height: height * 0.02),
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children: [
//                             if (selected == 'Day')
//                               Text("06:20 pm",
//                                   style: TextStyle(
//                                       color: Theme.of(context).colorScheme.primary,
//                                       fontSize: height * 0.03)),
//                             if (selected == 'Month' || selected == 'Year')
//                               Text("Highest",
//                                   style: TextStyle(
//                                       color: Theme.of(context).colorScheme.primary,
//                                       fontSize: height * 0.03)),
//                             Text("Average",
//                                 style: TextStyle(
//                                     color: Theme.of(context).colorScheme.primary,
//                                     fontSize: height * 0.03)),
//                           ],
//                         ),
//                        SizedBox(height: height * 0.02),
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children: [
//                             RichText(
//                               text: TextSpan(
//                                 children: [
//                                   if (selected == 'Day')
//                                     TextSpan(
//                                         text: "5.7",
//                                         style: TextStyle(
//                                             fontSize: height * 0.04,
//                                             color: Theme.of(context).colorScheme.primary,
//                                             fontWeight: FontWeight.bold)),
//                                   if (selected == 'Month' || selected == 'Year')
//                                     TextSpan(
//                                         text: "8.5",
//                                         style: TextStyle(
//                                             fontSize: height * 0.04,
//                                             color: Theme.of(context).colorScheme.primary,
//                                             fontWeight: FontWeight.bold)),
//                                   TextSpan(
//                                       text: " mg/dl",
//                                       style: TextStyle(
//                                           fontSize: height * 0.02,
//                                           color: Theme.of(context).colorScheme.primary))
//                                 ],
//                               ),
//                             ),
//                             RichText(
//                               text: TextSpan(
//                                 children: [
//                                   TextSpan(
//                                       text: "7.1",
//                                       style: TextStyle(
//                                           fontSize: height * 0.04,
//                                           color: Theme.of(context).colorScheme.primary,
//                                           fontWeight: FontWeight.bold)),
//                                   TextSpan(
//                                       text: " mg/dl",
//                                       style: TextStyle(
//                                           fontSize: height * 0.02,
//                                           color: Theme.of(context).colorScheme.primary))
//                                 ],
//                               ),
//                             ),
//                           ],
//                         )
//                       ],
//                     ),
//                   )
//                 ],
//               ),
//             ),
//           ),
//           if (selected == 'Day') dayContainer(),
//           if (selected == 'Month') monthContainer(),
//           if (selected == 'Year') yearlyContainer(),
//         ],
//       ),
//       floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
//       floatingActionButton: FloatingActionButton.extended(
//         onPressed: () {
//           showModalBottomSheet(
//               context: context,
//               builder: (BuildContext context) {
//                 return BottomSheet(
//                     onClosing: () {},
//                     builder: (BuildContext context) {
//                       return Container(
//                         height: height * 0.5,
//                         width: width,
//                         child: Padding(
//                           padding: const EdgeInsets.symmetric(vertical: 20),
//                           child: Column(
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             children: [
//                               Column(
//                                 children: [
//                                   Text(
//                                     "CALCULATED INSULIN",
//                                     style: TextStyle(
//                                         fontSize: height * 0.03,
//                                         fontWeight: FontWeight.w500),
//                                   ),
//                                   SizedBox(
//                                     height: height * 0.05,
//                                   ),
//                                   Padding(
//                                     padding: const EdgeInsets.symmetric(
//                                         horizontal: 10),
//                                     child: Row(
//                                       mainAxisAlignment:
//                                           MainAxisAlignment.spaceEvenly,
//                                       children: [
//                                         Icon(Icons.water_drop_outlined),
//                                         Text("Insulin dosage",
//                                             style: TextStyle(
//                                                 fontSize: height * 0.03,
//                                                 fontWeight: FontWeight.w400)),
//                                         SizedBox(
//                                           width: width * 0.01,
//                                         ),
//                                         Text("$glucose units",
//                                             style: TextStyle(
//                                                 fontSize: height * 0.03,
//                                                 fontWeight: FontWeight.w400))
//                                       ],
//                                     ),
//                                   ),
//                                   SizedBox(
//                                     height: height * 0.03,
//                                   ),
//                                   Padding(
//                                     padding: const EdgeInsets.symmetric(
//                                         horizontal: 20),
//                                     child: Row(
//                                       mainAxisAlignment:
//                                           MainAxisAlignment.spaceAround,
//                                       children: [
//                                         SizedBox(
//                                           child: Image.asset(
//                                               'assets/images/info.png'),
//                                           height: height * 0.03,
//                                         ),
//                                         SizedBox(
//                                           child: Text(
//                                             'Basal Wizard automatically calculate the recommended dosage of insulin based on your meal intake',
//                                             style: TextStyle(
//                                                 color: Color.fromARGB(
//                                                     255, 31, 29, 86),
//                                                 fontSize: height * 0.012),
//                                           ),
//                                           width: width * 0.7,
//                                         ),
//                                       ],
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                               Center(
//                                 child: GestureDetector(
//                                   onTap: () {},
//                                   child: Container(
//                                     height: height * 0.05,
//                                     width: width * 0.4,
//                                     decoration: BoxDecoration(
//                                         borderRadius: BorderRadius.circular(50),
//                                         color: Theme.of(context).colorScheme.secondary,
//                                         border: Border.all(
//                                           color: Color.fromARGB(
//                                               255, 255, 255, 255),
//                                         ),
//                                         boxShadow: [
//                                           BoxShadow(
//                                             color: Colors.grey,
//                                             blurRadius: 10,
//                                           ),
//                                         ]),
//                                     child: Center(
//                                         child: Text(
//                                       'INFUSE DOSAGE',
//                                       style: TextStyle(
//                                           color: Theme.of(context).colorScheme.primary,
//                                           fontSize: height * 0.02),
//                                     )),
//                                   ),
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                       );
//                     });
//               });
//         },
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(30),
//         ),
//         label: Text(
//           "Deliver Insulin",
//           style: TextStyle(color: Theme.of(context).colorScheme.primary, fontSize: height * 0.02),
//         ),
//         backgroundColor:  Theme.of(context).colorScheme.secondary,
//       ),
//     );
//   }

//   Column dayContainer() {
//     return Column(
//       children: [
//          Container(
//          height: MediaQuery.of(context).size.height*0.05,
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Image.asset(
//                 'assets/images/star.png',
//                      width: MediaQuery.of(context).size.height*0.02,
//                 height: MediaQuery.of(context).size.width*1,
//               ),
//               SizedBox(
//                width: MediaQuery.of(context).size.width*0.02,
//               ),
//               Text(
//                 "Glucose in Range | Going down",
//                 style: TextStyle(fontWeight: FontWeight.w700),
//               )
//             ],
//           ),
//         ),
//         Row(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Icon(
//               Icons.circle,
//               color: Colors.green,
//               size: 10,
//             ),
//             SizedBox(
//               width: MediaQuery.of(context).size.width*0.01,
//             ),
//             Text(
//               "Inrange",
//               style: TextStyle(fontWeight: FontWeight.w700),
//             ),
//             SizedBox(
//               width: MediaQuery.of(context).size.width*0.02,
//             ),
//             Icon(
//               Icons.circle,
//               color: Colors.amber,
//               size: 10,
//             ),
//             SizedBox(
//                width: MediaQuery.of(context).size.width*0.01,
//             ),
//             Text(
//               "High",
//               style: TextStyle(fontWeight: FontWeight.w700),
//             ),
//             SizedBox(
//             width: MediaQuery.of(context).size.width*0.03,
//             ),
//             Icon(
//               Icons.circle,
//               color: Colors.red,
//               size: 10,
//             ),
//             SizedBox(
//         width: MediaQuery.of(context).size.width*0.03,
//             ),
//             Text(
//               "Low",
//               style: TextStyle(fontWeight: FontWeight.w700),
//             ),
//           ],
//         ),
//         Center(
//           child: Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 10),
//             child: Container(
//               height: MediaQuery.of(context).size.height*0.25,
//               child: LineChart(mainData()),
//             ),
//           ),
//         ),
//         SizedBox(
//           height: MediaQuery.of(context).size.height*0.03,
//         ),
//         Divider(
//           height: MediaQuery.of(context).size.height*0.03,
//           color: Theme.of(context).colorScheme.secondaryContainer,
//         ),
//         Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Text(
//                 "Insulin Dosage",
//                 style: TextStyle(fontSize: MediaQuery.of(context).size.height*0.025, color: Theme.of(context).colorScheme.primaryContainer),
//               ),
//               RichText(
//                 text: TextSpan(
//                   children: [
//                     TextSpan(
//                         text: '$glucose',
//                         style: TextStyle(
//                             fontSize: MediaQuery.of(context).size.height*0.04,
//                             color: Theme.of(context).colorScheme.primaryContainer,
//                             fontWeight: AppColor.weight600)),
//                     TextSpan(
//                         text: " unit",
//                         style: TextStyle(color: Theme.of(context).colorScheme.primaryContainer))
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         )
//       ],
//     );
//   }

//   Column monthContainer() {
//     return Column(
//       children: [
//        Container(
//          height: MediaQuery.of(context).size.height*0.05,
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Image.asset(
//                 'assets/images/star.png',
//                      width: MediaQuery.of(context).size.height*0.02,
//                 height: MediaQuery.of(context).size.width*1,
//               ),
//               SizedBox(
//                width: MediaQuery.of(context).size.width*0.02,
//               ),
//               Text(
//                 "Glucose in Range | Going down",
//                 style: TextStyle(fontWeight: FontWeight.w700),
//               )
//             ],
//           ),
//         ),
//         Row(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Icon(
//               Icons.circle,
//               color: Colors.green,
//               size: 10,
//             ),
//             SizedBox(
//                width: MediaQuery.of(context).size.width*0.01,
//             ),
//             Text(
//               "Inrange",
//               style: TextStyle(fontWeight: FontWeight.w700),
//             ),
//             SizedBox(
//            width: MediaQuery.of(context).size.width*0.02,
//             ),
//             Icon(
//               Icons.circle,
//               color: Colors.amber,
//               size: 10,
//             ),
//             SizedBox(
//                 width: MediaQuery.of(context).size.width*0.01,
//             ),
//             Text(
//               "High",
//               style: TextStyle(fontWeight: FontWeight.w700),
//             ),
//             SizedBox(
//              width: MediaQuery.of(context).size.width*0.03,
//             ),
//             Icon(
//               Icons.circle,
//               color: Colors.red,
//               size: 10,
//             ),
//             SizedBox(
//              width: MediaQuery.of(context).size.width*0.03,
//             ),
//             Text(
//               "Low",
//               style: TextStyle(fontWeight: FontWeight.w700),
//             ),
//           ],
//         ),
//         Center(
//           child: Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 10),
//             child: Container(
//                height: MediaQuery.of(context).size.height*0.25,
//               child: LineChart(mainData()),
//             ),
//           ),
//         ),
//         SizedBox(
//         height: MediaQuery.of(context).size.height*0.03,
//         ),
//         Divider(
//         height: MediaQuery.of(context).size.height*0.03,
//           color: Theme.of(context).colorScheme.secondaryContainer,
//         ),
//         Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Text(
//                 "Monthly Insulin Dosage",
//                 style: TextStyle(fontSize: MediaQuery.of(context).size.height*0.025, color: Theme.of(context).colorScheme.primaryContainer),
//               ),
//               RichText(
//                 text: TextSpan(
//                   children: [
//                     TextSpan(
//                         text: '$glucose',
//                         style: TextStyle(
//                          fontSize: MediaQuery.of(context).size.height*0.04,
//                             color: Theme.of(context).colorScheme.primaryContainer,
//                             fontWeight: AppColor.weight600)),
//                     TextSpan(
//                         text: " unit",
//                         style: TextStyle(color: Theme.of(context).colorScheme.primaryContainer))
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         )
//       ],
//     );
//   }

//   Column yearlyContainer() {
//     return Column(
//       children: [
//         Container(
//          height: MediaQuery.of(context).size.height*0.05,
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Image.asset(
//                 'assets/images/star.png',
//                      width: MediaQuery.of(context).size.height*0.02,
//                 height: MediaQuery.of(context).size.width*1,
//               ),
//               SizedBox(
//                width: MediaQuery.of(context).size.width*0.02,
//               ),
//               Text(
//                 "Glucose in Range | Going down",
//                 style: TextStyle(fontWeight: FontWeight.w700),
//               )
//             ],
//           ),
//         ),
//         Row(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Icon(
//               Icons.circle,
//               color: Colors.green,
//               size: 10,
//             ),
//             SizedBox(
//               width: MediaQuery.of(context).size.width*0.01,
//             ),
//             Text(
//               "Inrange",
//               style: TextStyle(fontWeight: FontWeight.w700),
//             ),
//             SizedBox(
//               width: MediaQuery.of(context).size.width*0.02,
//             ),
//             Icon(
//               Icons.circle,
//               color: Colors.amber,
//               size: 10,
//             ),
//             SizedBox(
//             width: MediaQuery.of(context).size.width*0.01,
//             ),
//             Text(
//               "High",
//               style: TextStyle(fontWeight: FontWeight.w700),
//             ),
//             SizedBox(
//             width: MediaQuery.of(context).size.width*0.03,
//             ),
//             Icon(
//               Icons.circle,
//               color: Colors.red,
//               size: 10,
//             ),
//             SizedBox(
//               width: MediaQuery.of(context).size.width*0.03,
//             ),
//             Text(
//               "Low",
//               style: TextStyle(fontWeight: FontWeight.w700),
//             ),
//           ],
//         ),
//         Center(
//           child: Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 10),
//             child: Container(
//               height: MediaQuery.of(context).size.height*0.25,
//               child: LineChart(mainData()),
//             ),
//           ),
//         ),
//         SizedBox(
//           height: MediaQuery.of(context).size.height*0.03,
//         ),
//         Divider(
//           height: MediaQuery.of(context).size.height*0.03,
//           color: Theme.of(context).colorScheme.secondaryContainer,
//         ),
//         Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Text(
//                 "Yearly Insulin Dosage",
//                 style: TextStyle(fontSize: MediaQuery.of(context).size.height*0.025, color: Theme.of(context).colorScheme.primaryContainer),
//               ),
//               RichText(
//                 text: TextSpan(
//                   children: [
//                     TextSpan(
//                         text: '$glucose',
//                         style: TextStyle(
//                              fontSize: MediaQuery.of(context).size.height*0.04,
//                             color: Theme.of(context).colorScheme.primaryContainer,
//                             fontWeight: AppColor.weight600)),
//                     TextSpan(
//                         text: " unit",
//                         style: TextStyle(color: Theme.of(context).colorScheme.primaryContainer))
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         )
//       ],
//     );
//   }

//   selectedBUtton(text) {
//     if (_selectedtext == text) {
//       activeColor = Colors.green;
//     } else {
//       activeColor = Colors.transparent;
//     }
//     return GestureDetector(
//       onTap: () {
//         setState(() {
//           _selectedtext = text;
//           selected = text;
//           print('this is selected text $_selectedtext and this is text $text');
//         });
//       },
//       child: Container(
//            height: MediaQuery.of(context).size.height*0.03,
//           decoration: BoxDecoration(
//               borderRadius: BorderRadius.circular(50), color: activeColor),
//           child: Center(
//               child: Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 30),
//             child:
//                 Text(text, style: TextStyle(color: Theme.of(context).colorScheme.primary,  fontSize: MediaQuery.of(context).size.height*0.02,)),
//           ))),
//     );
//   }

//   Widget _buildContainer() {
//     return Container(
//       // decoration: BoxDecoration(
//       //   borderRadius: BorderRadius.circular(10),
//       //   color: const Theme.of(context).colorScheme.secondary,
//       // ),
//       width: 300,
//       height: 400,
//       child: Column(
//         children: [
//           Padding(
//             padding: const EdgeInsets.only(top: 10),
//             child: Text(
//               "Nutritional data",
//               style: TextStyle(fontSize: 30, color: Colors.black),
//             ),
//           ),
//           SizedBox(height: 10),
//           Container(
//             height: 200,
//             child: Stack(
//               children: [
//                 Center(
//                   child: PieChart(
//                     PieChartData(
//                       sections: _showingSections(),
//                       borderData: FlBorderData(show: false),
//                       sectionsSpace: 0,
//                       centerSpaceRadius: 40,
//                       pieTouchData: PieTouchData(
//                         touchCallback: (FlTouchEvent event, pieTouchResponse) {
//                           setState(() {
//                             if (!event.isInterestedForInteractions ||
//                                 pieTouchResponse == null ||
//                                 pieTouchResponse.touchedSection == null) {
//                               touchedIndex = -1;
//                               return;
//                             }
//                             touchedIndex = pieTouchResponse
//                                 .touchedSection!.touchedSectionIndex;
//                           });
//                         },
//                       ),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 20),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.end,
//               children: [
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Row(
//                       children: [
//                         Icon(Icons.rectangle,
//                             size: 10, color: Color(0xff0293ee)),
//                         SizedBox(width: 10),
//                         Text("Carbohydrates"),
//                       ],
//                     ),
//                     Text("60gms"),
//                   ],
//                 ),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Row(
//                       children: [
//                         Icon(Icons.rectangle,
//                             size: 10, color: Color(0xfff8b250)),
//                         SizedBox(width: 10),
//                         Text("Proteins"),
//                       ],
//                     ),
//                     Text("30gms"),
//                   ],
//                 ),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Row(
//                       children: [
//                         Icon(Icons.rectangle,
//                             size: 10, color: Color(0xff845bef)),
//                         SizedBox(width: 10),
//                         Text("Fats"),
//                       ],
//                     ),
//                     Text("10gms"),
//                   ],
//                 ),
//               ],
//             ),
//           ),
//           SizedBox(height: 30),
//           GestureDetector(
//             onTap: _forwardtoggleContainer,
//             child: Container(
//               height: 40,
//               width: 200,
//               decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(50),
//                   color: Theme.of(context).colorScheme.secondary,
//                   border: Border.all(
//                     color: Color.fromARGB(255, 255, 255, 255),
//                   ),
//                   boxShadow: [
//                     BoxShadow(
//                       color: Colors.grey,
//                       blurRadius: 10,
//                     ),
//                   ]),
//               child: Center(
//                   child: Text(
//                 'Next',
//                 style: TextStyle(color: Theme.of(context).colorScheme.primary, fontSize: 16),
//               )),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildContainerTwo() {
//     return Container(
//       width: 300,
//       height: 400,
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           Padding(
//             padding: const EdgeInsets.only(top: 10),
//             child: Text(
//               "BLOOD GLUCOSE",
//               style: TextStyle(
//                   fontSize: 30,
//                   color: Colors.black,
//                   fontWeight: FontWeight.w500),
//             ),
//           ),
//           Container(
//             height: 202,
//             width: 200,
//             child: Column(
//               children: [
//                 SizedBox(
//                   height: 20,
//                 ),
//                 Image.asset(
//                   'assets/images/bgvalue.png',
//                   height: 100,
//                 ),
//                 SizedBox(
//                   height: 30,
//                 ),
//                 Container(
//                   width: 180,
//                   decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(5),
//                     border: Border.all(
//                       color: Colors.grey,
//                       width: 0.2,
//                     ),
//                     color: Theme.of(context).colorScheme.primary,
//                   ),
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceAround,
//                     children: [
//                       GestureDetector(
//                         onTap: () {
//                           toggleBGEdit();
//                           print('bg button');
//                         },
//                         child: Transform.flip(
//                           flipY: false,
//                           flipX: true,
//                           child: Image.asset(
//                             'assets/images/editicon.png',
//                             height: 20,
//                           ),
//                         ),
//                       ),
//                       Row(
//                         children: [
//                           Container(
//                               height: 50,
//                               width: 60,
//                               child: TextField(
//                                 // focusNode: bgFocusNode,
//                                 keyboardType: TextInputType.number,
//                                 controller: enterBgcontroller,
//                                 readOnly: !isBgEditable,
//                                 style: TextStyle(
//                                     fontSize: 40,
//                                     fontWeight: AppColor.weight600,
//                                     color: Theme.of(context).colorScheme.primaryContainer),
//                                 decoration: InputDecoration(
//                                   border: InputBorder.none,
//                                   hintText: glucose,
//                                   hintStyle: TextStyle(
//                                       fontSize: 40, color: Theme.of(context).colorScheme.primaryContainer),
//                                 ),
//                               )),
//                           Text(
//                             "mg/dl",
//                             style: TextStyle(fontSize: 20),
//                           ),
//                         ],
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               GestureDetector(
//                 onTap: _backwardtoggleContainer,
//                 child: Container(
//                   height: 40,
//                   width: 100,
//                   decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(50),
//                       color: Theme.of(context).colorScheme.secondary,
//                       border: Border.all(
//                         color: Color.fromARGB(255, 255, 255, 255),
//                       ),
//                       boxShadow: [
//                         BoxShadow(
//                           color: Colors.grey,
//                           blurRadius: 10,
//                         ),
//                       ]),
//                   child: Center(
//                       child: Text(
//                     'BACK',
//                     style: TextStyle(color: Theme.of(context).colorScheme.primary, fontSize: 16),
//                   )),
//                 ),
//               ),
//               GestureDetector(
//                 onTap: () {
//                   if (enterBgcontroller.text.isNotEmpty) {
//                     setState(() {
//                       glucose = enterBgcontroller.text;
//                       print('glucose $glucose');
//                       print('enterBgcontroller ${enterBgcontroller.text}');
//                     });
//                   }
//                   _forwardtoggleContainer();
//                 },
//                 child: Container(
//                   height: 40,
//                   width: 100,
//                   decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(50),
//                       color: Theme.of(context).colorScheme.secondary,
//                       border: Border.all(
//                         color: Color.fromARGB(255, 255, 255, 255),
//                       ),
//                       boxShadow: [
//                         BoxShadow(
//                           color: Colors.grey,
//                           blurRadius: 10,
//                         ),
//                       ]),
//                   child: Center(
//                       child: Text(
//                     'Next',
//                     style: TextStyle(color: Theme.of(context).colorScheme.primary, fontSize: 16),
//                   )),
//                 ),
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildContainerThree() {
//     return Container(
//       width: 300,
//       height: 400,
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           Padding(
//             padding: const EdgeInsets.only(top: 10),
//             child: Text(
//               "INSULIN VALUE",
//               style: TextStyle(
//                   fontSize: 30,
//                   color: Colors.black,
//                   fontWeight: FontWeight.w500),
//             ),
//           ),
//           Container(
//             height: 202,
//             child: Column(
//               children: [
//                 SizedBox(
//                   height: 10,
//                 ),
//                 Image.asset(
//                   'assets/images/drop.png',
//                   height: 120,
//                 ),
//                 SizedBox(
//                   height: 10,
//                 ),
//                 RichText(
//                   text: TextSpan(
//                     children: [
//                       TextSpan(
//                           text: '$glucose',
//                           style: TextStyle(
//                               fontSize: 50,
//                               color: Theme.of(context).colorScheme.primaryContainer,
//                               fontWeight: AppColor.weight600)),
//                       TextSpan(
//                           text: " unit",
//                           style: TextStyle(color: Colors.black, fontSize: 20))
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               GestureDetector(
//                 onTap: _backwardtoggleContainer,
//                 child: Container(
//                   height: 40,
//                   width: 100,
//                   decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(50),
//                       color: Theme.of(context).colorScheme.secondary,
//                       border: Border.all(
//                         color: Color.fromARGB(255, 255, 255, 255),
//                       ),
//                       boxShadow: [
//                         BoxShadow(
//                           color: Colors.grey,
//                           blurRadius: 10,
//                         ),
//                       ]),
//                   child: Center(
//                       child: Text(
//                     'BACK',
//                     style: TextStyle(color: Theme.of(context).colorScheme.primary, fontSize: 16),
//                   )),
//                 ),
//               ),
//               GestureDetector(
//                 onTap: () {
//                   Navigator.pushAndRemoveUntil<dynamic>(
//                     context,
//                     MaterialPageRoute<dynamic>(
//                         builder: (BuildContext context) => newMethod(context)),
//                     (route) =>
//                         false, //if you want to disable back feature set to false
//                   );
//                 },
//                 child: Container(
//                   height: 40,
//                   width: 100,
//                   decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(50),
//                       color: Theme.of(context).colorScheme.secondary,
//                       border: Border.all(
//                         color: Color.fromARGB(255, 255, 255, 255),
//                       ),
//                       boxShadow: [
//                         BoxShadow(
//                           color: Colors.grey,
//                           blurRadius: 10,
//                         ),
//                       ]),
//                   child: Center(
//                       child: Text(
//                     'SUBMIT',
//                     style: TextStyle(color: Theme.of(context).colorScheme.primary, fontSize: 16),
//                   )),
//                 ),
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }

//   Widget bottomTitleWidgets(double value, TitleMeta meta) {
//     const style = TextStyle(
//       fontSize: 12,
//     );
//     Widget text;
//     switch (value.toInt()) {
//       case 0:
//         text = const Text('0 ', style: style);
//         break;
//       case 1:
//         text = const Text('2 ', style: style);
//         break;
//       case 2:
//         text = const Text('4 ', style: style);
//         break;
//       case 3:
//         text = const Text('5 ', style: style);
//         break;
//       case 4:
//         text = const Text('6', style: style);
//         break;
//       case 5:
//         text = const Text('7 ', style: style);
//         break;
//       case 6:
//         text = const Text('9', style: style);
//         break;
//       case 7:
//         text = const Text('10', style: style);
//         break;
//       case 8:
//         text = const Text('11', style: style);
//         break;
//       case 9:
//         text = const Text('12', style: style);
//         break;
//       case 10:
//         text = const Text('14', style: style);
//         break;
//       case 11:
//         text = const Text('16', style: style);
//         break;
//       case 12:
//         text = const Text('17', style: style);
//         break;
//       case 13:
//         text = const Text('18', style: style);
//         break;

//       default:
//         return Container();
//     }

//     return SideTitleWidget(
//       axisSide: meta.axisSide,
//       child: text,
//     );
//   }

//   Widget leftTitleWidgets(double value, TitleMeta meta) {
//     const style = TextStyle(
//       fontSize: 10,
//     );
//     String text;
//     switch (value.toInt()) {
//       case 1:
//         text = '72';
//         break;
//       case 3:
//         text = '65';
//         break;
//       case 5:
//         text = '50';
//         break;
//       default:
//         return Container();
//     }

//     return Text(text, style: style, textAlign: TextAlign.left);
//   }

//   List<Color> gradientColors = [
//     Color.fromARGB(255, 88, 86, 152),
//     AppColor.appbarColor
//   ];
//   LineChartData mainData() {
//     return LineChartData(
//       gridData: FlGridData(
//         show: true,
//         drawVerticalLine: false,
//         drawHorizontalLine: true,
//         horizontalInterval: 1,
//         verticalInterval: 1,
//         // getDrawingHorizontalLine: (value) {
//         //   return FlLine(
//         //     color: const Color.fromARGB(
//         //         255, 51, 45, 45), // Color of the horizontal lines
//         //     strokeWidth: 5, // Thickness of the horizontal lines
//         //     dashArray: [1,1], // Dashes for the horizontal lines (optional)
//         //   );
//         // },
//         getDrawingVerticalLine: (value) {
//           return FlLine(
//             color: const Color.fromARGB(255, 0, 0, 0),
//             strokeWidth: 1,
//           );
//         },
//       ),
//       titlesData: FlTitlesData(
//         show: true,
//         rightTitles: const AxisTitles(
//           sideTitles: SideTitles(showTitles: false),
//         ),
//         topTitles: const AxisTitles(
//           sideTitles: SideTitles(showTitles: false),
//         ),
//         bottomTitles: AxisTitles(
//           sideTitles: SideTitles(
//             showTitles: true,
//             reservedSize: 30,
//             interval: 1,
//             getTitlesWidget: bottomTitleWidgets,
//           ),
//         ),
//         leftTitles: AxisTitles(
//           sideTitles: SideTitles(
//             showTitles: true,
//             interval: 1,
//             getTitlesWidget: leftTitleWidgets,
//             reservedSize: 42,
//           ),
//         ),
//       ),
//       borderData: FlBorderData(
//         show: false,
//         border: Border.all(color: const Color(0xff37434d)),
//       ),
//       minX: 0,
//       maxX: 14,
//       minY: 0,
//       maxY: 6,
//       lineBarsData: [
//         LineChartBarData(
//           spots: [
//             FlSpot(0, 3),
//             FlSpot(2, 2),
//             FlSpot(4, 4),
//             FlSpot(6, 3.1),
//             FlSpot(8, 5),
//             FlSpot(9, 3),
//             FlSpot(10, 2),
//             FlSpot(11, 4),
//             FlSpot(12, 3.1),
//             FlSpot(13, 5),
//           ],
//           isCurved: true,
//           gradient: LinearGradient(
//             colors: gradientColors,
//           ),
//           barWidth: 3,
//           isStrokeCapRound: true,
//           dotData: const FlDotData(
//             show: false,
//           ),
//           belowBarData: BarAreaData(
//             show: false,
//             //   spotsLine: BarAreaSpotsLine(

//             //  show: true,
//             //  applyCutOffY: true
//             //   ),
//             gradient: LinearGradient(
//               colors: gradientColors
//                   .map((color) => color.withOpacity(0.3))
//                   .toList(),
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }
