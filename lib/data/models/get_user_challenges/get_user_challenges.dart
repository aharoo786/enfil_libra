// To parse this JSON data, do
//
//     final getUserChallenges = getUserChallengesFromJson(jsonString);

import 'dart:convert';

GetUserChallenges getUserChallengesFromJson(String str) =>
    GetUserChallenges.fromJson(json.decode(str));

String getUserChallengesToJson(GetUserChallenges data) =>
    json.encode(data.toJson());

class GetUserChallenges {
  String status;
  String message;
  Data data;

  GetUserChallenges({
    required this.status,
    required this.message,
    required this.data,
  });

  factory GetUserChallenges.fromJson(Map<String, dynamic> json) =>
      GetUserChallenges(
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
  List<Record>? record;
  Page page;

  Data({
    required this.record,
    required this.page,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        record:
        json["record"]==null?null: List<Record>.from(json["record"].map((x) => Record.fromJson(x))),
        page: Page.fromJson(json["page"]),
      );

  Map<String, dynamic> toJson() => {
        "record": List<dynamic>.from(record!.map((x) => x.toJson())),
        "page": page.toJson(),
      };
}

class Page {
  int currentPage;
  dynamic nextPageUrl;
  dynamic previousPageUrl;
  int lastPage;
  int perPage;
  int count;
  int total;

  Page({
    required this.currentPage,
    required this.nextPageUrl,
    required this.previousPageUrl,
    required this.lastPage,
    required this.perPage,
    required this.count,
    required this.total,
  });

  factory Page.fromJson(Map<String, dynamic> json) => Page(
        currentPage: json["currentPage"],
        nextPageUrl: json["nextPageUrl"],
        previousPageUrl: json["previousPageUrl"],
        lastPage: json["lastPage"],
        perPage: json["perPage"],
        count: json["count"],
        total: json["total"],
      );

  Map<String, dynamic> toJson() => {
        "currentPage": currentPage,
        "nextPageUrl": nextPageUrl,
        "previousPageUrl": previousPageUrl,
        "lastPage": lastPage,
        "perPage": perPage,
        "count": count,
        "total": total,
      };
}

class Record {
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

  Record({
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

  factory Record.fromJson(Map<String, dynamic> json) => Record(
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
