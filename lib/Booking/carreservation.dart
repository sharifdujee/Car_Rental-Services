import 'package:carrentalservices/Payment/booking_payment.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:intl/intl.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

class BookingScrren extends StatefulWidget {
  const BookingScrren({super.key});

  @override
  State<BookingScrren> createState() => _BookingScrrenState();
}

class _BookingScrrenState extends State<BookingScrren> {
  //variable discount, coupion, seanson  total price, price after discount
  //airport passcenger flight no
  TextEditingController _uid = TextEditingController();
  TextEditingController _username = TextEditingController();
  TextEditingController _lastname = TextEditingController();
  TextEditingController _email = TextEditingController();
  TextEditingController _phone = TextEditingController();
  TextEditingController _age = TextEditingController();
  TextEditingController _address = TextEditingController();
  TextEditingController _pickupdate = TextEditingController();
  TextEditingController _pickuptime = TextEditingController();
  TextEditingController _dropofdate = TextEditingController();
  TextEditingController _dropoftime = TextEditingController();
  String _pickupplace = "Airport";
  String _dropofplace = "Airport";
  String _numberOfPassenger = "one";
  String _package = "Holiday";
  String _ccategory = "General";
  String _tcategory = "Singel";

  // Save on FireBase
  void reserveCar() {
    String userid = _uid.text.trim();
    String username = _username.text.trim();
    String lastname = _lastname.text.trim();
    String email = _email.text.trim();
    String phone = _phone.text.trim();
    String age = _age.text.trim();
    String address = _address.text.trim();
    String pickupDate = _pickupdate.text.trim();
    String pickupTime = _pickuptime.text.trim();
    String dropofdate = _dropofdate.text.trim();
    String dropofTime = _dropoftime.text.trim();

    int user = int.parse(userid);
    int cnumber = int.parse(phone);
    int uage = int.parse(age);

    //clear
    _uid.clear();
    _username.clear();
    _lastname.clear();
    _email.clear();
    _phone.clear();
    _age.clear();
    _address.clear();
    _pickupdate.clear();
    _pickuptime.clear();
    _dropofdate.clear();
    _dropoftime.clear();

    if (userid != "" && _username != "") {}
    Map<String, dynamic> bookingData = {
      "userId": user,
      "userName": username,
      "lastname": lastname,
      "email": email,
      "phone": phone,
      "age": age,
      "address": address,
      "pickupDate": pickupDate,
      "pickupTime": pickupTime,
      "pickupPlace": _pickupplace,
      "DropOfDate": dropofdate,
      "DropOfTime": dropofTime,
      "DropOfPlace": _dropofplace,
      "Number of Passenger": _numberOfPassenger,
      "Package": _package,
      "Customer Category" : _ccategory,
      "Trip Category" : _tcategory,
      "BookingArray": [
        user,
        username,
        lastname,
        email,
        cnumber,
        age,
        address,
        pickupDate,
        pickupTime,
        _pickupplace,
        dropofdate,
        dropofTime,
        _dropofplace,
        _numberOfPassenger,
        _package,
        _ccategory,
        _tcategory,
      ]
    };

    FirebaseFirestore.instance.collection("Booking").add(bookingData);
    SnackBar(
      content: Text("Booking Is Confirmed"),
    );
  }

  void retrieveData() {
    FirebaseFirestore.instance.collection("Driver").get().then((value) => {
      value.docs.forEach((results) {
        print(results.data());
      }),
    });
  }

