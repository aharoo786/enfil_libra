// To parse this JSON data, do
//
//     final myCitiesModel = myCitiesModelFromJson(jsonString);

import 'dart:convert';

MyCitiesModel myCitiesModelFromJson(String str) => MyCitiesModel.fromJson(json.decode(str));

String myCitiesModelToJson(MyCitiesModel data) => json.encode(data.toJson());

class MyCitiesModel {
  String status;
  String message;
  List<Datum> data;

  MyCitiesModel({
    required this.status,
    required this.message,
    required this.data,
  });

  factory MyCitiesModel.fromJson(Map<String, dynamic> json) => MyCitiesModel(
    status: json["status"],
    message: json["message"],
    data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class Datum {
  String id;
  String name;
  String city;
  String destination;
  String location;
  String description;
  String? image;
  bool isFavourite;

  Datum({
    required this.id,
    required this.name,
    required this.city,
    required this.destination,
    required this.location,
    required this.description,
    this.image,
    required this.isFavourite
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"],
    name: json["name"],
    city: json["city"],
    destination: json["destination"],
    location: json["location"],
    description: json["description"],
    image:json["image"],
    isFavourite:json["isFavourite"] ?? false
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "city": city,
    "destination": destination,
    "location": location,
    "description": description,
    "image":image,
    "isFavourite":isFavourite
  };
}
