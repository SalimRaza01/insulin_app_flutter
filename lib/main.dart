import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:newproject/AuthScreens/SetupProfile.dart';
import 'package:newproject/AuthScreens/SplashScreen.dart';
import 'package:newproject/AuthScreens/auth_Provider.dart';
import 'package:newproject/utils/BLE_Provider.dart';
import 'package:newproject/utils/SharedPrefsHelper.dart';
import 'package:newproject/Screens/AuthModule.dart';
import 'package:newproject/Screens/BasalWizard.dart';
import 'package:newproject/Screens/BolusWizard.dart';
import 'package:newproject/Screens/DeviceSetupScreen.dart';
import 'package:newproject/Screens/DevicesScreen.dart';
import 'package:newproject/Screens/GlucoseScreen.dart';
import 'package:newproject/Screens/HomeScreen.dart';
import 'package:newproject/Screens/InsulinScreen.dart';
import 'package:newproject/Screens/NutritionScreen.dart';
import 'package:newproject/Screens/ProfileScreen.dart';
import 'package:newproject/Screens/SettingsScreen.dart';
import 'package:newproject/Screens/SmartbolusScreen.dart';
import 'package:newproject/Screens/WeightScreen.dart';
import 'package:newproject/utils/BasalDeliveryNotifier.dart';
import 'package:newproject/utils/BolusDeliveryNotifier.dart';
import 'package:newproject/utils/GlucoseNotifier.dart';
import 'package:newproject/utils/NutritionNotifier.dart';
import 'package:newproject/utils/SmartBolusDelivery.dart';
import 'package:newproject/utils/Theme.dart';
import 'package:newproject/utils/ThemeProvider.dart';
import 'package:newproject/utils/UpdateProfileNotifier.dart';
import 'package:newproject/utils/WeightNotifier.dart';
import 'package:newproject/utils/flutter_background_service.dart';
import 'package:provider/provider.dart';

FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SharedPrefsHelper().init();
  FlutterBluePlus.setLogLevel(LogLevel.verbose, color: true);
  await initializeService();
  runApp(
    MultiProvider(
      providers: [

        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => OtpProvider()),
        ChangeNotifierProvider(create: (_) => ResendOtp()),
        ChangeNotifierProvider(create: (_) => Bolusdelivery()),
        ChangeNotifierProvider(create: (_) => BasalDelivery()),
        ChangeNotifierProvider(create: (_) => WeightSetup()),
        ChangeNotifierProvider(create: (_) => GlucoseDelivery()),
        ChangeNotifierProvider(create: (_) => NutritionChartNotifier()),
        ChangeNotifierProvider(create: (_) => ThemeNotifier()),
        ChangeNotifierProvider(create: (_) => ProfileUpdateNotifier()),
        ChangeNotifierProvider(create: (_) => SmartBolusDelivery()),
        ChangeNotifierProvider(create: (_) => BleManager()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  MyApp({super.key});
  final _sharedPref = SharedPrefsHelper();
  @override
  Widget build(
    BuildContext context,
  ) {
    return Consumer<ThemeNotifier>(
      builder: (context, value, child) {
        print('this value ${value.isDarkMode}');
        if (_sharedPref.getBool('darkMode') == true) {
          Provider.of<ThemeNotifier>(context, listen: false)
              .themeMode(_sharedPref.getBool('darkMode')!);
        }

        return MaterialApp(
          theme: lightMode,
          darkTheme: darkMode,
          themeMode: value.isDarkMode && _sharedPref.getBool('darkMode') == true
              ? ThemeMode.dark
              : ThemeMode.light,
          debugShowCheckedModeBanner: false,
          initialRoute: "/HomeScreen",
          routes: {
            "/SplashScreen": (context) => Splashscreen(),
            "/HomeScreen": (context) => HomeScreen(),
            "/DeviceSetupScreen": (context) => DeviceSetupScreen(),
            "/WeightScreen": (context) => WeightScreen(),
            "/InsulinScreen": (context) => InsulinScreen(),
            "/NutritionScreen": (context) => NutritionScreen(),
            "/ProfileScreen": (context) => ProfileScreen(),
            "/SetupProfile": (context) => SetupProfile(),
            "/GlucoseScreen": (context) => GlucoseScreen(),
            "/SettingScreen": (context) => SettingsScreen(),
            "/BolusWizard": (context) => BolusWizard(),
            "/BasalWizard": (context) => BasalWizard(),
            "/SmartBolusScreen": (context) => SmartBolusScreen(),
            "/DevicesScreen": (context) => DevicesScreen(),
            "/Login": (context) => Login(),
          },
        );
      },
    );
  }
}
