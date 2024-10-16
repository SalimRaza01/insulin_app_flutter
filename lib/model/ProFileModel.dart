class ProfileModel {
  String? firstName;
  String? lastName;
  String? dob;
  String? phone;
  String? email;
  String? age;
  String? city;
  String? state;
  String? gender;
  String? height;
  String? weight;
  bool? diabetes;
  bool? hypertension;

  ProfileModel({
    this.firstName,
    this.lastName,
    this.dob,
    this.phone,
    this.email,
    this.age,
    this.city,
    this.state,
    this.gender,
    this.height,
    this.weight,
    this.diabetes,
    this.hypertension,
  });

  factory ProfileModel.fromJson(Map<String, dynamic> json) => ProfileModel(
        firstName: json["firstName"],
        lastName: json["lastName"],
        dob: json["dob"],
        phone: json["phone"],
        email: json["email"],
        age: json["age"],
        city: json["city"],
        state: json["state"],
        gender: json["gender"],
        height: json["height"],
        weight: json["weight"],
        diabetes: json["diabetes"],
        hypertension: json["hypertension"],
      );

  Map<String, dynamic> toJson() => {
        "firstName": firstName,
        "lastName": lastName,
        "dob": dob,
        "phone": phone,
        "email": email,
        "age": age,
        "city": city,
        "state": state,
        "gender": gender,
        "height": height,
        "weight": weight,
        "diabetes": diabetes,
        "hypertension": hypertension,
      };
}
