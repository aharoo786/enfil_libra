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
  List<UserChallenges> data;

  GetUserChallenges({
    required this.status,
    required this.message,
    required this.data,
  });

  factory GetUserChallenges.fromJson(Map<String, dynamic> json) =>
      GetUserChallenges(
        status: json["status"],
        message: json["message"],
        data: List<UserChallenges>.from(
            json["data"].map((x) => UserChallenges.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class UserChallenges {
  int id;
  String userId;
  String challengeId;
  String days;
  String rewards;
  String status;
  DateTime createdAt;
  DateTime updatedAt;
  dynamic deletedAt;

  UserChallenges({
    required this.id,
    required this.userId,
    required this.challengeId,
    required this.days,
    required this.rewards,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    required this.deletedAt,
  });

  factory UserChallenges.fromJson(Map<String, dynamic> json) => UserChallenges(
        id: json["id"],
        userId: json["user_id"].toString(),
        challengeId: json["challenge_id"].toString(),
        days: json["days"].toString(),
        rewards: json["rewards"].toString(),
        status: json["status"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        deletedAt: json["deleted_at"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "challenge_id": challengeId,
        "days": days,
        "rewards": rewards,
        "status": status,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "deleted_at": deletedAt,
      };
}
