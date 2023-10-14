import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

Future<profile> fetchAlbum() async {
  final response = await http
  // Room
  //     .get(Uri.parse('http://192.168.0.188:8080/profilesearch/1271964'));
      .get(Uri.parse('http://192.168.0.115:8080/profilesearch/1271964'));

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    return profile.fromJson(jsonDecode(response.body));
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load album');
  }
}

class profile {
  final int tid ;
  final String name;
  final String username;
  final String email;
  final String dob;
  final String degree;
  final double result;
  final double marks;
  final String klevel;
  final double scholarship;
  // final double comission;
  final String mexamid;
  final double mmarks;
  final String mstatus;
  final String fexamid;
  final double fmarks;
  final String fstatus;
  final String course;
  final String pstatus;
  // final int progree;
  final String pastatus;



  const profile({
    required this.name,
    required this.tid,
    required this.username,
    required this.email,
    required this.dob,
    required this.degree,
    required this.result,
    required this.marks,
    required this.klevel,
    required this.scholarship,
    //required this.comission,
    required this.mexamid,
    required this.mmarks,
    required this.mstatus,
    required this.fexamid,
    required this.fmarks,
    required this.fstatus,
    required this.course,
    required this.pstatus,
    // required this.progree,
    required this.pastatus,
  });

  factory profile.fromJson(Map<String, dynamic> json) {
    return profile(
      name: json['name'],
      tid: json['tid'],
      username: json['username'],
      email: json['email'],
      dob: json['dob'],
      degree: json['degree'],
      result: json['result'],
      marks: json['marks'],
      klevel: json['klevel'],
      scholarship: json['scholarship'],
      //comission: json['comission'],
      mexamid: json['mexamid'],
      mmarks: json['mmarks'],
      mstatus: json['mstatus'],
      fexamid: json['fexamid'],
      fmarks: json['fmarks'],
      fstatus: json['fstatus'],
      course: json['course'],
      pstatus: json['pstatus'],
      // progree: json['progress'],
      pastatus: json['pastatus'],

    );
  }
}

void main() => runApp(const Profiles());

class Profiles extends StatefulWidget {
  const Profiles({super.key});

  @override
  State<Profiles> createState() => _MyAppState();
}

class _MyAppState extends State<Profiles> {
  late Future<profile> futureAlbum;

  @override
  void initState() {
    super.initState();
    futureAlbum = fetchAlbum();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Trainee Profile',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(

        appBar: AppBar(

          title: const Text('Trainee Profile'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Center(


            child: FutureBuilder<profile>(

              future: futureAlbum,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return  Column(
                    children: [
                      Text(snapshot.data!.tid.toString()),
                      Text(snapshot.data!.name),
                      Text(snapshot.data!.username),
                      Text(snapshot.data!.email),
                      Text(snapshot.data!.dob),
                      Text(snapshot.data!.degree),
                      Text(snapshot.data!.result.toString()),
                      Text(snapshot.data!.marks.toString()),
                      Text(snapshot.data!.klevel),
                      Text(snapshot.data!.scholarship.toString()),
                      //Text(snapshot.data!.comission.toString()),
                      Text(snapshot.data!.mexamid),
                      Text(snapshot.data!.mmarks.toString()),
                      Text(snapshot.data!.mstatus),
                      Text(snapshot.data!.fexamid),
                      Text(snapshot.data!.fmarks.toString()),
                      Text(snapshot.data!.fstatus),
                      Text(snapshot.data!.course),
                      Text(snapshot.data!.pstatus),
                      //Text(snapshot.data!.progree.toString()),
                      Text(snapshot.data!.pastatus),
                    ],
                  );



                } else if (snapshot.hasError) {
                  return Text('${snapshot.error}');
                }

                // By default, show a loading spinner.
                return const CircularProgressIndicator();
              },
            ),
          ),
        ),
      ),
    );
  }
}