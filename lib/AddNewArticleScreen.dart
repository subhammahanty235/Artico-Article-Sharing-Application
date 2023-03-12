// import 'package:flutter/cupertino.dart';

// ignore_for_file: prefer_const_constructors, use_build_context_synchronously, unnecessary_new, use_key_in_widget_constructors

// import 'dart:html';

import 'package:basic1/MongoDBArticleModel.dart';
import 'package:basic1/dataBaseHelpers/mongodb.dart';
import 'package:basic1/main.dart';
import 'package:flutter/material.dart';
import 'package:mongo_dart/mongo_dart.dart' as mongo;
import 'package:shared_preferences/shared_preferences.dart';

class AddnewArticleScreen extends StatefulWidget {
  @override
  State<AddnewArticleScreen> createState() => _AddNewArticleState();
}

class _AddNewArticleState extends State<AddnewArticleScreen> {
  var subjectController = new TextEditingController();
  var articleController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
        appBar: AppBar(
            automaticallyImplyLeading: false,
            backgroundColor: Colors.green[50],
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Artico',
                  style: TextStyle(
                      color: Colors.black87,
                      fontSize: 22,
                      fontWeight: FontWeight.w500),
                ),
                TextButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  MyHomePage(title: 'Flutter Demo Home Page')));
                    },
                    child: const Icon(Icons.other_houses_rounded))
              ],
            )),
        body: Column(
          children: [
            Container(
              margin: EdgeInsets.all(20),
              child: Text(
                "Add New Article",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
              ),
            ),
            Column(
              children: [
                Container(
                  margin: EdgeInsets.all(20),
                  decoration: BoxDecoration(),
                  child: TextField(
                    controller: subjectController,
                    
                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'Enter the Subject',
                        helperText: "max length is 20 characters"),
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  decoration: BoxDecoration(),
                  child: TextField(
                    controller: articleController,
                    keyboardType: TextInputType.multiline,
                    maxLines: 4,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Write your Article',
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 10),
                  width: MediaQuery.of(context).size.width - 40,
                  decoration: BoxDecoration(
                      // color: Colors.green[50],
                      borderRadius: BorderRadius.circular(7),
                      border: Border.all(color: Colors.blue, width: 1.5)),
                  child: TextButton(
                    onPressed: () {
                      _insertData(subjectController.text,
                          articleController.text);
                    },
                    child: Text("Save",
                        style: TextStyle(fontWeight: FontWeight.w600)),
                  ),
                )
              ],
            ),
            Container()
          ],
        ));
  }

  Future<void> _insertData(
      String subject, String article) async {
      final prefs = await SharedPreferences.getInstance();
    var id = mongo.ObjectId();
    var userId = prefs.getString("ID_USER");
    var name = prefs.getString("NAME_USER");
    
   
    
    var userdetails = Userdetails(name: name.toString(), userid: userId.toString());

    
    final data = MongodbArticleModel(
        id: id, subject: subject, article: article,uploaded: DateTime.now().toString(),userdetails: userdetails);
    var res = await MongoDatabase.insert(data);
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text("Article Inserted :)")));
    _clearAll();
  }

  void _clearAll() {
    subjectController.text = "";
    articleController.text = "";
  }
}
