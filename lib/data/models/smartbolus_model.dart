

class SmartBolusGraphModel {
  String? time;
  String? hourInterval;
  String? unit;

  SmartBolusGraphModel({
    this.time,
    this.hourInterval,
    this.unit,
  });

  factory SmartBolusGraphModel.fromJson(Map<String, dynamic> json) => SmartBolusGraphModel(
        time: json["time"],
        hourInterval: json["hourInterval"],
        unit: json["unit"],

      );

  Map<String, dynamic> toJson() => {
        "time": time,
        "hourInterval": hourInterval,
        "unit": unit,
      };
}
