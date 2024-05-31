// To parse this JSON data, do
//
//     final userChallengeHistory = userChallengeHistoryFromJson(jsonString);

import 'dart:convert';

UserChallengeHistory userChallengeHistoryFromJson(String str) =>
    UserChallengeHistory.fromJson(json.decode(str));

String userChallengeHistoryToJson(UserChallengeHistory data) =>
    json.encode(data.toJson());

class UserChallengeHistory {
  String status;
  String message;
  Data data;

  UserChallengeHistory({
    required this.status,
    required this.message,
    required this.data,
  });

  factory UserChallengeHistory.fromJson(Map<String, dynamic> json) =>
      UserChallengeHistory(
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
  int id;
  String name;
  String totalRewards;
  String days;
  String earnRewards;
  String status;
  String leftDays;
  List<ChallengeHistory> challengeHistories;

  Data({
    required this.id,
    required this.name,
    required this.totalRewards,
    required this.days,
    required this.earnRewards,
    required this.status,
    required this.leftDays,
    required this.challengeHistories,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"],
        name: json["name"],
        totalRewards: json["total_rewards"],
        days: json["days"].toString(),
        earnRewards: json["earn_rewards"],
        status: json["status"],
        leftDays: json["left_days"].toString(),
        challengeHistories: List<ChallengeHistory>.from(
            json["challenge_histories"]
                .map((x) => ChallengeHistory.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "total_rewards": totalRewards,
        "days": days,
        "earn_rewards": earnRewards,
        "status": status,
        "left_days": leftDays,
        "challenge_histories":
            List<dynamic>.from(challengeHistories.map((x) => x.toJson())),
      };
}

class ChallengeHistory {
  String day;
  DateTime startedAt;
  DateTime endedAt;
  String status;

  ChallengeHistory({
    required this.day,
    required this.startedAt,
    required this.endedAt,
    required this.status,
  });

  factory ChallengeHistory.fromJson(Map<String, dynamic> json) =>
      ChallengeHistory(
        day: json["day"],
        startedAt: DateTime.parse(json["started_at"]),
        endedAt: DateTime.parse(json["ended_at"]),
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "day": day,
        "started_at": startedAt.toIso8601String(),
        "ended_at": endedAt.toIso8601String(),
        "status": status,
      };
}