  void retrieveSubCollection() {
    FirebaseFirestore.instance.collection("users").get().then((value) => {
      value.docs.forEach((results) {
        FirebaseFirestore.instance
            .collection("users")
            .doc(results.id)
            .collection("pets")
            .get()
            .then((subcol) {
          subcol.docs.forEach((element) {
            print(element.data());
          });
        });
      }),
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Form(
          child: Column(
            children: [
              Text(
                "Car Reservation Form",
                style: TextStyle(
                  color: Colors.green,
                  fontSize: 30,
                ),
              ),
              FormBuilderTextField(
                keyboardType: TextInputType.number,
                name: "uid",
                controller: _uid,
                decoration: InputDecoration(
                    labelText: "User ID",
                    border: OutlineInputBorder(),
                    icon: Icon(Icons.perm_identity_outlined),
                    suffixText: "Enter Your User ID"),
                onChanged: (value) {},
              ),

              const SizedBox(
                height: 10,
              ),
              FormBuilderTextField(
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.black,
                ),
                keyboardType: TextInputType.text,
                name: "uid",
                controller: _username,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "First Name",
                  icon: Icon(Icons.verified_user),
                  suffixText: "Enter a Valid UserName",
                ),
                onChanged: (value) {},
              ),
              const SizedBox(
                width: 5,
              ),
              FormBuilderTextField(
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.black,
                ),
                keyboardType: TextInputType.text,
                name: "lastname",
                controller: _lastname,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "Last Name",
                  icon: Icon(Icons.verified_user),
                  suffixText: "Enter a Valid UserName",
                ),
                onChanged: (value) {},
              ),
              const SizedBox(
                width: 10,
              ),
              FormBuilderTextField(
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.black,
                ),
                keyboardType: TextInputType.text,
                name: "uid",
                controller: _email,
                decoration: InputDecoration(
                  labelText: "Email",
                  border: OutlineInputBorder(),
                  icon: Icon(Icons.email_outlined),
                  suffixText: "Enter  Your Email",
                ),
                onChanged: (value) {},
              ),
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: EdgeInsets.all(10),
                child: IntlPhoneField(
                  decoration: InputDecoration(
                      icon: Icon(Icons.phone),
                      border: OutlineInputBorder(),
                      labelText: "Phone Number"),
                  initialCountryCode: "BD",
                  controller: _phone,
                ),
              ),
              // FormBuilderTextField(
              //
              //   style: TextStyle(
              //     fontSize: 15,
              //     color: Colors.black,
              //   ),
              //   keyboardType: TextInputType.number,
              //   name: "uid",
              //   controller: _phone,
              //   decoration: InputDecoration(
              //     icon: Icon(Icons.phone_outlined),
              //     suffixText: "Enter  Your Contactable Phone Number",
              //   ),
              //
              //   onChanged: (value) {},
              // ),

