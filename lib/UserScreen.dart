// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, must_be_immutable, use_build_context_synchronously

import 'package:basic1/LoginScreen.dart';
import 'package:basic1/SignUpScreen.dart';
import 'package:basic1/dataBaseHelpers/mongodb.dart';
import 'package:basic1/main.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserScreen extends StatefulWidget {
  var userId; //this is to be sent to the mongodb to get the user's details
  UserScreen({super.key, this.userId});
  @override

  State<UserScreen> createState() => _UserScreenState();
}  

class _UserScreenState extends State<UserScreen>{
  

  @override
  Widget build(BuildContext context) {
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
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  MyHomePage(title: 'Home Page')));
                    },
                    child: const Icon(Icons.other_houses_rounded))
              ],
            )),
        body: SafeArea(
            child: FutureBuilder(
          future: MongoDatabase.getUserData(widget.userId),
          builder: (context, AsyncSnapshot snapshot) {
            // print("---------------------------calling------------------------");
            // print(snapshot.data['profiledetails']['name']);
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else {
              if (snapshot.hasData) {
                // print("--------------------------------has data called-----------------");

                return Column(
                  children: [
                    Container(
                      margin: EdgeInsets.all(20),
                      child: Text("Profile",
                          style: TextStyle(
                              fontSize: 22, fontWeight: FontWeight.w600)),
                    ),
                    Container(
                        height: 100,
                        margin:
                            EdgeInsets.symmetric(vertical: 0, horizontal: 20),
                        padding: EdgeInsets.all(20),
                        decoration: BoxDecoration(
                            color: Colors.green[50],
                            borderRadius: BorderRadius.circular(10)),
                        child: Row(
                          children: [
                            CircleAvatar(child: Icon(Icons.person)),
                            Padding(
                                padding: EdgeInsets.symmetric(
                                    vertical: 10, horizontal: 10),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                        snapshot.data['profiledetails']['name'],
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w400)),
                                    Text(snapshot.data['email'],
                                        style: TextStyle(color: Colors.black38))
                                  ],
                                ))
                            //  Text("Subham" , style:TextStyle())
                          ],
                        )),
                    Container(
                        height: 400,
                        margin: EdgeInsets.all(20),
                        decoration: BoxDecoration(
                            color: Colors.green[50],
                            borderRadius: BorderRadius.circular(10)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            // MainAxisAlignment:
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: EdgeInsets.all(10),
                                  child: Row(
                                    children: [
                                      Icon(Icons.sports_baseball_rounded,
                                          color: Colors.blue, size: 20),
                                      Text(
                                          " Name : ${snapshot.data['profiledetails']['name']}",
                                          style: TextStyle(
                                            fontSize: 18,
                                          ))
                                    ],
                                  ),
                                ),
                                Divider(
                                  height: 5,
                                ),
                                Padding(
                                  padding: EdgeInsets.all(10),
                                  child: Row(
                                    children: [
                                      Icon(Icons.sports_baseball_rounded,
                                          color: Colors.blue, size: 20),
                                      Text(
                                          " Age : ${snapshot.data['profiledetails']['age']}",
                                          style: TextStyle(
                                            fontSize: 18,
                                          ))
                                    ],
                                  ),
                                ),
                                Divider(
                                  height: 5,
                                ),
                                Padding(
                                  padding: EdgeInsets.all(10),
                                  child: Row(
                                    children: [
                                      Icon(Icons.sports_baseball_rounded,
                                          color: Colors.blue, size: 20),
                                      Text(
                                          " Gender : ${snapshot.data['profiledetails']['gender']}",
                                          style: TextStyle(
                                            fontSize: 18,
                                          ))
                                    ],
                                  ),
                                ),
                                Divider(
                                  height: 5,
                                ),
                                Padding(
                                  padding: EdgeInsets.all(10),
                                  child: Row(
                                    children: [
                                      Icon(Icons.sports_baseball_rounded,
                                          color: Colors.blue, size: 20),
                                      Text(
                                          " Country : ${snapshot.data['profiledetails']['country']}",
                                          style: TextStyle(
                                            fontSize: 18,
                                          ))
                                    ],
                                  ),
                                ),
                                Divider(
                                  height: 5,
                                ),
                                Padding(
                                  padding: EdgeInsets.all(10),
                                  child: Row(
                                    children: [
                                      Icon(Icons.sports_baseball_rounded,
                                          color: Colors.blue, size: 20),
                                      Text(
                                          " Hobbies : ${snapshot.data['profiledetails']['hobbies']}",
                                          style: TextStyle(
                                            fontSize: 18,
                                          ))
                                    ],
                                  ),
                                ),
                                //  Divider(height: 5,),
                                // Padding(padding:EdgeInsets.all(10),  child: Row(children:[Icon(Icons.sports_baseball_rounded , color: Colors.blue , size:20) , Text("Name : Subham Mahanty" ,style:TextStyle(fontSize: 18 , ) )],) ,),
                              ],
                            ),
                          ],
                        )),
                    Container(
                     width: MediaQuery.of(context).size.width - 40,
                     decoration: BoxDecoration(
                      border: Border.all(color: Colors.red.shade500),
                      borderRadius: BorderRadius.circular(10)
                      
                     ),
                        child: TextButton(
                            style:TextButton.styleFrom(
                                foregroundColor: Colors.red
                            ),
                            onPressed: () {_logout();}, child: Text("Log Out" , style: TextStyle(color: Colors.red[600]),)))
                  ],
                );
              } else {
                return Center(
                  child: Text(
                    "No Data FOund",
                    style: TextStyle(
                        color: Colors.black87, fontWeight: FontWeight.w800),
                  ),
                );
              }
            }
          },
        )));
  }

  void _logout ()async{
    final pref = await SharedPreferences.getInstance();

    pref.remove("ID_USER");
    pref.remove("NAME_USER");
    pref.setBool("USER_LOGGEDIN", false);
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Logged Out"), backgroundColor: Colors.red[300],));
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginScreen()));
    


  }
}
