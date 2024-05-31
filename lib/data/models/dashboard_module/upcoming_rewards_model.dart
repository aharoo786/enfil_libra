// To parse this JSON data, do
//
//     final upcomingRewardsModel = upcomingRewardsModelFromJson(jsonString);

import 'dart:convert';

UpcomingRewardsModel upcomingRewardsModelFromJson(String str) =>
    UpcomingRewardsModel.fromJson(json.decode(str));

String upcomingRewardsModelToJson(UpcomingRewardsModel data) =>
    json.encode(data.toJson());

class UpcomingRewardsModel {
  String status;
  String message;
  Data data;

  UpcomingRewardsModel({
    required this.status,
    required this.message,
    required this.data,
  });

  factory UpcomingRewardsModel.fromJson(Map<String, dynamic> json) =>
      UpcomingRewardsModel(
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
  String? name;
  int? remainingDays;
  double? percentageCompleted;
  String? totalPoint;

  Data({
    required this.name,
    required this.remainingDays,
    required this.percentageCompleted,
    required this.totalPoint,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        name: json["name"],
        remainingDays: json["remaining_days"],
        percentageCompleted: json["percentage_completed"] == null
            ? 0.0
            : json["percentage_completed"].toDouble(),
        totalPoint: json["total_point"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "remaining_days": remainingDays,
        "percentage_completed": percentageCompleted,
        "total_point": totalPoint,
      };
}
