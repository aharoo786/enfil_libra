// To parse this JSON data, do
//
//     final userRewardsModel = userRewardsModelFromJson(jsonString);

import 'dart:convert';

UserRewardsModel userRewardsModelFromJson(String str) =>
    UserRewardsModel.fromJson(json.decode(str));

String userRewardsModelToJson(UserRewardsModel data) =>
    json.encode(data.toJson());

class UserRewardsModel {
  String status;
  String message;
  Data data;

  UserRewardsModel({
    required this.status,
    required this.message,
    required this.data,
  });

  factory UserRewardsModel.fromJson(Map<String, dynamic> json) =>
      UserRewardsModel(
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
  String reward;

  Data({
    required this.reward,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        reward: json["reward"].toString(),
      );

  Map<String, dynamic> toJson() => {
        "reward": reward,
      };
}
