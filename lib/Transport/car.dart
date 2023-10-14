import 'dart:io';
import 'dart:developer';
import 'dart:async';
import 'package:action_slider/action_slider.dart';
import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart' as Path;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:image_picker/image_picker.dart';

class CarScreen extends StatefulWidget {
  const CarScreen({super.key});

  @override
  State<CarScreen> createState() => _CarScreenState();
}

class _CarScreenState extends State<CarScreen> {
  final _formkey = GlobalKey<FormBuilderState>();
  void _onChanged(dynamic val) => debugPrint(val.toString());
  bool _ageHasError = false;
  bool terms = false;
  bool policy = false;
  // Merin Aunty
  late File? _image = null;
  late String _uploadFileUrl = " ";

  String _status = "Available";
  TextEditingController _carName = TextEditingController();
  TextEditingController _carBrand = TextEditingController();
  TextEditingController _carModel = TextEditingController();
  TextEditingController _myear = TextEditingController();
  String _vehicle = "car";
  String _condition = "new";

// Merin Aunty
//   Future chooseFile() async {
//     final image =  await ImagePicker().pickImage(source: ImageSource.gallery);
//     if(image!=null){
//       setState(() {
//         _image = File(image.path);
//         uploadFile();
//       });
//
//     }
//   }
//

