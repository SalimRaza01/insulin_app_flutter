import 'package:flutter/material.dart';
import 'package:newproject/AuthScreens/SetupProfile.dart';
import 'package:newproject/Screens/Agreement/Consensus.dart';
import 'package:newproject/Screens/Agreement/termsofUse.dart';

class Bottomnavigator extends StatefulWidget {
  const Bottomnavigator({super.key});

  @override
  State<Bottomnavigator> createState() => _BottomnavigatorState();
}

class _BottomnavigatorState extends State<Bottomnavigator> {
  int _selectedIndex = 0;
  static const List<Widget> _widgetOptions = <Widget>[
    TermsOfUse(),
    ConsensusAgreement(),
    SetupProfile(),
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: _widgetOptions.elementAt(_selectedIndex),
     
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor:   Color.fromARGB(255, 31, 29, 86),
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(
                Icons.medical_information,
                color: Colors.white,
              ),
              label: 'Terms',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.insert_drive_file_outlined,
                color: Colors.white,
              ),
              label: 'Consensus',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.pending_actions,
                color: Colors.white,
              ),
              label: 'Demographics',
            ),
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: const Color.fromARGB(255, 255, 255, 255),
          onTap: (index) {
            setState(() {
              _selectedIndex = index;
            });
          },
        ),
      ),
    );
  }
}
