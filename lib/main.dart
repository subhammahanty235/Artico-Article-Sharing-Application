// ignore_for_file: prefer_const_constructors, use_build_context_synchronously

import 'package:basic1/AddNewArticleScreen.dart';
import 'package:basic1/MongoDBArticleModel.dart';
import 'package:basic1/SplashScreen.dart';
import 'package:basic1/UserScreen.dart';
import 'package:basic1/dataBaseHelpers/mongodb.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await MongoDatabase.connect();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Article Application',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        // home: const MyHomePage(title: 'Flutter Demo Home Page'),
        home: SplashScreen());
    // home:SignUpScreen());
    // home:ProfileDetailsSubmit());
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  @override
  Widget build(BuildContext context) {
    // List<Map<String, dynamic>> data = [];
    // data.add({
    //   'name': 'Subham',
    //   'article':
    //       "In my previous article, I had discussed the difference between Stateful and Stateless Widgets. You have to apply that concept to understand the working of this Counter App."
    // });
    // data.add({
    //   'name': 'ProCoder',
    //   'article':
    //       "In my previous article, I had discussed the difference between Stateful and Stateless Widgets. You have to apply that concept to understand the working of this Counter App."
    // });
    // data.add({
    //   'name': 'Noob',
    //   'article':
    //       "In my previous article, concept to understand the working of this Counter App."
    // });
    // data.add({
    //   'name': 'Quikkee',
    //   'article':
    //       "In my previouo apply that concept to understand the working of this Counter App."
    // });
    // data.add({
    //   'name': 'Alice',
    //   'article': "In my previous article, I had discussed the difApp."
    // });
    // data.add({
    //   'name': 'Alxcoder',
    //   'article':
    //       "In my previous article, I had discussed the difference between Stateful and StatelessIn my previous article, I had discussed the difference between Stateful and Stateless Widgets. You have to apply that concept to understand the working of this Counter App. Widgets. You have to apply that concept to understand the working of this Counter App."
    // });
    // data.add({
    //   'name': 'DartExpert',
    //   'article':
    //       "In my previous article, I had discuIn my previous article, I had discussed the difference between Stateful and Stateless Widgets. You have to apply that concept to understand the working of this Counter App.stand the working of this Counter App."
    // });

    return Scaffold(
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
                  onPressed: () async {
                    final prefs = await SharedPreferences.getInstance();
                    var userId = prefs.getString("ID_USER");
                    // final id = ObjectId.parse(userId);

                    // print("--------------------------------------------------------");
                    // print(userId);
                    // print("---------------------------------------------------------");
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => UserScreen(
                                  userId: userId,
                                )));
                  },
                  child: const Icon(Icons.menu_rounded)),
            ],
          )),
      body: (Column(
        children: [
          Container(
              padding: const EdgeInsets.all(9.0),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Container(
                      width: 150,
                      // margin: const EdgeInsets.only(top: 6),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 0, vertical: 0),
                      decoration: BoxDecoration(
                          color: Colors.blue[100],
                          borderRadius: BorderRadius.circular(10)),
                      child: TextButton(
                        onPressed: () {},
                        child: Text(
                          'Global',
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 12.0, color: Colors.black),
                        ),
                      ),
                    ),
                    Container(
                      width: 150,
                      // margin: const EdgeInsets.only(top: 6),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 0, vertical: 0),
                      decoration: BoxDecoration(
                          // color: Colors.blue[100],
                          border: Border.all(color: Colors.blue),
                          borderRadius: BorderRadius.circular(10)),
                      child: TextButton(
                        style: TextButton.styleFrom(
                          padding: EdgeInsets.zero,
                        ),
                        onPressed: () {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text(
                              "Waiting for a Coffee to start Coding again ,But Coffee mug is taking rest :)",
                              textAlign: TextAlign.center,
                            ),
                            
                            backgroundColor: Colors.lightBlueAccent,
                          ));
                        },
                        child: Text(
                          'My Posts',
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 12.0, color: Colors.black),
                        ),
                      ),
                    ),
                  ])),
          Container(
              padding: const EdgeInsets.all(10),
              margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 20),
              height: MediaQuery.of(context).size.height * 0.75,
              decoration: BoxDecoration(
                  color: Colors.green[100],
                  borderRadius: BorderRadius.circular(12)),
              child: SafeArea(
                child: FutureBuilder(
                    future: MongoDatabase.getdata(),
                    builder: (context, AsyncSnapshot snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      } else {
                        if (snapshot.hasData) {
                          return ListView.builder(
                              itemCount: snapshot.data.length,
                              itemBuilder: (context, index) {
                                return articleCard(MongodbArticleModel.fromJson(
                                    snapshot.data[index]));
                              });
                        } else {
                          return Center(
                            child: Text(
                              "No Data FOund",
                              style: TextStyle(
                                  color: Colors.black87,
                                  fontWeight: FontWeight.w800),
                            ),
                          );
                        }
                      }
                    }),
              ))
        ],
      )),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => AddnewArticleScreen()));
        },
        tooltip: "Add Note",
        child: const Icon(Icons.add_card),
      ),
    );
  }

// Custom Widget to display the articles
  Widget articleCard(MongodbArticleModel data) {
    return Container(
      // height: 100,
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 0),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(10)),

      child: Column(
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(6),
                margin: const EdgeInsets.fromLTRB(9, 5, 3, 5),
                decoration: BoxDecoration(
                    color: Colors.blueAccent,
                    borderRadius: BorderRadius.circular(30)),
                child: const Icon(
                  Icons.person,
                  color: Colors.white,
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(data.userdetails.name,
                      style: const TextStyle(
                          fontWeight: FontWeight.w600, fontSize: 15)),
                  Text(data.uploaded,
                      style: const TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 12,
                          color: Colors.black26)),
                ],
              )
            ],
          ),
          const Divider(),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  data.subject,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 5, horizontal: 0),
                  child: Text(data.article),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
