// ignore_for_file: prefer_typing_uninitialized_variables

import 'dart:developer';

import 'package:basic1/MongoDBArticleModel.dart';
import 'package:basic1/MongoDBUserModel.dart';
import 'package:basic1/dataBaseHelpers/dbconstrants.dart';
import 'package:mongo_dart/mongo_dart.dart';

class MongoDatabase {
  static var db, usersCollection, articlesCollection;
  static connect() async {
    db = await Db.create(MONGO_URI);
    await db.open();
    inspect(db);
    usersCollection = db.collection(USER_COLLECTION);
    articlesCollection = db.collection(ARTICLE_COLLECTION);
  }

  static Future<List<Map<String, dynamic>>> getdata() async {
    final data = await articlesCollection.find().toList();
    return data;
  }

  static Future<Map<String, dynamic>> getUserData(var userId) async {
    // print("--------------------------------mongo funv---------------------");
    // print(userId);

    final data =
        await usersCollection.findOne({"_id": ObjectId.fromHexString(userId)});
    if (data == null) {
      // print("-----------------------------------Nulllll-----------------------------");
      return {"message": "user not exists"};
    } else {
      // print("_____________________mongoData__________________________________");
      // print(data);

      return data;
    }
  }

  static Future<String> insert(MongodbArticleModel data) async {
    try {
      var res = await articlesCollection.insertOne(data.toJson());
      if (res.isSuccess) {
        return "data inserted";
      } else {
        return "Unable to insert data";
      }
    } catch (e) {
      // print(e.toString());
      return e.toString();
    }
  }

  static Future<String> createuser(MongodbUserModel data) async {
    try {
      var res = await usersCollection.findOne({"email": data.email});

      if (res == null) {
        var status = await usersCollection.insertOne(data.toJson());
        if (status.isSuccess) {
          return "Account Created";
        } else {
          return "Unable to create account";
        }
      } else {
        // print(res);
        return "User already exists";
      }
    } catch (e) {
      return e.toString();
    }
  }

  static Future<Map<String, dynamic>> loginuser(
      String email, String password) async {
    try {
      var user = await usersCollection.findOne({"email": email});
      // print("-------------------vvvvv----------------------vvvvvvvvvvvv----------------");
      // print(user);
      if (user != null) {
        if (user["password"] == password) {
          return user;
        } else {
          return {"message": "Wrong Credentials"};
        }
      } else {
        return {"message": "Wrong Credentials"};
      }
    } catch (e) {
      return {"message": e.toString()};
    }
  }

  static Future<bool> saveprofile(Profiledetails userdata, var userid) async {
    try {
      await usersCollection.updateOne(where.eq('_id', userid),
          modify.set('profiledetails', userdata.toJson()));
      return true;
    } catch (e) {
      // print(e.toString());
      return false;
    }
  }
}
