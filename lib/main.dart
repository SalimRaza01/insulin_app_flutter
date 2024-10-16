import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:insulin_app_flutter/AuthScreens/SetupProfile.dart';
import 'package:insulin_app_flutter/AuthScreens/SplashScreen.dart';
import 'package:insulin_app_flutter/AuthScreens/auth_Provider.dart';
import 'package:insulin_app_flutter/Middleware/SharedPrefsHelper.dart';
import 'package:insulin_app_flutter/Screens/AuthModule.dart';
import 'package:insulin_app_flutter/Screens/BasalWizard.dart';
import 'package:insulin_app_flutter/Screens/BolusWizard.dart';
import 'package:insulin_app_flutter/Screens/DeviceSetupScreen.dart';
import 'package:insulin_app_flutter/Screens/DevicesScreen.dart';
import 'package:insulin_app_flutter/Screens/GlucoseScreen.dart';
import 'package:insulin_app_flutter/Screens/HomeScreen.dart';
import 'package:insulin_app_flutter/Screens/InsulinScreen.dart';
import 'package:insulin_app_flutter/Screens/NutritionScreen.dart';
import 'package:insulin_app_flutter/Screens/ProfileScreen.dart';
import 'package:insulin_app_flutter/Screens/SettingsScreen.dart';
import 'package:insulin_app_flutter/Screens/SmartbolusScreen.dart';
import 'package:insulin_app_flutter/Screens/WeightScreen.dart';
import 'package:insulin_app_flutter/utils/BasalDeliveryNotifier.dart';
import 'package:insulin_app_flutter/utils/BolusDeliveryNotifier.dart';
import 'package:insulin_app_flutter/utils/CharacteristicProvider.dart';
import 'package:insulin_app_flutter/utils/DeviceConnectProvider.dart';
import 'package:insulin_app_flutter/utils/DeviceProvider.dart';
import 'package:insulin_app_flutter/utils/GlucoseNotifier.dart';
import 'package:insulin_app_flutter/utils/NutritionNotifier.dart';
import 'package:insulin_app_flutter/utils/ReadNotifier.dart';
import 'package:insulin_app_flutter/utils/SmartBolusDelivery.dart';
import 'package:insulin_app_flutter/utils/Theme.dart';
import 'package:insulin_app_flutter/utils/ThemeProvider.dart';
import 'package:insulin_app_flutter/utils/UpdateProfileNotifier.dart';
import 'package:insulin_app_flutter/utils/WeightNotifier.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SharedPrefsHelper().init();
  FlutterBluePlus.setLogLevel(LogLevel.verbose, color: true);
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ReadNotifier()),
        ChangeNotifierProvider(create: (_) => Deviceprovider()),
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
        ChangeNotifierProvider(create: (_) => CharacteristicProvider()),
        ChangeNotifierProvider(create: (_) => Deviceconnection()),
               ChangeNotifierProvider(create: (_) => SmartBolusDelivery()),
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
          initialRoute: "/SplashScreen",
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
