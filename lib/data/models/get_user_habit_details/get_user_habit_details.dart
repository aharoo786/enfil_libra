// To parse this JSON data, do
//
//     final getUserHabitDetails = getUserHabitDetailsFromJson(jsonString);

import 'dart:convert';

GetUserHabitDetails getUserHabitDetailsFromJson(String str) =>
    GetUserHabitDetails.fromJson(json.decode(str));

String getUserHabitDetailsToJson(GetUserHabitDetails data) =>
    json.encode(data.toJson());

class GetUserHabitDetails {
  String status;
  String message;
  Data data;

  GetUserHabitDetails({
    required this.status,
    required this.message,
    required this.data,
  });

  factory GetUserHabitDetails.fromJson(Map<String, dynamic> json) =>
      GetUserHabitDetails(
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
  String category;
  String icon;
  String subCategory;
  String description;
  String name;
  String color;
  String frequency;
  dynamic slot;
  String counter;
  String reminder;
  String createdAt;

  Data({
    required this.id,
    required this.category,
    required this.icon,
    required this.subCategory,
    required this.description,
    required this.name,
    required this.color,
    required this.frequency,
    required this.slot,
    required this.counter,
    required this.reminder,
    required this.createdAt,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"],
        category: json["category"],
        icon: json["icon"],
        subCategory: json["sub_category"],
        description: json["description"],
        name: json["name"],
        color: json["color"],
        frequency: json["frequency"],
        slot: json["slot"],
        counter: json["counter"],
        reminder: json["reminder"] ??"N/A",
        createdAt: json["created_at"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "category": category,
        "icon": icon,
        "sub_category": subCategory,
        "description": description,
        "name": name,
        "color": color,
        "frequency": frequency,
        "slot": slot,
        "counter": counter,
        "reminder": reminder,
        "created_at": createdAt,
      };
}
