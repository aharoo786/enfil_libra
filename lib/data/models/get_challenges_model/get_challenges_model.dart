// To parse this JSON data, do
//
//     final getChallengesModel = getChallengesModelFromJson(jsonString);

import 'dart:convert';

GetChallengesModel getChallengesModelFromJson(String str) =>
    GetChallengesModel.fromJson(json.decode(str));

String getChallengesModelToJson(GetChallengesModel data) =>
    json.encode(data.toJson());

class GetChallengesModel {
  String status;
  String message;
  List<Challenges> data;

  GetChallengesModel({
    required this.status,
    required this.message,
    required this.data,
  });

  factory GetChallengesModel.fromJson(Map<String, dynamic> json) =>
      GetChallengesModel(
        status: json["status"],
        message: json["message"],
        data: List<Challenges>.from(
            json["data"].map((x) => Challenges.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class Challenges {
  int id;
  String name;
  String rewardPoint;
  String numberOfDay;
  String videoUrl;
  String description;
  String startedDate;
  String endedDate;

  Challenges({
    required this.id,
    required this.name,
    required this.rewardPoint,
    required this.numberOfDay,
    required this.videoUrl,
    required this.description,
    required this.startedDate,
    required this.endedDate,
  });

  factory Challenges.fromJson(Map<String, dynamic> json) => Challenges(
      id: json["id"],
      name: json["name"],
      rewardPoint: json["reward_point"],
      numberOfDay: json["number_of_day"].toString(),
      videoUrl: json["video_url"],
      description: json["description"] ?? "N/A",
      startedDate: json["started_at"]??"N/A",
      endedDate: json["ended_at"]??"N/A");

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "reward_point": rewardPoint,
        "number_of_day": numberOfDay,
        "video_url": videoUrl,
        "description": description,
        "endedDate": endedDate,
        "startedDate": startedDate,
      };
}
