// ignore_for_file: prefer_const_constructors, unnecessary_new, use_build_context_synchronously

import 'package:basic1/LoginScreen.dart';
import 'package:basic1/MongoDBUserModel.dart';
import 'package:basic1/ProfileDetailsSubmit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mongo_dart/mongo_dart.dart' as mongo;
import 'package:basic1/dataBaseHelpers/mongodb.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignUpScreen extends StatefulWidget {
  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  var emailController = new TextEditingController();
  var passwordController = new TextEditingController();
  var conformPasswordController = new TextEditingController();

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
                            margin: EdgeInsets.symmetric(
                                vertical: 5, horizontal: 20),
                            decoration: BoxDecoration(),
                            child: TextField(
                              controller: conformPasswordController,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                hintText: 'Confirm Password',
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
                                _createaccount(
                                    emailController.text,
                                    passwordController.text,
                                    conformPasswordController.text);
                              },
                              child: Text("Create your account",
                                  style:
                                      TextStyle(fontWeight: FontWeight.w600)),
                            ),
                          )
                        ]),
                        TextButton(onPressed: (){
                          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>LoginScreen()));
                        } , child: Text("Log In",
                        style: TextStyle(
                            color: Colors.blue,
                            fontSize: 20,
                            fontWeight: FontWeight.bold)))
                    
                  ],
                ))));
  }

  Future<void> _createaccount(
      String email, String password, String confirmPassword) async {
    var id = mongo.ObjectId();

    if (email.length >= 4 && password.length >= 5) {
      if (password == confirmPassword) {
        final data = MongodbUserModel(id: id, email: email, password: password);
        var res = await MongoDatabase.createuser(data);
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(res),
          backgroundColor: Colors.green[200],
        ));
        if (res == "Account Created") {
          // print(id);
          // storing the id  to use in other screens and a boolean value to check if user has loggedin or not
          // print("-----------------------------------------------------------------");
          // print(id.toHexString());

          final prefs = await SharedPreferences.getInstance();
          prefs.setString("ID_USER", id.toHexString());
          prefs.setBool("USER_LOGGEDIN", true);

          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (context) => ProfileDetailsSubmit(userId: id)));
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text("Password and Confirm Password not matching"),
          backgroundColor: Colors.red[200],
        ));
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Email and Password shoud be greater than 5 characters"),
        backgroundColor: Colors.red[200],
      ));
    }

    _clearAll();
  }

  void _clearAll() {
    emailController.text = "";
    passwordController.text = "";
    conformPasswordController.text = "";
  }
}
