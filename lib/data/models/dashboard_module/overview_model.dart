// To parse this JSON data, do
//
//     final overviewModel = overviewModelFromJson(jsonString);

import 'dart:convert';

OverviewModel overviewModelFromJson(String str) => OverviewModel.fromJson(json.decode(str));

String overviewModelToJson(OverviewModel data) => json.encode(data.toJson());

class OverviewModel {
  String status;
  String message;
  List<Overview> data;

  OverviewModel({
    required this.status,
    required this.message,
    required this.data,
  });

  factory OverviewModel.fromJson(Map<String, dynamic> json) => OverviewModel(
    status: json["status"],
    message: json["message"],
    data: List<Overview>.from(json["data"].map((x) => Overview.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class Overview {
  String name;
  int percentageCompleted;

  Overview({
    required this.name,
    required this.percentageCompleted,
  });

  factory Overview.fromJson(Map<String, dynamic> json) => Overview(
    name: json["name"],
    percentageCompleted: json["percentage_completed"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "percentage_completed": percentageCompleted,
  };
}
