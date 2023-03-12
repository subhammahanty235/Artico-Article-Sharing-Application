// ignore_for_file: prefer_const_constructors, use_build_context_synchronously

import 'package:basic1/ProfileDetailsSubmit.dart';
import 'package:basic1/SignUpScreen.dart';
import 'package:basic1/dataBaseHelpers/mongodb.dart';
import 'package:basic1/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  var emailController = new TextEditingController();
  var passwordController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: const Text(
            'Artico',
            style: TextStyle(
                color: Colors.white, fontSize: 22, fontWeight: FontWeight.w500),
          ),
        ),
        body: Container(
            // height:,
            decoration: BoxDecoration(
              color: Colors.green[100],
            ),
            child: Container(
                // height: 400,
                margin: EdgeInsets.all(20),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.white),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Column(
                        // mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CircleAvatar(
                            backgroundColor: Colors.blue,
                            maxRadius: 50,
                            child: Text("Artico",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 25,
                                    fontWeight: FontWeight.bold)),
                          ),
                          Container(
                            margin: EdgeInsets.fromLTRB(20, 30, 20, 5),
                            // margin: EdgeInsets.symmetric(
                            //     vertical: 10, horizontal: 20),
                            decoration: BoxDecoration(),
                            child: TextField(
                              controller: emailController,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                hintText: 'Email id',
                                // helperText: "max length is 20 characters"),
                              ),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.symmetric(
                                vertical: 10, horizontal: 20),
                            decoration: BoxDecoration(),
                            child: TextField(
                              controller: passwordController,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                hintText: 'Password',
                                // helperText: "max length is 20 characters"),
                              ),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.all(20),
                            width: MediaQuery.of(context).size.width - 40,
                            decoration: BoxDecoration(
                                // color: Colors.green[50],
                                borderRadius: BorderRadius.circular(7),
                                border:
                                    Border.all(color: Colors.blue, width: 1.5)),
                            child: TextButton(
                              onPressed: () {
                                _logintoaccount(emailController.text,
                                    passwordController.text);
                              },
                              child: Text("Log in to your Account",
                                  style:
                                      TextStyle(fontWeight: FontWeight.w600)),
                            ),
                          )
                        ]),
                    TextButton(
                        onPressed: () {
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => SignUpScreen()));
                        },
                        child: Text("Create New Account",
                            style: TextStyle(
                                color: Colors.blue,
                                fontSize: 20,
                                fontWeight: FontWeight.bold)))
                  ],
                ))));
  }

  Future<void> _logintoaccount(String email, String password) async {
    if (email.length >= 4 && password.length >= 5) {
      var res = await MongoDatabase.loginuser(email, password);
      // this code needs improvments  , I am taking care of it :)
      if (res["message"] == null) {
        if (res["email"] != null && res["_id"] != null) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(
              "Logged In",
              textAlign: TextAlign.center,
            ),
            backgroundColor: Color.fromARGB(255, 74, 209, 79),
          ));

          final prefs = await SharedPreferences.getInstance();
          prefs.setString("ID_USER",  res["_id"].toHexString());
          prefs.setBool("USER_LOGGEDIN", true);

          // checking if user has created their profile or not , if not then they will be redirected to the CreateProfileScreen , :>
          if(res["profiledetails"] == null){
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (context) => ProfileDetailsSubmit(userId: res["_id"])));
          }
          else{
            prefs.setString("NAME_USER", res["profiledetails"]["name"]);
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (context) => MyHomePage(title: "Artico")));
          }

          
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(res["message"]),
          backgroundColor: Colors.red[200],
        ));
      }
    }
  }
}
