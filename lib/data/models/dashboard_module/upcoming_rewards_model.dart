// To parse this JSON data, do
//
//     final upcomingRewardsModel = upcomingRewardsModelFromJson(jsonString);

import 'dart:convert';

UpcomingRewardsModel upcomingRewardsModelFromJson(String str) => UpcomingRewardsModel.fromJson(json.decode(str));

String upcomingRewardsModelToJson(UpcomingRewardsModel data) => json.encode(data.toJson());

class UpcomingRewardsModel {
  String status;
  String message;
  List<Datum> data;

  UpcomingRewardsModel({
    required this.status,
    required this.message,
    required this.data,
  });

  factory UpcomingRewardsModel.fromJson(Map<String, dynamic> json) => UpcomingRewardsModel(
    status: json["status"],
    message: json["message"],
    data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class Datum {
  dynamic name;
  dynamic remainingDays;
  int percentageCompleted;
  dynamic totalPoint;

  Datum({
    required this.name,
    required this.remainingDays,
    required this.percentageCompleted,
    required this.totalPoint,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    name: json["name"],
    remainingDays: json["remaining_days"],
    percentageCompleted: json["percentage_completed"],
    totalPoint: json["total_point"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "remaining_days": remainingDays,
    "percentage_completed": percentageCompleted,
    "total_point": totalPoint,
  };
}