  // Future uploadFile() async{
  //   if(_image!=null){
  //     try{
  //       final storageReference =  FirebaseStorage.instance.ref().child('car/${Path.basename(_image!.path)}');
  //       final UploadTask uploadTask = storageReference.putFile(_image!);
  //       await uploadTask.whenComplete(() async{
  //         final url = await storageReference.getDownloadURL();
  //         setState(() {
  //           _uploadFileUrl = url;
  //         });
  //         print("File Uploaded");
  //
  //
  //       });
  //
  //     }
  //     catch (e){
  //       print("Failed To Upload: $e");
  //
  //     }
  //   }
  //   else{
  //     print("Please Choose a Image First");
  //   }
  //
  //
  // }
  //Insert Data
  void saveCar() async {
    String carname = _carName.text.trim();
    String carbrand = _carBrand.text.trim();
    String carmodel = _carModel.text.trim();
    String myear = _myear.text.trim();
    //String _status = status.text.trim();
    //String vechileteype = _vechiletype.text.trim();

    int year = int.parse(myear);
    //int age = int.parse(ageString);

    //clear
    _carName.clear();
    _carBrand.clear();
    _carModel.clear();
    _myear.clear();

    //_vechiletype.clear();

    //logic
    if (carname != " " && carbrand != "" && carmodel != "") {}
    Map<String, dynamic> carData = {
      "name": carname,
      "brand": carbrand,
      "model": carmodel,
      "Myear": year,
      // Save on Firbase
      "vehicle": _vehicle,
      "Status": _status,
      "category": _condition,
      // Merin Aunty
      // "photoe": _uploadFileUrl,
      "carArray": [
        carname,
        carbrand,
        carmodel,
        year,
        _status,
        _condition,
        _vehicle
      ]
    };
    FirebaseFirestore.instance.collection("Car").add(carData);
    SnackBar(
      content: Text("New Car Added"),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Form(
            child: FormBuilder(
              child: Column(
                children: [
                  // _image != null
                  //     ? Image.file(
                  //   _image!,
                  //   height: 150,
                  // )
                  //     : Container(height: 150),
                  // _image == null
                  //     ? ElevatedButton(
                  //   child: Text('Choose File'),
                  //   onPressed: chooseFile,
                  // )
                  //     : Container(),
                  // SizedBox(
                  //   height: 10,
                  // ),
                  // _image != null
                  //     ? ElevatedButton(
                  //   child: Text('Upload File'),
                  //   onPressed: uploadFile,
                  // )
                  //     : Container(),
                  SizedBox(
                    height: 10,
                  ),
                  FormBuilderTextField(
                    controller: _carName,
                    autovalidateMode: AutovalidateMode.always,
                    name: "Car Name",
                    decoration: InputDecoration(
                      labelText: " Name",
                      suffixIcon: _ageHasError
                          ? const Icon(Icons.error, color: Colors.red)
                          : const Icon(Icons.check, color: Colors.green),
                    ),
                    onChanged: (value) {
                      setState(() {
                        _ageHasError =
                        !(_formkey.currentState?.fields['name']?.validate() ??
                            false);
                      });
                    },
                  ),
                  SizedBox(
                    height: 2,
                  ),
                  FormBuilderTextField(
                    controller: _carBrand,
                    autovalidateMode: AutovalidateMode.always,
                    name: "Car Brand",
                    decoration: InputDecoration(
                      labelText: " Brand",
                      suffixIcon: _ageHasError
                          ? const Icon(Icons.error, color: Colors.red)
                          : const Icon(Icons.check, color: Colors.green),
                    ),
                    onChanged: (value) {
                      setState(() {
                        _ageHasError =
                        !(_formkey.currentState?.fields['name']?.validate() ??
                            false);
                      });
                    },
                  ),
                  SizedBox(
                    height: 2,
                  ),
                  FormBuilderTextField(
                    controller: _carModel,
                    autovalidateMode: AutovalidateMode.always,
                    name: "Car Model",
                    decoration: InputDecoration(
                      labelText: "Model",
                      suffixIcon: _ageHasError
                          ? const Icon(Icons.error, color: Colors.red)
                          : const Icon(Icons.check, color: Colors.green),
                    ),
                    onChanged: (value) {
                      setState(() {
                        _ageHasError =
                        !(_formkey.currentState?.fields['name']?.validate() ??
                            false);
                      });
                    },
                  ),
                  SizedBox(
                    height: 2,
                  ),
                  FormBuilderTextField(
                    keyboardType: TextInputType.number,
                    controller: _myear,
                    autovalidateMode: AutovalidateMode.always,
                    name: "Manufucturing Year",
                    decoration: InputDecoration(
                      labelText: "Manificature",
                      suffixIcon: _ageHasError
                          ? const Icon(Icons.error, color: Colors.red)
                          : const Icon(Icons.check, color: Colors.green),
                    ),
                    onChanged: (value) {
                      setState(() {
                        _ageHasError =
                        !(_formkey.currentState?.fields['name']?.validate() ??
                            false);
                      });
                    },
                  ),
                  SizedBox(
                    height: 2,
                  ),
                  FormBuilderRadioGroup(
                    name: "Status",
                    decoration: InputDecoration(
                      labelText: "Status",
                      labelStyle: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                      fillColor: Colors.green,
                      focusColor: Colors.yellow,
                      hoverColor: Colors.blue,
                    ),
                    onChanged: (value) {
                      setState(() {
                        _status = value.toString();
                      });
                    },
                    options: const [
                      FormBuilderFieldOption(value: "Available"),
                      FormBuilderFieldOption(value: "Booked"),
                      FormBuilderFieldOption(value: "out Of The Service")
                    ],
                    initialValue: true,
                  ),
                  SizedBox(
                    height: 2,
                  ),

                  FormBuilderRadioGroup(
                    name: "Status",
                    decoration: InputDecoration(
                      labelText: "Category",
                      labelStyle: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                      fillColor: Colors.green,
                      focusColor: Colors.yellow,
                      hoverColor: Colors.blue,
                    ),
                    onChanged: (value) {
                      setState(() {
                        _vehicle = value.toString();
                      });
                    },
                    options: const [
                      FormBuilderFieldOption(value: "Private Car"),
                      FormBuilderFieldOption(value: "Sedon"),
                      FormBuilderFieldOption(value: "out Of The Service")
                    ],
                    initialValue: true,
                  ),
                  //DropDown
                  // DropDownTextField(
                  //   clearOption: true,
                  //   enableSearch: true,
                  //   initialValue: const ["New"],
                  //   dropDownList: const [
                  //     DropDownValueModel(
                  //         name: 'New Customer',
                  //         value: "new",
                  //         toolTipMsg: "It Is Your First  Trip?"),
                  //     DropDownValueModel(
                  //         name: 'First Trip',
                  //         value: "First",
                  //         toolTipMsg: "It Is Your Second  Trip?"),
                  //     DropDownValueModel(
                  //         name: 'Second Trip',
                  //         value: "Second",
                  //         toolTipMsg: "It Is Your Third  Trip?"),
                  //     DropDownValueModel(
                  //         name: 'Third Trip',
                  //         value: "Third",
                  //         toolTipMsg: "It Is Your Fourth  Trip?"),
                  //     DropDownValueModel(
                  //         name: 'Fourth',
                  //         value: "Fourth",
                  //         toolTipMsg: "It Is Your First  Trip?"),
                  //   ],
                  //   onChanged: (value) {
                  //     setState(() {
                  //       // Go name , value and Text in Front
                  //       // When Not Use MultiSelection but one value store
                  //
                  //     });
                  //   },
                  // ),

                  //Single Search
                  DropDownTextField(
                    listSpace: 20,
                    listPadding: ListPadding(top: 10),
                    enableSearch: true,
                    validator: (value) {
                      if (value == null) {
                        return "Required Fill The Field";
                      } else {
                        return null;
                      }
                    },
                    dropDownList: const [
                      DropDownValueModel(
                          name: 'New Customer',
                          value: "new",
                          toolTipMsg: "It Is Your First  Trip?"),
                      DropDownValueModel(
                          name: 'First Trip',
                          value: "First",
                          toolTipMsg: "It Is Your Second  Trip?"),
                      DropDownValueModel(
                          name: 'Third Trip',
                          value: "Third",
                          toolTipMsg: "It Is Your Fourth  Trip?"),
                    ],
                    onChanged: (value) {
                      setState(() {
                        // _condition = value;
                      });
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: FormBuilderCheckbox(
                      name: "Status",
                      initialValue: false,
                      onChanged: _onChanged,
                      title: RichText(
                        text: const TextSpan(children: [
                          TextSpan(
                            text: "I Read The Terms and Condition",
                            style: TextStyle(
                              color: Colors.black,
                            ),
                          ),
                          // SizedBox(
                          //    width: 10,
                          //  ),
                        ]),
                      ),
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.only(top: .5),
                    child: FormBuilderCheckbox(
                      name: "Status",
                      initialValue: false,
                      onChanged: _onChanged,
                      title: RichText(
                        text: const TextSpan(children: [
                          TextSpan(
                            text:
                            "I Agree The Company Policy and Register My Vehicle For The Service",
                            style: TextStyle(
                              color: Colors.black,
                            ),
                          ),
                          // SizedBox(
                          //    width: 10,
                          //  ),
                        ]),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 2,
                  ),

                  const SizedBox(
                    height: 2,
                  ),
                  // Action Slider
                  ActionSlider.standard (
                    sliderBehavior: SliderBehavior.stretch,
                    width: 300,
                    backgroundColor: Colors.green,
                    toggleColor: Colors.yellow,
                    action: (controller) async {
                      controller.loading();
                      await Future.delayed(const Duration(seconds: 5));
                      controller.success();
                      await Future.delayed(const Duration(seconds: 3));
                    },
                  ),

                  ElevatedButton(
                    onPressed: () {
                      saveCar();
                    },
                    child: Text("Register"),
                  ),
                  SizedBox(
                    height: 2,
                  ),


                  StreamBuilder<QuerySnapshot>(
                    stream: FirebaseFirestore.instance.collection('Car').where("Myear", isGreaterThanOrEqualTo: 2019).snapshots(),
                    builder: (context, snapshot){
                      if(snapshot.connectionState == ConnectionState.active){
                        if(snapshot.hasData && snapshot.data !=null) {
                          return Expanded(child: ListView.builder(
                              itemCount: snapshot.data!.docs.length,
                              itemBuilder: (context, index) {
                                Map<String, dynamic> carData = snapshot.data!
                                    .docs[index].data() as Map<String, dynamic>;
                                return ListTile(
                                  leading: Text(carData["brand"]),

                                );
                              }
                          ),
                          );
                        }
                        else{
                          return  Text("No data Found");
                        }
                      }
                      else{
                        return Text("OutSide The Context");

                      }

                    },

                  ),
                  // StreamBuilder<QuerySnapshot>(
                  //   stream: FirebaseFirestore.instance
                  //       .collection("Car")
                  //       .where("myear", isGreaterThanOrEqualTo: 2020).orderBy("myear", descending: true )
                  //       .snapshots(),
                  //   builder: (context, snapshot) {
                  //     if (snapshot.connectionState == ConnectionState.active) {
                  //       if (snapshot.hasData && snapshot.data != null) {
                  //         return Expanded(
                  //           child: ListView.builder(
                  //             shrinkWrap: true,
                  //             itemCount: snapshot.data!.docs.length,
                  //             itemBuilder: (context, index) {
                  //               Map<String, dynamic> driverMap =
                  //               snapshot.data!.docs[index].data()
                  //               as Map<String, dynamic>;
                  //               return Column(
                  //                 children:  <Widget>[
                  //
                  //                   ListTile(
                  //                     leading: Text(driverMap["carname"] + "(${driverMap["myear"]})"),
                  //                     title: Text(driverMap["carBrand"]),
                  //                     subtitle: Text(driverMap["vechileNo"] +  " (${driverMap["VechileType"]})" ),
                  //                     trailing: Text(driverMap["LicenseNo"] + " (${driverMap["VechileType"]})"),
                  //                   ),
                  //
                  //                 ],
                  //               );
                  //             },
                  //           ),
                  //         );
                  //       } else {
                  //         return Text("No Data was Found");
                  //       }
                  //     } else {
                  //       return Center(
                  //         child: CircularProgressIndicator(),
                  //       );
                  //     }
                  //   },
                  // ),

                  // valueTransformer: (text) => num.tryParse(text),
                  //   validator: FormBuilderValidators.compose([
                  //     FormBuilderValidators.required(),
                  //     FormBuilderValidators.numeric(),
                  //     FormBuilderValidators.max(70),
                  //   ]),
                  //   // initialValue: '12',
                  //   keyboardType: TextInputType.number,
                  //   textInputAction: TextInputAction.next,
                  // ),
                  //
                ],
              ),
            ),
          ),

        ),
      ),
    );
  }
}
