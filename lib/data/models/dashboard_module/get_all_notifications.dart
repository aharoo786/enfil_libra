// To parse this JSON data, do
//
//     final getAllNotifications = getAllNotificationsFromJson(jsonString);

import 'dart:convert';

GetAllNotifications getAllNotificationsFromJson(String str) =>
    GetAllNotifications.fromJson(json.decode(str));

String getAllNotificationsToJson(GetAllNotifications data) =>
    json.encode(data.toJson());

class GetAllNotifications {
  String status;
  String message;
  List<Notification> data;

  GetAllNotifications({
    required this.status,
    required this.message,
    required this.data,
  });

  factory GetAllNotifications.fromJson(Map<String, dynamic> json) =>
      GetAllNotifications(
        status: json["status"],
        message: json["message"],
        data: List<Notification>.from(json["data"].map((x) => Notification.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class Notification {
  String id;
  Data data;
  DateTime createdAt;
  dynamic readAt;

  Notification({
    required this.id,
    required this.data,
    required this.createdAt,
    required this.readAt,
  });

  factory Notification.fromJson(Map<String, dynamic> json) => Notification(
        id: json["id"],
        data: Data.fromJson(json["data"]),
        createdAt: DateTime.parse(json["created_at"]),
        readAt: json["read_at"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "data": data.toJson(),
        "created_at": createdAt.toIso8601String(),
        "read_at": readAt,
      };
}

class Data {
  String message;

  Data({
    required this.message,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "message": message,
      };
}
