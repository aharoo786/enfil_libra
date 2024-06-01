// To parse this JSON data, do
//
//     final getUserProfile = getUserProfileFromJson(jsonString);

import 'dart:convert';

GetUserProfile getUserProfileFromJson(String str) => GetUserProfile.fromJson(json.decode(str));

String getUserProfileToJson(GetUserProfile data) => json.encode(data.toJson());

class GetUserProfile {
  String status;
  String message;
  Data data;

  GetUserProfile({
    required this.status,
    required this.message,
    required this.data,
  });

  factory GetUserProfile.fromJson(Map<String, dynamic> json) => GetUserProfile(
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
  String id;
  String firstName;
  String lastName;
  String email;
  dynamic image;
  dynamic gender;
  bool otpVerify;

  Data({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.image,
    required this.gender,
    required this.otpVerify,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    id: json["id"].toString(),
    firstName: json["first_name"],
    lastName: json["last_name"] ??"",
    email: json["email"],
    image: json["image"],
    gender: json["gender"],
    otpVerify: json["otp_verify"] is String ? json["otp_verify"]=="1"?true:false:json["otp_verify"]  ,
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "first_name": firstName,
    "last_name": lastName,
    "email": email,
    "image": image,
    "gender": gender,
    "otp_verify": otpVerify,
  };
}
