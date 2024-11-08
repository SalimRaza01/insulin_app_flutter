import 'package:flutter/material.dart';

class NutritionChartNotifier extends ChangeNotifier{
  bool nutritionStatus = false;
  bool get nutritionFound => nutritionStatus;

  void nutritionUpdate(bool nutritionFound){
    nutritionStatus = nutritionFound;
    notifyListeners();
  }
}