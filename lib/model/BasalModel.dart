class BasalModel {
  String? time;
  String? unit;

  BasalModel({
    this.time,
    this.unit,
  });

  factory BasalModel.fromJson(Map<String, dynamic> json) => BasalModel(
        time: json["time"],
        unit: json["unit"],
      );

  Map<String, dynamic> toJson() => {
        "time": time,
        "unit": unit,
      };
}
