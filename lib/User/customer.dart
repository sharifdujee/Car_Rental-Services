import 'package:flutter/material.dart';

class CustomerScreen extends StatefulWidget {
  const CustomerScreen({super.key});

  @override
  State<CustomerScreen> createState() => _CustomerScreenState();
}

class _CustomerScreenState extends State<CustomerScreen> {

  TextEditingController _customerid = TextEditingController();
  TextEditingController _customername = TextEditingController();
  TextEditingController _passport = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(

    );
  }
}
//import 'dart:async';
// import 'dart:developer';
// import 'dart:io';
// import 'package:carrentalservices/email_auth/signupscreen.dart';
// import 'package:carrentalservices/phone_auth/signinwithphone.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:firebase_storage/firebase_storage.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:uuid/uuid.dart';
//
// class HomeScreen extends StatefulWidget {
//   const HomeScreen({Key? key}) : super(key: key);
//
//   @override
//   State<HomeScreen> createState() => _HomeScreenState();
// }
//
// class _HomeScreenState extends State<HomeScreen> {
//   TextEditingController _username = TextEditingController();
//   TextEditingController nameController = TextEditingController();
//   TextEditingController emailController = TextEditingController();
//   TextEditingController ageController = TextEditingController();
//   TextEditingController _dob = TextEditingController();
// // picture
//   File? profilepic;
//
//   void logOut() async {
//     await FirebaseAuth.instance.signOut();
//     Navigator.popUntil(context, (route) => route.isFirst);
//     Navigator.pushReplacement(
//         context, CupertinoPageRoute(builder: (context) => SignInWithPhone()));
//   }
//
//   void saveUser() async {
//     String name = nameController.text.trim();
//     String username = _username.text.trim();
//     String email = emailController.text.trim();
//     String ageString = ageController.text.trim();
//     String dobString = _dob.text.trim();
//
//     int age = int.parse(ageString);
//
//
//     nameController.clear();
//     _username.clear();
//     emailController.clear();
//     ageController.clear();
//     _dob.clear();
//     _username.clear();
//
//     //if (name != "" && email != "" && profilepic!=null)
//     if (name != "" && email != "") {
//      // Picture
//       UploadTask uploadTask = FirebaseStorage.instance.ref().child("profilepictures").child(Uuid().v1()).putFile(profilepic!);
//
//       StreamSubscription taskSubscription = uploadTask.snapshotEvents.listen((snapshot) {
//         double percentage = snapshot.bytesTransferred/snapshot.totalBytes * 100;
//         log(percentage.toString());
//       });
//
//       TaskSnapshot taskSnapshot = await uploadTask;
//       String downloadUrl = await taskSnapshot.ref.getDownloadURL();
//
//       taskSubscription.cancel();
//       // end picture
//   // UploadTask uploadTask =  FirebaseStorage.instance.ref().child("profilepictures").child(Uuid().v1()).putFile(profilepic!);
//   //         TaskSnapshot taskSnapshot = await uploadTask;
//   //         String downloadUrl = await taskSnapshot.ref.getDownloadURL();
//       Map<String, dynamic> userData = {
//         "name": name,
//         "username": username,
//         "email": email,
//         "age": age,
//         "dob": dobString,
//          "profilepic": downloadUrl,
//         "sampleArray": [name, username, email, age, dobString]
//       };
//       FirebaseFirestore.instance.collection("users").add(userData);
//       log("User created!");
//     } else {
//       log("Please fill all the fields!");
//     }
//
//      setState(() {
//        profilepic = null;
//      });
//   }
//
//   //update Data
//   FirebaseFirestore _firestore = FirebaseFirestore.instance;
//   void updateUser() async {
//     await _firestore.collection("users").doc("85y0YSfZzqsE3pR9452T").update({
//       "name": "Hasan Mahmud",
//       "email": "hasanlaks@gmail.com",
//       "age" : 25,
//       "dob" : "12-03-1994",
//     });
//     log("User Updated");
//   }
//
//   void deleteUser() async {
//     await _firestore.collection("users").doc("85y0YSfZzqsE3pR9452T").delete();
//     log("User Deleted");
//   }
//
//   void getInitialMessage() async {
//     RemoteMessage? message =
//         await FirebaseMessaging.instance.getInitialMessage();
//
//     if (message != null) {
//       if (message.data["page"] == "email") {
//         Navigator.push(
//             context, CupertinoPageRoute(builder: (context) => SignUpScreen()));
//       } else if (message.data["page"] == "phone") {
//         Navigator.push(context,
//             CupertinoPageRoute(builder: (context) => SignInWithPhone()));
//       } else {
//         ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//           content: Text("Invalid Page!"),
//           duration: Duration(seconds: 5),
//           backgroundColor: Colors.red,
//         ));
//       }
//     }
//   }
//
//   @override
//   void initState() {
//     super.initState();
//
//     getInitialMessage();
//
//     FirebaseMessaging.onMessage.listen((message) {
//       ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//         content: Text(message.data["myname"].toString()),
//         duration: Duration(seconds: 10),
//         backgroundColor: Colors.green,
//       ));
//     });
//
//     FirebaseMessaging.onMessageOpenedApp.listen((message) {
//       ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//         content: Text("App was opened by a notification"),
//         duration: Duration(seconds: 10),
//         backgroundColor: Colors.green,
//       ));
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Home"),
//         actions: [
//           IconButton(
//             onPressed: () {
//               logOut();
//             },
//             icon: Icon(Icons.exit_to_app),
//           ),
//         ],
//       ),
//       body: SafeArea(
//         child: Padding(
//           padding: const EdgeInsets.all(15),
//           child: Column(
//             children: [
//
//               //profile Picture
//               CupertinoButton(
//                 onPressed: () async {
//                   XFile? selectedImage = await ImagePicker()
//                       .pickImage(source: ImageSource.gallery);
//
//                   if (selectedImage != null) {
//                     File convertedFile = File(selectedImage.path);
//                     setState(() {
//                       profilepic = convertedFile;
//                     });
//                     log("Image selected!");
//                   } else {
//                     log("No image selected!");
//                   }
//                 },
//                 padding: EdgeInsets.zero,
//                 child: CircleAvatar(
//                   radius: 50,
//                   backgroundImage:
//                       (profilepic != null) ? FileImage(profilepic!) : null,
//                   backgroundColor: Colors.grey,
//                 ),
//               ),
//
//               TextField(
//                 controller: nameController,
//                 decoration: InputDecoration(hintText: "Name"),
//               ),
//
//               SizedBox(
//                 height: 3,
//               ),
//               TextField(
//                 controller: _username,
//                 decoration: InputDecoration(hintText: "Username"),
//               ),
//
//               SizedBox(
//                 height: 3,
//               ),
//
//               TextField(
//                 controller: emailController,
//                 decoration: InputDecoration(hintText: "Email Address"),
//               ),
//
//               SizedBox(
//                 height: 3,
//               ),
//
//               TextField(
//                 controller: ageController,
//                 decoration: InputDecoration(hintText: "Age"),
//               ),
//
//               SizedBox(
//                 height: 3,
//               ),
//
//               TextField(
//                 controller: _dob,
//                 decoration: InputDecoration(hintText: "DOB"),
//               ),
//
//               SizedBox(
//                 height: 3,
//               ),
//
//               CupertinoButton(
//                 onPressed: () {
//                   saveUser();
//                 },
//                 child: Text("Save"),
//               ),
//
//               SizedBox(
//                 height: 5,
//               ),
//               CupertinoButton(
//                 onPressed: () {
//                   updateUser();
//                 },
//                 child: Text("Update"),
//               ),
//
//               SizedBox(
//                 height: 5,
//               ),
//               // CupertinoButton(
//               //   onPressed: () {
//               //    deleteUser();
//               //   },
//               //   child: Text("Delete"),
//               // ),
//               //
//               // SizedBox(height: 5,),
//
//               StreamBuilder<QuerySnapshot>(
//                 // both
//                 stream:  FirebaseFirestore.instance.collection("users").where("age", isGreaterThanOrEqualTo: 25).orderBy("age").snapshots(),
//                 // Filtering
//                 // given condition to show data
//                 // stream: FirebaseFirestore.instance.collection("users").where("age", isGreaterThanOrEqualTo: 32).snapshots(),
//                 // null
//                 // stream: FirebaseFirestore.instance.collection("users").where("age", isNull: false).snapshots(),
//                 // show Multiple person value using condition
//                 // stream: FirebaseFirestore.instance.collection("users").where("age", whereIn: [32,35]).snapshots(),
//                 //Arrays single condition   * int arrayContains: 35 * String arrayContains: "Tamim"
//                 // stream: FirebaseFirestore.instance.collection("users").where("samplearray", arrayContains: "Tamim").snapshots(),
//                 // Array Multiple Values or Condition
//                 //stream: FirebaseFirestore.instance.collection("users").where("samplearray", arrayContainsAny: ["Tamim", 35]).snapshots(),
//                 // Ordering
//                 // stream: FirebaseFirestore.instance
//                 //     .collection("users")
//                 // // decending Order
//                 //     // .orderBy("age", descending: true)
//                 // // default ascending
//                 // .orderBy("age")
//                 //     .snapshots(),
//                 builder: (context, snapshot) {
//                   if (snapshot.connectionState == ConnectionState.active) {
//                     if (snapshot.hasData && snapshot.data != null) {
//                       return Expanded(
//                         child: ListView.builder(
//                           itemCount: snapshot.data!.docs.length,
//                           itemBuilder: (context, index) {
//                             Map<String, dynamic> userMap =
//                                 snapshot.data!.docs[index].data()
//                                     as Map<String, dynamic>;
//
//                             return ListTile(
//                               // show image
//                                leading: CircleAvatar(
//                                 backgroundImage: NetworkImage(userMap["profilepic"]),
//                                ),
//                               title: Text(
//                                   userMap["name"] + " (${userMap["age"]})"),
//                               subtitle: Text(userMap["email"] + "(${userMap["username"]}"),
//                               //                           trailing: Row(
//                               //                             children: [
//                               //                               IconButton(onPressed: (){
//                               //                                 updateUser();
//                               //                               }, icon: Icon(Icons.update),
//                               // ),
//                               //                             IconButton(onPressed: (){
//                               //                                 deleteUser();
//                               //                               }, icon: Icon(Icons.delete),),
//                               //                             ],
//                               //                           ),
//
//                               trailing: IconButton(
//                                 onPressed: () {
//                                   deleteUser();
//                                 },
//                                 icon: Icon(Icons.delete),
//                               ),
//                             );
//                           },
//                         ),
//                       );
//                     } else {
//                       return Text("No data!");
//                     }
//                   } else {
//                     return Center(
//                       child: CircularProgressIndicator(),
//                     );
//                   }
//                 },
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
