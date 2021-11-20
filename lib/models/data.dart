// To parse this JSON data, do
//
//     final jokesApi = jokesApiFromJson(jsonString);

import 'dart:convert';

List<JokesApi> jokesApiFromJson(String str) =>
    List<JokesApi>.from(json.decode(str).map((x) => JokesApi.fromJson(x)));

String jokesApiToJson(List<JokesApi> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class JokesApi {
  JokesApi({
    this.userId,
    this.id,
    this.title,
    this.body,
  });

  int userId;
  int id;
  String title;
  String body;

  factory JokesApi.fromJson(Map<String, dynamic> json) => JokesApi(
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

/*enum Type { GENERAL, PROGRAMMING }

final typeValues =
    EnumValues({"general": Type.GENERAL, "programming": Type.PROGRAMMING});

class EnumValues<T> {
  Map<String, T> map;
  Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    if (reverseMap == null) {
      reverseMap = map.map((k, v) => new MapEntry(v, k));
    }
    return reverseMap;
  }
}
*/