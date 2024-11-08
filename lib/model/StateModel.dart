class Statemodel {
  String? name;

  Statemodel({
    this.name,
  });

  factory Statemodel.fromJson(Map<String, dynamic> json) => Statemodel(
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
      };
}
