import 'dart:convert';

SearchFoodItem searchFoodItemFromJson(String str) =>
    SearchFoodItem.fromJson(json.decode(str));

String searchFoodItemToJson(SearchFoodItem data) => json.encode(data.toJson());

class SearchFoodItem {
  int statusCode;
  String statusValue;
  String message;
  List<FoodItem> data;

  SearchFoodItem({
    required this.statusCode,
    required this.statusValue,
    required this.message,
    required this.data,
  });

  factory SearchFoodItem.fromJson(Map<String, dynamic> json) => SearchFoodItem(
        statusCode: json["statusCode"],
        statusValue: json["statusValue"],
        message: json["message"],
        data:
            List<FoodItem>.from(json["data"].map((x) => FoodItem.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "statusCode": statusCode,
        "statusValue": statusValue,
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class FoodItem {
  String? id;
  String calories;
  String fat;
  String carbs;
  String protein;
  String? brandName;
  String? foodDescription;
  String? foodName;
  String? quantity;
  String? carbs_per_unit;

  FoodItem({
    this.id,
    required this.calories,
    required this.fat,
    required this.carbs,
    required this.protein,
    this.brandName,
    this.foodDescription,
    this.foodName,
     this.quantity,
     this.carbs_per_unit
  });



  factory FoodItem.fromJson(Map<String, dynamic> json) => FoodItem(
        id: json["_id"],
        calories: json["Calories"],
        fat: json["Fat"],
        carbs: json["Carbs"],
        protein: json["Protein"],
        brandName: json["brand_name"],
        foodDescription: json["food_description"],
        foodName: json["food_name"],
        quantity: json["quantity"],
        carbs_per_unit: json['carbs_per_unit']
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "Calories": calories,
        "Fat": fat,
        "Carbs": carbs,
        "Protein": protein,
        "brand_name": brandName,
        "food_description": foodDescription,
        "food_name": foodName,
        "quantity": quantity,
        "carbs_per_unit" : carbs_per_unit
      };
}

