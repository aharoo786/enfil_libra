// To parse this JSON data, do
//
//     final userStreakModel = userStreakModelFromJson(jsonString);

import 'dart:convert';

UserStreakModel userStreakModelFromJson(String str) => UserStreakModel.fromJson(json.decode(str));

String userStreakModelToJson(UserStreakModel data) => json.encode(data.toJson());

class UserStreakModel {
  String status;
  String message;
  List<UserStreak> data;

  UserStreakModel({
    required this.status,
    required this.message,
    required this.data,
  });

  factory UserStreakModel.fromJson(Map<String, dynamic> json) => UserStreakModel(
    status: json["status"],
    message: json["message"],
    data: List<UserStreak>.from(json["data"].map((x) => UserStreak.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class UserStreak {
  DateTime day;
  bool achieved;

  UserStreak({
    required this.day,
    required this.achieved,
  });

  factory UserStreak.fromJson(Map<String, dynamic> json) => UserStreak(
    day: DateTime.parse(json["day"]),
    achieved: json["achieved"],
  );

  Map<String, dynamic> toJson() => {
    "day": "${day.year.toString().padLeft(4, '0')}-${day.month.toString().padLeft(2, '0')}-${day.day.toString().padLeft(2, '0')}",
    "achieved": achieved,
  };
}
