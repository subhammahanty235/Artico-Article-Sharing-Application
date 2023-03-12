// ignore_for_file: prefer_const_constructors, unnecessary_new, use_key_in_widget_constructors, prefer_typing_uninitialized_variables, non_constant_identifier_names, use_build_context_synchronously

import 'package:basic1/MongoDBUserModel.dart';
import 'package:basic1/dataBaseHelpers/mongodb.dart';
import 'package:basic1/main.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileDetailsSubmit extends StatefulWidget {
  var userId;
  ProfileDetailsSubmit({super.key, this.userId});
  @override
  State<ProfileDetailsSubmit> createState() => _ProfileDetailsSubmitState();
}

class _ProfileDetailsSubmitState extends State<ProfileDetailsSubmit> {
  // var nameController = new TextEditingController();
  var nameController = new TextEditingController();
  var ageController = new TextEditingController();
  var genderValue = 'Male';
  var countryController = new TextEditingController();
  var hobbiesController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
        appBar: AppBar(
            title: const Text("Artico",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                  fontWeight: FontWeight.w500,
                ))),
        body: Container(
            width: MediaQuery.of(context).size.width * 1.0,
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(color: Colors.green[100]),
            child: Column(
              children: [
                Container(
                    width: MediaQuery.of(context).size.width - 40,
                    padding: EdgeInsets.all(20),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20)),
                    child: Text(
                      "Create Your Profile",
                      textAlign: TextAlign.center,
                    )),
                Container(
                    margin: EdgeInsets.only(top: 10),
                    padding: EdgeInsets.all(10),
                    // height: 500,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20)),
                    child: Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.all(10),
                          child: TextField(
                            controller: nameController,
                            decoration: InputDecoration(
                                labelText: 'Name',
                                border: OutlineInputBorder()),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(10),
                          child: TextField(
                            controller: ageController,
                            decoration: InputDecoration(
                                labelText: 'Age', border: OutlineInputBorder()),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(10),
                          child: DropdownButtonFormField<String>(
                            value: genderValue,
                            decoration: InputDecoration(
                                labelText: 'Gender',
                                border: OutlineInputBorder()),
                            items:
                                <String>['Male', 'Female'].map((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                            onChanged: (value) {
                              setState(() {
                                genderValue = value!;
                              });
                            },
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(10),
                          child: TextField(
                            controller: countryController,
                            decoration: InputDecoration(
                                labelText: 'Country',
                                border: OutlineInputBorder()),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(10),
                          child: TextField(
                            controller: hobbiesController,
                            decoration: InputDecoration(
                                labelText: 'Hobbies',
                                border: OutlineInputBorder()),
                          ),
                        ),
                        Divider(),
                        Container(
                          // margin: EdgeInsets.only(top: 25 , bi),
                          margin: EdgeInsets.symmetric(
                              vertical: 25, horizontal: 10),
                          width: MediaQuery.of(context).size.width - 40,
                          decoration: BoxDecoration(
                              // color: Colors.green[50],
                              borderRadius: BorderRadius.circular(7),
                              border:
                                  Border.all(color: Colors.blue, width: 1.5)),
                          child: TextButton(
                            onPressed: () {
                              _submitData(
                                  nameController.text,
                                  genderValue,
                                  ageController.text,
                                  hobbiesController.text,
                                  countryController.text);
                            },
                            child: Text("Save",
                                style: TextStyle(fontWeight: FontWeight.w600)),
                          ),
                        )
                      ],
                    ))
              ],
            )));
  }

  Future<void> _submitData(String name, String gender, var age, String hobbies,
      String country) async {
    if (name.length >= 5 &&
        age >= 0 &&
        age <= 100 &&
        country.length >= 3 &&
        hobbies.length >= 3) {
      var userDetails = Profiledetails(
          name: name,
          gender: gender,
          age: int.parse(age),
          hobbies: hobbies,
          country: country);

      var res = await MongoDatabase.saveprofile(userDetails, widget.userId);
      if (res == true) {
        // storing the name to use while posting a article , it will help to improve the performance and also keep the code easy to understand as this project is not a production application
        final prefs = await SharedPreferences.getInstance();
        prefs.setString("NAME_USER", name);

        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text("Profile Created :)"),
          backgroundColor: Colors.green[100],
        ));
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => MyHomePage(title: "HomePage")));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text("Try again later:)"),
          backgroundColor: Colors.red[200],
        ));
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Please Fill data"),
        backgroundColor: Colors.red[200],
      ));
    }
  }
}
