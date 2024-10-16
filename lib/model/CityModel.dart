class Citymodel {
  String? name;

  Citymodel({
    this.name,
  });

  factory Citymodel.fromJson(Map<String, dynamic> json) => Citymodel(
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
      };
}
