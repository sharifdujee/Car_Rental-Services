import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
// import 'package:untitled/sigin.dart';
import 'dart:convert';
import 'package:flutter/material.dart';


List<Trainee> traineeFromJson(String str) =>
    List<Trainee>.from(json.decode(str).map((x) => Trainee.fromJson(x)));
String traineeToJson(List<Trainee> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Trainee {
  int tid;
  String name;
  String username;
  String email;
  String password;
  String dob;
  String gender;
  String degree;
  String subject;
  String session;
  String institution;
  String result;
  String division;
  String districit;
  String reference;
  String img;
  Trainee({
    required this.tid,
    required this.name,
    required this.username,
    required this.email,
    required this.password,
    required this.dob,
    required this.gender,
    required this.degree,
    required this.subject,
    required this.session,
    required this.institution,
    required this.result,
    required this.division,
    required this.districit,
    required this.reference,
    required this.img,
  });
  factory Trainee.fromJson(Map<String, dynamic> json) => Trainee(
    tid: json["tid"],
    name: json["name"],
    username: json["username"],
    email: json["email"],
    password: json["password"],
    dob: json["dob"],
    gender: json["gender"],
    degree: json["degree"],
    subject: json["subject"],
    session: json["session"],
    institution: json["institution"],
    result: json["result"],
    division: json["division"],
    districit: json["districit"],
    reference: json["reference"],
    img: json["img"],
  );
  Map<String, dynamic> toJson() => {
    "tid": tid,
    "name": name,
    "username": username,
    "email": email,
    "password": password,
    "dob": dob,
    "gender": gender,
    "degree": degree,
    "subject": subject,
    "session": session,
    "institution": institution,
    "result": result,
    "division": division,
    "districit": districit,
    "reference": reference,
    "img": img,
  };
}

class AddTrainee extends StatefulWidget {
  const AddTrainee({super.key});

  @override
  State<AddTrainee> createState() => _AddTraineeState();
}

class _AddTraineeState extends State<AddTrainee> {
  TextEditingController _tid = TextEditingController();
  TextEditingController _name = TextEditingController();
  TextEditingController _username = TextEditingController();
  TextEditingController _email = TextEditingController();
  TextEditingController _password = TextEditingController();
  TextEditingController _dob = TextEditingController();
  TextEditingController _gender = TextEditingController();
  TextEditingController _degree = TextEditingController();
  TextEditingController _subject = TextEditingController();
  TextEditingController _session = TextEditingController();
  TextEditingController _institution = TextEditingController();
  TextEditingController _result = TextEditingController();
  TextEditingController _division = TextEditingController();
  TextEditingController _districit = TextEditingController();
  TextEditingController _reference = TextEditingController();
  TextEditingController _img = TextEditingController();

  Future<Trainee> addTrainee() async {
    Trainee t = Trainee(
        tid: int.parse(_tid.text),
        name: _name.text,
        username: _username.text,
        email: _email.text,
        password: _password.text,
        dob: _dob.text,
        gender: _gender.text,
        degree: _degree.text,
        subject: _subject.text,
        session: _session.text,
        institution: _institution.text,
        result: _result.text,
        division: _division.text,
        districit: _districit.text,
        reference: _reference.text,
        img: _img.text);
    final response = await http.post(
      //Room
        Uri.parse('http://192.168.0.188:8080/tsave'),
        body: jsonEncode(t.toJson()),
        headers: {"content-type": "application/json"});
    if (response.statusCode == 200) {
      return Trainee.fromJson(jsonDecode(response.body));
    } else {
      throw Exception("Fail");
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("Add Trainee"),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              TextFormField(
                controller: _tid,
                decoration: InputDecoration(
                  label: Text("Trainee ID"),
                  hintText: "Enter Trainee Id",
                  icon: Icon(Icons.verified_user_outlined),
                ),
              ),
              SizedBox(
                height: 5,
              ),
              TextFormField(
                controller: _name,
                decoration: InputDecoration(
                  label: Text("Name"),
                  hintText: "Enter Name",
                  icon: Icon(Icons.person),
                ),
              ),
              SizedBox(
                height: 5,
              ),
              TextFormField(
                controller: _username,
                decoration: InputDecoration(
                  label: Text("UserName"),
                  hintText: "Enter UserName",
                  icon: Icon(Icons.person_2_outlined),
                ),
              ),
              SizedBox(
                height: 5,
              ),
              TextFormField(
                controller: _email,
                decoration: InputDecoration(
                  label: Text("Email"),
                  hintText: "Enter Email",
                  icon: Icon(Icons.email_outlined),
                ),
              ),
              SizedBox(
                height: 5,
              ),
              TextFormField(
                controller: _password,
                obscureText: true,
                decoration: InputDecoration(
                  label: Text("Password"),
                  hintText: "Enter Password",
                  icon: Icon(Icons.password),
                ),
              ),
              SizedBox(
                height: 5,
              ),
              TextFormField(
                controller: _dob,
                decoration: InputDecoration(
                  label: Text("DOB"),
                  hintText: "Enter DOB",
                  icon: Icon(Icons.date_range_outlined),
                ),
              ),
              SizedBox(
                height: 5,
              ),
              TextFormField(
                controller: _gender,
                decoration: InputDecoration(
                  label: Text("Gender"),
                  hintText: "Gender",
                  icon: Icon(Icons.perm_identity),
                ),
              ),
              SizedBox(
                height: 5,
              ),
              TextFormField(
                controller: _degree,
                decoration: InputDecoration(
                  label: Text("Degree"),
                  hintText: "Degree Name",
                  icon: Icon(Icons.cast_for_education),
                ),
              ),
              SizedBox(
                height: 5,
              ),
              TextFormField(
                controller: _subject,
                decoration: InputDecoration(
                  label: Text("Subject"),
                  hintText: "Subject Name",
                  icon: Icon(Icons.subject),
                ),
              ),
              SizedBox(
                height: 5,
              ),
              TextFormField(
                controller: _session,
                decoration: InputDecoration(
                  label: Text("Trainee ID"),
                  hintText: "Enter Trainee Id",
                  icon: Icon(Icons.date_range_sharp),
                ),
              ),
              SizedBox(
                height: 5,
              ),
              TextFormField(
                controller: _institution,
                decoration: InputDecoration(
                  label: Text("Institution"),
                  hintText: "Institution Name ",
                  icon: Icon(Icons.cast_for_education_sharp),
                ),
              ),
              SizedBox(
                height: 5,
              ),
              TextFormField(
                controller: _result,
                decoration: InputDecoration(
                  label: Text("Result"),
                  hintText: "Enter CGPA ",
                  icon: Icon(Icons.pin_end_rounded),
                ),
              ),
              SizedBox(
                height: 5,
              ),
              TextFormField(
                controller: _division,
                decoration: InputDecoration(
                  label: Text("Division"),
                  hintText: "Division Name",
                  icon: Icon(Icons.location_city_outlined),
                ),
              ),
              SizedBox(
                height: 5,
              ),
              TextFormField(
                controller: _districit,
                decoration: InputDecoration(
                  label: Text("Districit"),
                  hintText: "Districit Name",
                  icon: Icon(Icons.location_city),
                ),
              ),
              SizedBox(
                height: 5,
              ),
              TextFormField(
                controller: _reference,
                decoration: InputDecoration(
                  label: Text("Reference"),
                  hintText: "Reference Name",
                  icon: Icon(Icons.read_more),
                ),
              ),
              SizedBox(
                height: 5,
              ),
              TextFormField(
                controller: _img,
                decoration: InputDecoration(
                  label: Text("Profile"),
                  hintText: "Add Image Source",
                  icon: Icon(Icons.add_a_photo),
                ),
              ),
              SizedBox(
                height: 5,
              ),
              // ElevatedButton(onPressed:  () async {
              //   Trainee t = await addTrainee();
              //   if(t!= null){
              //     Navigator.push(context, MaterialPageRoute(builder: (context) => SignIn()));
              //
              //   }
              // },
              //   child: Text("Register"),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}


//             ElevatedButton(onPressed: ()async{
//               Customer c= await singupCustomer();
//               if(c!= null ){
//                 Navigator.push(context, MaterialPageRoute(builder: (context)=>SignIn()));
//               }
//             }, child: Text('SignUp'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
