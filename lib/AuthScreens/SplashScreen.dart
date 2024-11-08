import 'package:flutter/material.dart';
import 'package:newproject/AuthScreens/SignIn.dart';
import 'package:newproject/Screens/HomeScreen.dart';
import 'package:newproject/utils/SharedPrefsHelper.dart';

class Splashscreen extends StatefulWidget {
  const Splashscreen({super.key});

  @override
  State<Splashscreen> createState() => _SplashscreenState();
}

class _SplashscreenState extends State<Splashscreen> {
  final _sharedPref = SharedPrefsHelper();

  @override
  void initState() {
    super.initState();



    Future.delayed(Duration(seconds: 3), () {
  
      if (_sharedPref.getBool('isLoggedIn') == true) {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => HomeScreen()));
      } else {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => LoginScreen()));
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      extendBodyBehindAppBar: true,
      body: SingleChildScrollView(
        child: Container(
            width: width,
            height: height,
            decoration: BoxDecoration(
                gradient: LinearGradient(colors: <Color>[
              const Color.fromARGB(255, 14, 96, 164),
              const Color.fromARGB(255, 5, 53, 93)
            ])),
            child: Padding(
              padding: const EdgeInsets.all(25),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                // crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(),
                  Column(
                    children: [
                      Text(
                        "INSUL",
                        style: TextStyle(
                            fontSize: height * 0.09,
                            fontFamily: 'Suissnord',
                            color: Colors.white),
                      ),
                      Text(
                        "YOUR PERSONAL DIABETIC EXPERT",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: height * 0.02,
                        ),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Text(
                        "POWERED BY",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: height * 0.015,
                        ),
                      ),
                      Text(
                        "AgVa",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: height * 0.035,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            )),
      ),
    );
  }
}
