// To parse this JSON data, do
//
//     final provincesModel = provincesModelFromJson(jsonString);

import 'dart:convert';

ProvincesModel provincesModelFromJson(String str) => ProvincesModel.fromJson(json.decode(str));

String provincesModelToJson(ProvincesModel data) => json.encode(data.toJson());

class ProvincesModel {
  String status;
  String message;
  List<String> data;

  ProvincesModel({
    required this.status,
    required this.message,
    required this.data,
  });

  factory ProvincesModel.fromJson(Map<String, dynamic> json) => ProvincesModel(
    status: json["status"],
    message: json["message"],
    data: List<String>.from(json["data"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": List<dynamic>.from(data.map((x) => x)),
  };
}