              FormBuilderTextField(
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.black,
                ),
                keyboardType: TextInputType.number,
                name: "age",
                controller: _age,
                decoration: InputDecoration(
                  labelText: "Age",
                  border: OutlineInputBorder(),
                  icon: Icon(Icons.agriculture),
                  suffixText: "Enter  Your Age",
                ),
                onChanged: (value) {},
              ),
              const SizedBox(
                height: 10,
              ),
              FormBuilderTextField(
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.black,
                ),
                keyboardType: TextInputType.text,
                name: "Address",
                controller: _address,
                decoration: InputDecoration(
                  labelText: "Address",
                  border: OutlineInputBorder(),
                  icon: Icon(Icons.home),
                  suffixText: "Enter Details Address",
                ),
                onChanged: (value) {},
              ),
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: FormBuilderTextField(
                  name: "Pickupdate",
                  controller: _pickupdate,
                  decoration: InputDecoration(
                    icon: Icon(Icons.calendar_today_rounded),
                    labelText: "Select Data",
                    border: OutlineInputBorder(),
                  ),
                  onTap: () async {
                    DateTime? pickupdate = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(2023),
                      lastDate: DateTime(2028),
                    );
                    if (pickupdate != null) {
                      setState(() {
                        _pickupdate.text =
                            DateFormat('yyyy-MM-dd').format(pickupdate);
                      });
                    }
                  },
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: EdgeInsets.all(10),
                child: TextFormField(
                  controller: _pickuptime,
                  decoration: InputDecoration(
                    icon: Icon(Icons.timer),
                    labelText: "PickupTime",
                    border: OutlineInputBorder(),
                  ),
                  readOnly: true,
                  onTap: () async {
                    TimeOfDay? pickedTime = await showTimePicker(
                      initialTime: TimeOfDay.now(),
                      context: context,
                    );
                    if (pickedTime != null) {
                      DateTime parsedTime = DateFormat.jm()
                          .parse(pickedTime.format(context).toString());
                      String formattedTime =
                      DateFormat('HH:mm:ss').format(parsedTime);
                      setState(() {
                        _pickuptime.text = formattedTime.toString();
                      });
                    }
                  },
                ),
              ),
              const SizedBox(
                height: 10,
              ),
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
                      name: 'Airport',
                      value: "Airport",
                      toolTipMsg: "Pick From Airport?"),
                  DropDownValueModel(
                      name: 'Bus Terminal',
                      value: "Bus Terminal",
                      toolTipMsg: "Pick From Bus Terminal?"),
                  DropDownValueModel(
                      name: 'Train Station',
                      value: "Train Station",
                      toolTipMsg: "Pick From Train Station?"),
                  DropDownValueModel(
                      name: 'Home',
                      value: "Home",
                      toolTipMsg: "Pick From Home?"),
                  DropDownValueModel(
                      name: 'Hotel ',
                      value: "Hotel",
                      toolTipMsg: "Pick From  Hotel?"),
                ],
                dropdownColor: Colors.green,
                onChanged: (value) {
                  setState(() {
                    // _condition = value;
                  });
                },
              ),
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: FormBuilderTextField(
                  name: "dropofDate",
                  controller: _dropofdate,
                  decoration: InputDecoration(
                    icon: Icon(Icons.calendar_today_rounded),
                    labelText: "Drop  Data",
                    border: OutlineInputBorder(),
                  ),
                  onTap: () async {
                    DateTime? pickupdate = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(2023),
                      lastDate: DateTime(2028),
                    );
                    if (pickupdate != null) {
                      setState(() {
                        _dropofdate.text =
                            DateFormat('yyyy-MM-dd').format(pickupdate);
                      });
                    }
                  },
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: EdgeInsets.all(10),
                child: TextFormField(
                  controller: _dropoftime,
                  decoration: InputDecoration(
                    icon: Icon(Icons.timer),
                    labelText: "Drop offTime",
                    border: OutlineInputBorder(),
                  ),
                  readOnly: true,
                  onTap: () async {
                    TimeOfDay? pickedTime = await showTimePicker(
                      initialTime: TimeOfDay.now(),
                      context: context,
                    );
                    if (pickedTime != null) {
                      DateTime parsedTime = DateFormat.jm()
                          .parse(pickedTime.format(context).toString());
                      String formattedTime =
                      DateFormat('HH:mm:ss').format(parsedTime);
                      setState(() {
                        _dropoftime.text = formattedTime.toString();
                      });
                    }
                  },
                ),
              ),
              const SizedBox(
                height: 10,
              ),
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
                      name: 'Airport',
                      value: "Airport",
                      toolTipMsg: "Pick From Airport?"),
                  DropDownValueModel(
                      name: 'Bus Terminal',
                      value: "Bus Terminal",
                      toolTipMsg: "Pick From Bus Terminal?"),
                  DropDownValueModel(
                      name: 'Train Station',
                      value: "Train Station",
                      toolTipMsg: "Pick From Train Station?"),
                  DropDownValueModel(
                      name: 'Home',
                      value: "Home",
                      toolTipMsg: "Pick From Home?"),
                  DropDownValueModel(
                      name: 'Hotel ',
                      value: "Hotel",
                      toolTipMsg: "Pick From  Hotel?"),
                ],
                dropdownColor: Colors.green,
                onChanged: (value) {
                  setState(() {
                    // _condition = value;
                  });
                },
              ),
              const SizedBox(
                height: 10,
              ),
              FormBuilderRadioGroup(
                name: "Status",
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "Number of Passenger",
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
                    _numberOfPassenger = value.toString();
                  });
                },
                options: const [
                  FormBuilderFieldOption(value: "One"),
                  FormBuilderFieldOption(value: "Two"),
                  FormBuilderFieldOption(value: "Three"),
                  FormBuilderFieldOption(value: "Four"),
                  FormBuilderFieldOption(value: "Five"),
                  FormBuilderFieldOption(value: "Six"),
                  FormBuilderFieldOption(value: "Seven"),
                  FormBuilderFieldOption(value: "Eight"),
                  FormBuilderFieldOption(value: "Nine"),
                  FormBuilderFieldOption(value: "Ten"),
                  FormBuilderFieldOption(value: "Ten++"),
                ],
                initialValue: true,
              ),
              const SizedBox(
                height: 10,
              ),
              FormBuilderRadioGroup(
                name: "Status",
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "Package",
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
                    _package = value.toString();
                  });
                },
                options: const [
                  FormBuilderFieldOption(value: "Holiday"),
                  FormBuilderFieldOption(value: "Day-Long"),
                  FormBuilderFieldOption(value: "Weekend"),
                  FormBuilderFieldOption(value: "Airport Services"),
                  FormBuilderFieldOption(value: "Long-Drive"),
                  FormBuilderFieldOption(value: "Tourist"),
                  FormBuilderFieldOption(value: "Family Trip"),
                  FormBuilderFieldOption(value: "Others"),
                ],
                initialValue: true,
              ),
              SizedBox(
                height: 10,
              ),
              const SizedBox(
                height: 10,
              ),
              FormBuilderRadioGroup(
                name: "Status",
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "Categoy of Customer",
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
                    _numberOfPassenger = value.toString();
                  });
                },
                options: const [
                  FormBuilderFieldOption(value: "General"),
                  FormBuilderFieldOption(value: "Regular"),
                  FormBuilderFieldOption(value: "International"),
                  FormBuilderFieldOption(value: "Business"),
                  FormBuilderFieldOption(value: "University"),
                  FormBuilderFieldOption(value: "Tourists"),
                ],
                initialValue: true,
              ),
              const SizedBox(
                height: 10,
              ),
              FormBuilderRadioGroup(
                name: "Status",
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "Category of Trip ",
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
                    _numberOfPassenger = value.toString();
                  });
                },
                options: const [
                  FormBuilderFieldOption(value: "Single Trip"),
                  FormBuilderFieldOption(value: "Round Trip"),
                  FormBuilderFieldOption(value: "Weekly"),
                  FormBuilderFieldOption(value: "Monthly"),
                  FormBuilderFieldOption(value: "Yearly"),

                ],
                initialValue: true,
              ),
              // const Text("Number of Passcenger"),
              // Row(
              //   children: [
              //     Checkbox(value: one, onChanged: (bool? value){
              //
              //       setState(() {
              //         one= value!;
              //
              //       });
              //
              //     },
              //     ),
              //     Text("One"),
              //   ],
              // ),
              //Rubel Vai Check
              // const Text("Rubel Vai CheckBox"),
              // Row(
              //
              //   children: [
              //     Checkbox(value: rubel,
              //
              //         onChanged: (bool? value){
              //           setState(() {
              //             rubel = value!;
              //           });
              //         }),
              //     Text("Rubel"),
              //     Checkbox(value: selim,
              //         onChanged: (bool? value){
              //           setState(() {
              //             selim = value!;
              //           });
              //         }),
              //     Text("Selim Uncel"),
              //   ],
              //
              // ),

              ElevatedButton(
                onPressed: () {
                  setState(() {
                    reserveCar();
                  });
                },
                child: Text("Confirm Booking"),
              ),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    // retrieveData();
                    retrieveSubCollection();
                  });
                },
                child: Text("Get Data"),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder:(context) =>BookinPaymentScrren()),);
                },
                child: Text("Go To Payment"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
