// To parse this JSON data, do
//
//     final getUserHabits = getUserHabitsFromJson(jsonString);

import 'dart:convert';

GetUserHabits getUserHabitsFromJson(String str) => GetUserHabits.fromJson(json.decode(str));

String getUserHabitsToJson(GetUserHabits data) => json.encode(data.toJson());

class GetUserHabits {
  String status;
  String message;
  List<UserHabit> data;

  GetUserHabits({
    required this.status,
    required this.message,
    required this.data,
  });

  factory GetUserHabits.fromJson(Map<String, dynamic> json) => GetUserHabits(
    status: json["status"],
    message: json["message"],
    data: List<UserHabit>.from(json["data"].map((x) => UserHabit.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class UserHabit {
  int id;
  String name;
  String color;
  String frequency;
  dynamic slot;
  String counter;
  String? reminder;

  UserHabit({
    required this.id,
    required this.name,
    required this.color,
    required this.frequency,
    required this.slot,
    required this.counter,
    required this.reminder,
  });

  factory UserHabit.fromJson(Map<String, dynamic> json) => UserHabit(
    id: json["id"],
    name: json["name"],
    color: json["color"],
    frequency: json["frequency"],
    slot: json["slot"],
    counter: json["counter"],
    reminder: json["reminder"] ??"N/A"
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "color": color,
    "frequency": frequency,
    "slot": slot,
    "counter": counter,
    "reminder": reminder,
  };
}
