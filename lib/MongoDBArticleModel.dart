// To parse this JSON data, do
//
//     final mongodbArticleModel = mongodbArticleModelFromJson(jsonString);

import 'dart:convert';

import 'package:mongo_dart/mongo_dart.dart';

MongodbArticleModel mongodbArticleModelFromJson(String str) =>
    MongodbArticleModel.fromJson(json.decode(str));

String mongodbArticleModelToJson(MongodbArticleModel data) =>
    json.encode(data.toJson());

class MongodbArticleModel {
  MongodbArticleModel({
    required this.id,
    required this.subject,
    required this.article,
    required this.uploaded,
    required this.userdetails,
  });

  ObjectId id;
  String subject;
  String article;
  String uploaded;
  Userdetails userdetails;

  factory MongodbArticleModel.fromJson(Map<String, dynamic> json) =>
      MongodbArticleModel(
        id: json["_id"],
        subject: json["subject"],
        article: json["article"],
        uploaded: json["uploaded"],
        userdetails: Userdetails.fromJson(json["userdetails"]),
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "subject": subject,
        "article": article,
        "uploaded": uploaded,
        "userdetails": userdetails.toJson(),
      };
}

class Userdetails {
  Userdetails({
    required this.name,
    required this.userid,
  });

  String name;
  String userid;

  factory Userdetails.fromJson(Map<String, dynamic> json) => Userdetails(
        name: json["name"],
        userid: json["userid"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "userid": userid,
      };
}
