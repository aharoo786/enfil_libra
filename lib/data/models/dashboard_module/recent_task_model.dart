// To parse this JSON data, do
//
//     final recentTasksModel = recentTasksModelFromJson(jsonString);

import 'dart:convert';

RecentTasksModel recentTasksModelFromJson(String str) => RecentTasksModel.fromJson(json.decode(str));

String recentTasksModelToJson(RecentTasksModel data) => json.encode(data.toJson());

class RecentTasksModel {
  String status;
  String message;
  List<RecentTask> data;

  RecentTasksModel({
    required this.status,
    required this.message,
    required this.data,
  });

  factory RecentTasksModel.fromJson(Map<String, dynamic> json) => RecentTasksModel(
    status: json["status"],
    message: json["message"],
    data: List<RecentTask>.from(json["data"].map((x) => RecentTask.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class RecentTask {
  int id;
  String name;
  String totalRewards;
  String days;
  String earnRewards;
  int percentageCompleted;
  String status;
  String startedAt;
  String endedAt;
  String videoUrl;
  String description;

  RecentTask({
    required this.id,
    required this.name,
    required this.totalRewards,
    required this.days,
    required this.earnRewards,
    required this.percentageCompleted,
    required this.status,
    required this.startedAt,
    required this.endedAt,
    required this.videoUrl,
    required this.description,
  });

  factory RecentTask.fromJson(Map<String, dynamic> json) => RecentTask(
    id: json["id"],
    name: json["name"],
    totalRewards: json["total_rewards"],
    days: json["days"],
    earnRewards: json["earn_rewards"],
    percentageCompleted: json["percentage_completed"],
    status: json["status"],
    startedAt: json["started_at"],
    endedAt: json["ended_at"],
    videoUrl: json["video_url"]??"",
    description: json["description"] ?? "N/A",
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "total_rewards": totalRewards,
    "days": days,
    "earn_rewards": earnRewards,
    "percentage_completed": percentageCompleted,
    "status": status,
    "started_at": startedAt,
    "ended_at": endedAt,
    "video_url": videoUrl,
    "description": description,
  };
}
