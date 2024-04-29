// To parse this JSON data, do
//
//     final userModel = userModelFromJson(jsonString);

import 'dart:convert';

UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));

String userModelToJson(UserModel data) => json.encode(data.toJson());

class UserModel {
  String status;
  String message;
  Data data;

  UserModel({
    required this.status,
    required this.message,
    required this.data,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
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
  User user;
  String accessToken;

  Data({
    required this.user,
    required this.accessToken,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    user: User.fromJson(json["user"]),
    accessToken: json["access_token"],
  );

  Map<String, dynamic> toJson() => {
    "user": user.toJson(),
    "access_token": accessToken,
  };
}

class User {
  String id;
  String firstName;
  String lastName;
  String email;
  dynamic image;
  dynamic gender;
  bool otpVerify;

  User({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.image,
    required this.gender,
    required this.otpVerify,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
    id: json["id"].toString(),
    firstName: json["first_name"],
    lastName: json["last_name"]??"",
    email: json["email"],
    image: json["image"],
    gender: json["gender"],
    otpVerify: json["otp_verify"],
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
