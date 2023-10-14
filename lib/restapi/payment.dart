import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
//
// Future<payment> fetchAlbum() async {
//   final response =
//   await http.get(Uri.parse('http://192.168.0.194:8080/paysearch/1271964'));
//
//   if (response.statusCode == 200) {
//     // If the server did return a 200 OK response,
//     // then parse the JSON.
//     return payment.fromJson(jsonDecode(response.body));
//   } else {
//     // If the server did not return a 200 OK response,
//     // then throw an exception.
//     throw Exception('Failed to load album');
//   }
// }

// To parse this JSON data, do
//
//     final student = studentFromJson(jsonString);
Future<List<payment>?> getUsers() async {
  try {
    //Room
    // var url = Uri.parse("http://192.168.0.188:8080/payall");
    // Tsp
    var url = Uri.parse("http://192.168.0.115:8080/payall");
    var response = await http.get(url);
    if (response.statusCode == 200) {
      List<payment> _model = paymentFromJson(response.body);
      return _model;
    }
  } catch (e) {
    log(e.toString());
  }
}

List<payment> paymentFromJson(String str) =>
    List<payment>.from(json.decode(str).map((x) => payment.fromJson(x)));

String studentToJson(List<payment> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class payment {
  final int tid;
  final double tuitionfee;
  final double scholarship;
  final double comission;
  final double payable;
  final String status;
  // String email;
  // int round;

  payment({
    required this.tid,
    required this.tuitionfee,
    required this.scholarship,
    required this.comission,
    required this.payable,
    required this.status,
  });

  factory payment.fromJson(Map<String, dynamic> json) => payment(
    tid: json["tid"],
    tuitionfee: json["tuitionfee"],
    scholarship: json["scholarship"],
    comission: json["comission"],
    payable: json["payable"],
    status: json["status"],

  );

  Map<String, dynamic> toJson() => {
    "tid": tid,
    "tuitionfee": tuitionfee,
    "scholarship" : scholarship,
    "comission" : comission,
    "payable" : payable,
    "status": status,
  };
}

void main() => runApp(const Payment());

class Payment extends StatefulWidget {
  const Payment({super.key});

  @override
  State<Payment> createState() => _MyAppState();
}

class _MyAppState extends State<Payment> {
  late Future<payment> futureAlbum;
  late List<payment>? _model = [];

  @override
  void initState() {
    super.initState();
    // futureAlbum = fetchAlbum();
    _getData();
  }

  void _getData() async {
    _model = (await getUsers())!;
  }



  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Payment ',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Fetch Data Example'),
        ),
        body: Center(
          child: ListView.builder(
            itemCount: _model!.length,
            itemBuilder: (context, index) {
              return Card(
                child: Column(
                  children: [
                    ListTile(
                      leading: Text(_model![index].tid.toString(),style: TextStyle(
                        fontSize: 30,
                      ),),
                      title: Row(
                        children: [
                          Text( _model![index].tuitionfee.toString()),
                          SizedBox(width: 2,),
                          Text(_model![index].scholarship.toString()),
                          SizedBox(width: 2,),
                          Text(_model![index].comission.toString()),
                          SizedBox(width: 2,),

                        ],
                      ),
                      subtitle: Text(_model![index].payable.toString()),
                      // title:  Text(_model![index].tuitionfee.toString()),

                      trailing:  Text(_model![index].status),

                    ),

                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}



// import 'dart:async';
// import 'dart:convert';
//
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
//
// Future<student> fetchAlbum() async {
//   final response = await http
//       .get(Uri.parse('http://192.168.0.75:8080/student/1012'));
//
//   if (response.statusCode == 200) {
//     // If the server did return a 200 OK response,
//     // then parse the JSON.
//     return student.fromJson(jsonDecode(response.body));
//   } else {
//     // If the server did not return a 200 OK response,
//     // then throw an exception.
//     throw Exception('Failed to load album');
//   }
// }
//
// class student {
//   final int id;
//   final String name;
//   final String  email;
//   final int round;
//
//   const student({
//     required this.id,
//     required this.name,
//     required this.email,
//     required this.round,
//   });
//
//   factory student.fromJson(Map<String, dynamic> json) {
//     return student(
//       id: json['id'],
//       name: json['name'],
//       email: json['email'],
//       round: json['round'],
//     );
//   }
// }
//
// void main() => runApp(const MyApp());
//
// class MyApp extends StatefulWidget {
//   const MyApp({super.key});
//
//   @override
//   State<MyApp> createState() => _MyAppState();
// }
//
// class _MyAppState extends State<MyApp> {
//   late Future<student> futureAlbum;
//
//   @override
//   void initState() {
//     super.initState();
//     futureAlbum = fetchAlbum();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Fetch Data Example',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home: Scaffold(
//         appBar: AppBar(
//           title: const Text('Fetch Data Example'),
//         ),
//         body: Center(
//           child: FutureBuilder<student>(
//             future: futureAlbum,
//             builder: (context, snapshot) {
//               if (snapshot.hasData) {
//                 return Column(
//                   children: [
//                     Text(snapshot.data!.id.toString()),
//                     Text(snapshot.data!.name),
//                     Text(snapshot.data!.email),
//                     Text(snapshot.data!.round.toString()),
//                   ],
//                 );
//
//               } else if (snapshot.hasError) {
//                 return Text('${snapshot.error}');
//               }
//
//               // By default, show a loading spinner.
//               return const CircularProgressIndicator();
//             },
//           ),
//         ),
//       ),
//     );
//   }
// }