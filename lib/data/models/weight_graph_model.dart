class YearModel {
  String jan;
  String feb;
  String mar;
  String apr;
  String may;
  String jun;
  String jul;
  String aug;
  String sep;
  String oct;
  String nov;
  String dec;

  YearModel({
    required this.jan,
    required this.feb,
    required this.mar,
    required this.apr,
    required this.may,
    required this.jun,
    required this.jul,
    required this.aug,
    required this.sep,
    required this.oct,
    required this.nov,
    required this.dec,
  });

  factory YearModel.fromJson(Map<String, dynamic> json) => YearModel(
        jan: json["Jan"],
        feb: json["Feb"],
        mar: json["Mar"],
        apr: json["Apr"],
        may: json["May"],
        jun: json["Jun"],
        jul: json["Jul"],
        aug: json["Aug"],
        sep: json["Sep"],
        oct: json["Oct"],
        nov: json["Nov"],
        dec: json["Dec"],
      );

  Map<String, dynamic> toJson() => {
        "Jan": jan,
        "Feb": feb,
        "Mar": mar,
        "Apr": apr,
        "May": may,
        "Jun": jun,
        "Jul": jul,
        "Aug": aug,
        "Sep": sep,
        "Oct": oct,
        "Nov": nov,
        "Dec": dec,
      };
}

class MonthlyModel {
  String week1;
  String week2;
  String week3;
  String week4;

  MonthlyModel({
    required this.week1,
    required this.week2,
    required this.week3,
    required this.week4,
  });

  factory MonthlyModel.fromJson(Map<String, dynamic> json) => MonthlyModel(
        week1: json["1-7"],
        week2: json["8-14"],
        week3: json["15-21"],
        week4: json["22-28"],
      );

  Map<String, dynamic> toJson() => {
        "1-7": week1,
        "8-14": week2,
        "15-21": week3,
        "22-28": week4,
      };
}

class WeeklyModel {
  String mon;
  String tue;
  String wed;
  String thu;
  String fri;
  String sat;
  String sun;

  WeeklyModel({
    required this.mon,
    required this.tue,
    required this.wed,
    required this.thu,
    required this.fri,
    required this.sat,
    required this.sun,
  });

  factory WeeklyModel.fromJson(Map<String, dynamic> json) => WeeklyModel(
        mon: json["Mon"],
        tue: json["Tue"],
        wed: json["Wed"],
        thu: json["Thu"],
        fri: json["Fri"],
        sat: json["Sat"],
        sun: json["Sun"],
      );

  Map<String, dynamic> toJson() => {
        "Mon": mon,
        "Tue": tue,
        "Wed": wed,
        "Thu": thu,
        "Fri": fri,
        "Sat": sat,
        "Sun": sun,
      };
}


class MonthtoDaysModel {
  String mon;
  String tue;
  String wed;
  String thu;
  String fri;
  String sat;
  String sun;

  MonthtoDaysModel({
    required this.mon,
    required this.tue,
    required this.wed,
    required this.thu,
    required this.fri,
    required this.sat,
    required this.sun,
  });

  factory MonthtoDaysModel.fromJson(Map<String, dynamic> json) => MonthtoDaysModel(
        mon: json["Mon"],
        tue: json["Tue"],
        wed: json["Wed"],
        thu: json["Thu"],
        fri: json["Fri"],
        sat: json["Sat"],
        sun: json["Sun"],
      );

  Map<String, dynamic> toJson() => {
        "Mon": mon,
        "Tue": tue,
        "Wed": wed,
        "Thu": thu,
        "Fri": fri,
        "Sat": sat,
        "Sun": sun,
      };
}
