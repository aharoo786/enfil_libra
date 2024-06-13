// To parse this JSON data, do
//
//     final overviewScoreModel = overviewScoreModelFromJson(jsonString);

import 'dart:convert';

OverviewScoreModel overviewScoreModelFromJson(String str) =>
    OverviewScoreModel.fromJson(json.decode(str));

String overviewScoreModelToJson(OverviewScoreModel data) =>
    json.encode(data.toJson());

class OverviewScoreModel {
  String status;
  String message;
  Data data;

  OverviewScoreModel({
    required this.status,
    required this.message,
    required this.data,
  });

  factory OverviewScoreModel.fromJson(Map<String, dynamic> json) =>
      OverviewScoreModel(
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
  int weeklyRewards;
  int monthlyRewards;
  int yearlyRewards;
  int totalRewards;
  int completedPercentage;

  Data({
    required this.weeklyRewards,
    required this.monthlyRewards,
    required this.yearlyRewards,
    required this.totalRewards,
    required this.completedPercentage,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        weeklyRewards: json["weekly_rewards"],
        monthlyRewards: json["monthly_rewards"],
        yearlyRewards: json["yearly_rewards"],
        totalRewards: json["total_rewards"],
        completedPercentage: json["completed_percentage"],
      );

  Map<String, dynamic> toJson() => {
        "weekly_rewards": weeklyRewards,
        "monthly_rewards": monthlyRewards,
        "yearly_rewards": yearlyRewards,
        "total_rewards": totalRewards,
        "completed_percentage": completedPercentage,
      };
}
