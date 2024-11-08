import 'dart:convert';
import 'dart:io';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefsHelper {
  static final SharedPrefsHelper _instance = SharedPrefsHelper._internal();
  SharedPreferences? _sharedPreferences;

  factory SharedPrefsHelper() {
    return _instance;
  }

  SharedPrefsHelper._internal();

  Future<void> init() async {
    _sharedPreferences = await SharedPreferences.getInstance();
  }

  Future<void> putString(String key, String value) async {
    await _sharedPreferences?.setString(key, value);
  }

  String? getString(String key) {
    return _sharedPreferences?.getString(key);
  }

  Future<void> putStringList(String key, List<String> value) async {
    await _sharedPreferences?.setStringList(key, value);
  }

  List<String>? getStringList(String key) {
    return _sharedPreferences?.getStringList(key) ?? [];
  }

  Future<void> putInt(String key, int value) async {
    await _sharedPreferences?.setInt(key, value);
  }

  int? getInt(String key) {
    return _sharedPreferences?.getInt(key);
  }

  Future<void> putBool(String key, bool value) async {
    await _sharedPreferences?.setBool(key, value);
  }

  bool? getBool(String key) {
    return _sharedPreferences?.getBool(key);
  }

  Future<void> remove(String key) async {
    await _sharedPreferences?.remove(key);
  }

  // Store image file as Base64 string
  Future<void> putImageFile(String key, File imageFile) async {
    List<int> imageBytes = await imageFile.readAsBytes();
    String base64String = base64Encode(imageBytes);
    await _sharedPreferences?.setString(key, base64String);
  }

  // Retrieve image file from Base64 string
  File? getImageFile(String key, String filePath) {
    String? base64String = _sharedPreferences?.getString(key);
    if (base64String == null) return null;

    List<int> imageBytes = base64Decode(base64String);
    File imageFile = File(filePath);
    imageFile.writeAsBytesSync(imageBytes);
    return imageFile;
  }


  Future<void> setDouble(String key, double value) async {
    await _sharedPreferences?.setDouble(key, value);
  }

  double? getDouble(String key) {
    return _sharedPreferences?.getDouble(key);
  }
}
