// To parse this JSON data, do
//
//     final mongodbUserModel = mongodbUserModelFromJson(jsonString);

import 'dart:convert';

import 'package:mongo_dart/mongo_dart.dart';

MongodbUserModel mongodbUserModelFromJson(String str) =>
    MongodbUserModel.fromJson(json.decode(str));

String mongodbUserModelToJson(MongodbUserModel data) =>
    json.encode(data.toJson());

class MongodbUserModel {
  MongodbUserModel({
   required this.id,
   required this.email,
   required this.password,
    this.profiledetails,
  });

  ObjectId id;
  String email;
  String password;
  Profiledetails? profiledetails;

  factory MongodbUserModel.fromJson(Map<String, dynamic> json) =>
      MongodbUserModel(
        id: json["_id"],
        email: json["email"],
        password: json["password"],
        profiledetails: json["profiledetails"] == null
            ? null
            : Profiledetails.fromJson(json["profiledetails"]),
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "email": email,
        "password": password,
        "profiledetails": profiledetails?.toJson(),
      };
}

class Profiledetails {
  Profiledetails({
    this.name,
    this.gender,
    this.age,
    this.country,
    this.hobbies,
  });

  String? name;
  String? gender;
  int? age;
  String? country;
  String? hobbies;

  factory Profiledetails.fromJson(Map<String, dynamic> json) => Profiledetails(
        name: json["name"],
        gender: json["gender"],
        age: json["age"],
        country: json["country"],
        hobbies: json["hobbies"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "gender": gender,
        "age": age,
        "country": country,
        "hobbies": hobbies,
      };
}
