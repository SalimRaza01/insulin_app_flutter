// To parse this JSON data, do
//
//     final todayNutrition = todayNutritionFromJson(jsonString);

import 'dart:convert';

NutritionDonutData todayNutritionFromJson(String str) => NutritionDonutData.fromJson(json.decode(str));

String todayNutritionToJson(NutritionDonutData data) => json.encode(data.toJson());

class NutritionDonutData {
    int statusCode;
    String statusValue;
    String message;
    List<NutritionDonutDataItem> data;

    NutritionDonutData({
        required this.statusCode,
        required this.statusValue,
        required this.message,
        required this.data,
    });

    factory NutritionDonutData.fromJson(Map<String, dynamic> json) => NutritionDonutData(
        statusCode: json["statusCode"],
        statusValue: json["statusValue"],
        message: json["message"],
        data: List<NutritionDonutDataItem>.from(json["data"][0].map((x) => NutritionDonutDataItem.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "statusCode": statusCode,
        "statusValue": statusValue,
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
    };
}

class NutritionDonutDataItem {
    int? id;
    int? totalCalories;
    int? totalFat;
    int? totalCarbs;
    int? totalProtein;

    NutritionDonutDataItem({
         this.id,
         this.totalCalories,
          this.totalFat,
          this.totalCarbs,
          this.totalProtein,
    });

    factory NutritionDonutDataItem.fromJson(Map<String, dynamic> json) => NutritionDonutDataItem(
        id: json["_id"],
        totalCalories: json["totalCalories"],
        totalFat: json["totalFat"],
        totalCarbs: json["totalCarbs"],
        totalProtein: json["totalProtein"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "totalCalories": totalCalories,
        "totalFat": totalFat,
        "totalCarbs": totalCarbs,
        "totalProtein": totalProtein,
    };
}
