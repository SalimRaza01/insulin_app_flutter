import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:newproject/AuthScreens/SignInOTP.dart';
import 'package:newproject/utils/SharedPrefsHelper.dart';
import 'package:newproject/utils/config.dart';

class AuthProvider with ChangeNotifier {
  Future<void> login(String controller, BuildContext context) async {
    try {
      Response response =
          await post(Uri.parse(signInApi), body: {'userId': controller});
 
      if (response.statusCode == 200) {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => SigninOTP(controller)));

        print('successfull');
      } else {
        print(response.body);
        print('failed');

        return null;
      }
    } catch (e) {
      print(e.toString());

      return null;
    }
  }
}

class ResendOtp with ChangeNotifier {
  Future<void> reSendOtp(String controller, BuildContext context) async {
    try {
      Response response =
          await post(Uri.parse(signInApi), body: {'userId': controller});
      print('asda');
      if (response.statusCode == 200) {
        print('successfull');
      } else {
        print('failed');

        return null;
      }
    } catch (e) {
      print(e.toString());

      return null;
    }
  }
}

class OtpProvider with ChangeNotifier {
  final _sharedPreference = SharedPrefsHelper();

  Future<void> otpverify(
    String otpFields,
  ) async {
    try {
      Response response =
          await post(Uri.parse(getotp), body: {'otp': otpFields});
      print('asda');
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
print("login response $data");
        String id = data["data"]["_id"];
        bool isProfileCompleted = data['data']['isProfileCompleted'];
        bool isDeviceSetup = data['data']['isDeviceSetup'];
   
        _sharedPreference.putString('userId', id);
        _sharedPreference.putBool("isLoggedIn", true);
        _sharedPreference.putBool('isProfileCompleted', isProfileCompleted);
        _sharedPreference.putBool('isDeviceSetup', isDeviceSetup);

        print('successfull');
      } else {
        var data = jsonDecode(response.body);
        String message = data["message"];

        _sharedPreference.putString('message', message);

        print(message);
        print('failed');
      }
    } catch (e) {
      print(e.toString());

      return null;
    }
  }
}
