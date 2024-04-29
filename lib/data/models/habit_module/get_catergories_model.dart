// To parse this JSON data, do
//
//     final categoriesModel = categoriesModelFromJson(jsonString);

import 'dart:convert';

CategoriesModel categoriesModelFromJson(String str) => CategoriesModel.fromJson(json.decode(str));

String categoriesModelToJson(CategoriesModel data) => json.encode(data.toJson());

class CategoriesModel {
  String status;
  String message;
  List<Datum> data;

  CategoriesModel({
    required this.status,
    required this.message,
    required this.data,
  });

  factory CategoriesModel.fromJson(Map<String, dynamic> json) => CategoriesModel(
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
  int id;
  String name;
  String slug;
  List<SubCategory> subCategories;

  Datum({
    required this.id,
    required this.name,
    required this.slug,
    required this.subCategories,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"],
    name: json["name"],
    slug: json["slug"],
    subCategories: List<SubCategory>.from(json["sub_categories"].map((x) => SubCategory.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "slug": slug,
    "sub_categories": List<dynamic>.from(subCategories.map((x) => x.toJson())),
  };
}

class SubCategory {
  int id;
  String name;

  SubCategory({
    required this.id,
    required this.name,
  });

  factory SubCategory.fromJson(Map<String, dynamic> json) => SubCategory(
    id: json["id"],
    name: json["name"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
  };
}
