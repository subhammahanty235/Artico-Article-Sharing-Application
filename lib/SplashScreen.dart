// ignore_for_file: prefer_const_constructors

import 'dart:async';

import 'package:basic1/LoginScreen.dart';
import 'package:basic1/main.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    checklogged();
  }

  void checklogged() async {
    final prefs = await SharedPreferences.getInstance();
    var loggedStatus = prefs.getBool("USER_LOGGEDIN");
    Timer(const Duration(seconds: 4), () {
      if (loggedStatus == null || loggedStatus == false) {
        print(loggedStatus);
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => LoginScreen()));
      } else {
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => MyHomePage(title: "Hello")));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(color: Colors.green[100]),
        child: Center(
          child: CircleAvatar(
            backgroundColor: Colors.blue,
            maxRadius: 50,
            child: Text("Artico",
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 25,
                    fontWeight: FontWeight.bold)),
          ),
        ),
      ),
    );
  }
}
