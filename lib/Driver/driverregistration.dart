import 'dart:async';
import 'package:carrentalservices/phone_auth/signinwithphone.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:convert';

import 'package:uuid/uuid.dart';

class DriverRegistration extends StatefulWidget {
  const DriverRegistration({super.key});

  @override
  State<DriverRegistration> createState() => _DriverRegistrationState();
}

class _DriverRegistrationState extends State<DriverRegistration> {
  TextEditingController _name = TextEditingController();
  TextEditingController _userName = TextEditingController();
  TextEditingController _licenseNo = TextEditingController();
  TextEditingController _vechileNo = TextEditingController();
  TextEditingController _vechileType = TextEditingController();
  TextEditingController _age = TextEditingController();

  void logout() async {
    await FirebaseAuth.instance.signOut();
    Navigator.popUntil(context, (route) => route.isFirst);
    Navigator.pushReplacement(
        context, CupertinoPageRoute(builder: (context) => SignInWithPhone()));
  }

  void driverSave() async {
    String name = _name.text.trim();
    String username = _userName.text.trim();
    String licenno = _licenseNo.text.trim();
    String vechileno = _vechileNo.text.trim();
    String vechiletype = _vechileType.text.trim();
    String age = _age.text.trim();

    int ages = int.parse(age);
    if (name.isNotEmpty && username.isNotEmpty) {
      _name.clear();
      _userName.clear();
      _age.clear();
      _licenseNo.clear();
      _vechileNo.clear();
      _vechileType.clear();

      Map<String, dynamic> driverData = {
        "name": name,
        "username": username,
        "age" : ages,
        "LicenseNo": licenno,
        "vechileNo": vechileno,
        "VechileType": vechiletype,
        "sampleArray": [name, username, licenno, vechileno, vechiletype]
      };
      FirebaseFirestore.instance.collection("Driver").add(driverData);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("New Driver Added")),
      );
    }
  }

  FirebaseFirestore _firestore = FirebaseFirestore.instance;
//update
  void updateDriver() async {
    await _firestore.collection("Driver").doc("W5J518EhiGGLcPcOYtfj").update({
      "name": "Selim Miah",
      "username": "Selim",
      "age" : 26,
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Driver Successfully Updated")),
    );
  }

  void deleteDriver() async{
    await _firestore.collection("Driver").doc("W5J518EhiGGLcPcOYtfj").delete();
    SnackBar(content: Text("Driver Removed Successfully")
    );

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        title: Text("New Driver Registration"),
        actions: [
          IconButton(

            onPressed: () {
              logout();
            },
            icon: Icon(Icons.exit_to_app),
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            children: [
              TextField(
                controller: _name,
                decoration: InputDecoration(
                  icon: Icon(Icons.person_2_outlined),
                  hintText: "Name",
                ),
              ),
              SizedBox(height: 3),
              TextField(
                controller: _userName,
                decoration: InputDecoration(
                  icon: Icon(Icons.verified_user_outlined),
                  hintText: "UserName",
                ),
              ),
              SizedBox(height: 3),
              TextField(
                controller: _age,
                decoration: InputDecoration(
                  icon: Icon(Icons.date_range_sharp),
                  hintText: "Age",
                ),
              ),
              SizedBox(height: 3),
              TextField(
                controller: _licenseNo,
                decoration: InputDecoration(
                  icon: Icon(Icons.verified),
                  hintText: "LicenseNo",
                ),
              ),
              SizedBox(height: 3),
              TextField(
                controller: _vechileNo,
                decoration: InputDecoration(
                  icon: Icon(Icons.emoji_transportation),
                  hintText: "VechileNo",
                ),
              ),
              SizedBox(height: 3),
              TextField(
                controller: _vechileType,
                decoration: InputDecoration(
                  icon: Icon(Icons.bus_alert),
                  hintText: "VechileType",
                ),
              ),
              SizedBox(height: 3),
              CupertinoButton(
                child: Text("Registration"),
                onPressed: () {
                  driverSave();
                },
              ),
              SizedBox(height: 3),
              CupertinoButton(
                child: Text("Update"),
                onPressed: () {
                  updateDriver();
                },
              ),
              SizedBox(height: 3),
              CupertinoButton(
                child: Text("Delete"),
                onPressed: () {
                  deleteDriver();
                },
              ),
              SizedBox(height: 3),
              StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection("Driver")
                    .where("age", isGreaterThanOrEqualTo: 25).orderBy("age", descending: true )
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.active) {
                    if (snapshot.hasData && snapshot.data != null) {
                      return Expanded(
                        child: ListView.builder(
                          itemCount: snapshot.data!.docs.length,
                          itemBuilder: (context, index) {
                            Map<String, dynamic> driverMap =
                            snapshot.data!.docs[index].data()
                            as Map<String, dynamic>;
                            return Column(
                              children: [

                                ListTile(
                                  leading: Text(driverMap["name"] + "(${driverMap["age"]})"),
                                  title: Text(driverMap["username"]),
                                  subtitle: Text(driverMap["vechileNo"] +  " (${driverMap["VechileType"]})" ),
                                  trailing: Text(driverMap["LicenseNo"] + " (${driverMap["VechileType"]})"),
                                ),

                              ],
                            );
                          },
                        ),
                      );
                    } else {
                      return Text("No Data was Found");
                    }
                  } else {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
