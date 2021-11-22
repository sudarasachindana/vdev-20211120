// To parse this JSON data, do
//
//     final jokesApi = jokesApiFromJson(jsonString);

import 'dart:convert';

List<Category> categoryApiFromJson(String str) =>
    List<Category>.from(json.decode(str).map((x) => Category.fromJson(x)));

String categoryApiToJson(List<Category> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Category {
  Category({
    this.userId,
    this.id,
    this.title,
    this.body,
  });

  int userId;
  int id;
  String title;
  String body;

  factory Category.fromJson(Map<String, dynamic> json) => Category(
    userId: json["userId"],
    id: json["id"],
    title: json["title"],
    body: json["body"],
      );

  Map<String, dynamic> toJson() => {
    "userId": userId,
    "id": id,
    "title": title,
    "body": body,
      };
}

