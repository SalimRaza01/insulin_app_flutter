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
}





// class _FoodItemScreenState extends State<FoodItemScreen> {
//   List<FoodItem> foodItemList = [];

//   // ... Other existing code

//   Future<void> saveMealData() async {
//     final prefs = await SharedPreferences.getInstance();
//     final String mealDataHistory =
//         jsonEncode(foodItemList.map((item) => item.toJson()).toList());
//     await prefs.setString('addMealList', mealDataHistory);
//     print('Saved meal data: $mealDataHistory');
//   }

//   // ... Other existing code

//   @override
//   Widget build(BuildContext context) {
//     // Existing build method
//   }
// }





// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:newproject/model/SearchFoodMeal.dart';
// import 'package:newproject/utils/Colors.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// class NutritionScreen extends StatefulWidget {
//   @override
//   _NutritionScreenState createState() => _NutritionScreenState();
// }

// class _NutritionScreenState extends State<NutritionScreen> {
//   List<FoodItem> mealList = [];

//   @override
//   void initState() {
//     super.initState();
//     fetchMealData();
//   }

//   Future<void> fetchMealData() async {
//     final prefs = await SharedPreferences.getInstance();
//     final List<String>? mealDataHistory = prefs.getStringList('addMealList');
//     if (mealDataHistory != null) {
//       setState(() {
//         mealList = mealDataHistory
//             .map((item) => FoodItem.fromJson(jsonDecode(item)))
//             .toList();
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Nutrition Screen'),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.stretch,
//           children: [
//             Text(
//               'Added Meals:',
//               style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//             ),
//             SizedBox(height: 10),
//             Expanded(
//               child: ListView.builder(
//                 itemCount: mealList.length,
//                 itemBuilder: (context, index) {
//                   final item = mealList[index];
//                   return Container(
//                     margin: EdgeInsets.symmetric(vertical: 5.0),
//                     decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(10),
//                       color: Colors.white,
//                       boxShadow: [
//                         BoxShadow(
//                           offset: Offset(1, 2),
//                           color: Color.fromARGB(255, 199, 199, 199),
//                           blurRadius: 10,
//                         ),
//                       ],
//                     ),
//                     child: Padding(
//                       padding: EdgeInsets.all(15),
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Text(
//                             item.foodName ?? "",
//                             style: TextStyle(
//                               fontWeight: FontWeight.bold,
//                               fontSize: 16,
//                             ),
//                           ),
//                           SizedBox(height: 5),
//                           Text(item.foodDescription!.split('-')[0]),
//                           SizedBox(height: 10),
//                           Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             children: [
//                               Text('Calories: ${item.calories}'),
//                               Text('Carbs: ${item.carbs}'),
//                               Text('Protein: ${item.protein}'),
//                               Text('Fats: ${item.fat}'),
//                             ],
//                           ),
//                         ],
//                       ),
//                     ),
//                   );
//                 },
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
