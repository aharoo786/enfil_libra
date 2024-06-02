// To parse this JSON data, do
//
//     final userStreakModel = userStreakModelFromJson(jsonString);

import 'dart:convert';

UserStreakModel userStreakModelFromJson(String str) => UserStreakModel.fromJson(json.decode(str));

String userStreakModelToJson(UserStreakModel data) => json.encode(data.toJson());

class UserStreakModel {
  String status;
  String message;
  Data data;

  UserStreakModel({
    required this.status,
    required this.message,
    required this.data,
  });

  factory UserStreakModel.fromJson(Map<String, dynamic> json) => UserStreakModel(
    status: json["status"],
    message: json["message"],
    data: Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": data.toJson(),
  };
}

class Data {
  int fantastic;
  List<Steak> steak;

  Data({
    required this.fantastic,
    required this.steak,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    fantastic: json["fantastic"],
    steak: List<Steak>.from(json["steak"].map((x) => Steak.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "fantastic": fantastic,
    "steak": List<dynamic>.from(steak.map((x) => x.toJson())),
  };
}

class Steak {
  DateTime day;
  bool achieved;

  Steak({
    required this.day,
    required this.achieved,
  });

  factory Steak.fromJson(Map<String, dynamic> json) => Steak(
    day: DateTime.parse(json["day"]),
    achieved: json["achieved"],
  );

  Map<String, dynamic> toJson() => {
    "day": day.toIso8601String(),
    "achieved": achieved,
  };
}
