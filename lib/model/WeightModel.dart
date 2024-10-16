// To parse this JSON data, do
//
//     final weightModel = weightModelFromJson(jsonString);

import 'dart:convert';

WeightModel weightModelFromJson(String str) => WeightModel.fromJson(json.decode(str));

String weightModelToJson(WeightModel data) => json.encode(data.toJson());

class WeightModel {
    int statusCode;
    String statusValue;
    String message;
    List<WeightPostData> data;

    WeightModel({
        required this.statusCode,
        required this.statusValue,
        required this.message,
        required this.data,
    });

    factory WeightModel.fromJson(Map<String, dynamic> json) => WeightModel(
        statusCode: json["statusCode"],
        statusValue: json["statusValue"],
        message: json["message"],
        data: List<WeightPostData>.from(json["data"].map((x) => WeightPostData.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "statusCode": statusCode,
        "statusValue": statusValue,
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
    };
}

class WeightPostData {
    String? id;
    String? userId;
    String? weight;
    String? dateTime;
    DateTime? createdAt;
    DateTime? updatedAt;
    int? v;

    WeightPostData({
        this.id,
        this.userId,
        this.weight,
        this.dateTime,
        this.createdAt,
        this.updatedAt,
        this.v,
    });

    factory WeightPostData.fromJson(Map<String, dynamic> json) => WeightPostData(
        id: json["_id"],
        userId: json["userId"],
        weight: json["weight"],
        dateTime: json["dateTime"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        v: json["__v"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "userId": userId,
        "weight": weight,
        "dateTime": dateTime,
        "createdAt": createdAt!.toIso8601String(),
        "updatedAt": updatedAt!.toIso8601String(),
        "__v": v,
    };
}
