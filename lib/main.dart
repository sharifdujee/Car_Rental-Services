import 'dart:developer';

import 'package:carrentalservices/Booking/carreservation.dart';
import 'package:carrentalservices/email_auth/loginscreen.dart';
import 'package:carrentalservices/email_auth/signupscreen.dart';
import 'package:carrentalservices/firebase_options.dart';
import 'package:carrentalservices/home.dart';
import 'package:carrentalservices/myhomepage.dart';
import 'package:carrentalservices/phone_auth/signinwithphone.dart';
import 'package:carrentalservices/restapi/profile.dart';
import 'package:carrentalservices/services/notificationservices.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform
  );
  //show Single Data.
  // DocumentSnapshot snapshot = await FirebaseFirestore.instance.collection("user").doc("1QT1rS3sFRzhmkpnycbX").get();
  // log(snapshot.data().toString());

  // insert Data
  //  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  // Map<String, dynamic> newUserData = {
  //   "name": "Rohan",
  //   "email": "Rohan2008@gmail.com",
  // };
  //insert Data one way
  // await _firestore.collection("users").add(newUserData);
  // log("New User Add");
  //insert data second way
  // await _firestore.collection("users").doc("your _id_Here").set(newUserData);
  // log("New User Add");

  //update Data
  // await _firestore.collection("users").doc("your _id_Here").update({
  //   "email": "Rohan@2008oxford@gmail.com"
  //
  // });
  // log("User Updated");
  //Delete
  // await _firestore.collection("users").doc("your _id_Here").delete();
  // log("User Deleted");

  runApp(MyApp());

  }
  //show



  // await NotificationService.initialize();





  // Map<String, dynamic> newUserData = {
  //   "name": "SlantCode",
  //   "email": "slantcode@gmail.com"
  // };
  // await _firestore.collection("users").doc("your-id-here").update({
  //   "email": "slantcode2@gmail.com"
  // });
  // log("User updated!");

  // await _firestore.collection("users").doc("Z3kfNrbsVBlgqPnP94S2").delete();
  // log("User deleted!");




class MyApp extends StatelessWidget {
  const MyApp({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      //home: SignUpScreen(),
      //home: LoginScreen(),
      //home: (FirebaseAuth.instance.currentUser != null) ? HomeScreen() : LoginScreen(),
        //home: (FirebaseAuth.instance.currentUser != null) ? HomeScreen() : SignInWithPhone(),
      // home: Profiles(),
       // home: MyHomePage(),
        home: BookingScrren()
    );
  }
}