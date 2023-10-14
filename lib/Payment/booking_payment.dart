import 'package:carrentalservices/googlemap/liveLocation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_credit_card/credit_card_brand.dart';
import 'package:flutter_credit_card/credit_card_widget.dart';
import 'package:flutter_credit_card/custom_card_type_icon.dart';
import 'package:flutter_credit_card/flutter_credit_card.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:themed/themed.dart';

class BookinPaymentScrren extends StatefulWidget {
  const BookinPaymentScrren({super.key});

  @override
  State<BookinPaymentScrren> createState() => _BookinPaymentScrrenState();
}

class _BookinPaymentScrrenState extends State<BookinPaymentScrren> {
  String cardNumber = '';
  String expiryDate = '';
  String cardHolderName = '';
  String cvvCode = '';
  bool isCvvFocused = false;
  bool useGlassMorphism = false;
  bool useBackgroundImage = false;
  double _totalpayment = 0;
  double _discount = 0;
  TextEditingController _usid = TextEditingController();
  //TextEditingController _totalPayment = TextEditingController();
  TextEditingController disount = TextEditingController();
  TextEditingController _finalpayment = TextEditingController();
  TextEditingController _advance = TextEditingController();
  TextEditingController _due = TextEditingController();
  TextEditingController coupon = TextEditingController();
  String _coupon = "holidays";
  double advance = 0.00;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  double discount() {
    if (_coupon.isNotEmpty) {
      return _discount = ((_totalpayment) - (0.05));
    } else {
      return _totalpayment;
    }
  }

  double due(){
    return  (_totalpayment) - (advance);

  }

  //Insert Payment
  void savePayment() {
    String userid = _usid.text.trim();

    if (cardHolderName != " ") {
      Map<String, dynamic> paymentData = {
        "uid": _usid,
        "cardNo": cardNumber,
        "expire": expiryDate,
        "cvv": cvvCode,
        "name": cardHolderName,
        "Total": _totalpayment,
        "Discount": discount,
        "Coupon": _coupon,
        "paymentArray": [
          _usid,
          cardNumber,
          expiryDate,
          cvvCode,
          cardHolderName,
          _totalpayment,
          discount,
          _coupon,
        ]
      };
      FirebaseFirestore.instance.collection("Payment").add(paymentData);
      SnackBar(
        content: Text("Payment is Done"),
      );
    } else {
      SnackBar(
        content: Text("Payment is Done"),
      );
    }
  }
  //
  // void saveUser() async {
  //   String name = nameController.text.trim();
  //   String username = _username.text.trim();
  //   String email = emailController.text.trim();
  //   String ageString = ageController.text.trim();
  //   String dobString = _dob.text.trim();
  //
  //   int age = int.parse(ageString);
  //
  //
  //   nameController.clear();
  //   _username.clear();
  //   emailController.clear();
  //   ageController.clear();
  //   _dob.clear();
  //   _username.clear();
  //
  //   //if (name != "" && email != "" && profilepic!=null)
  //   if (name != "" && email != "") {
  //     // Picture
  //     UploadTask uploadTask = FirebaseStorage.instance.ref().child("profilepictures").child(Uuid().v1()).putFile(profilepic!);
  //
  //     StreamSubscription taskSubscription = uploadTask.snapshotEvents.listen((snapshot) {
  //       double percentage = snapshot.bytesTransferred/snapshot.totalBytes * 100;
  //       log(percentage.toString());
  //     });
  //
  //     TaskSnapshot taskSnapshot = await uploadTask;
  //     String downloadUrl = await taskSnapshot.ref.getDownloadURL();
  //
  //     taskSubscription.cancel();
  //     // end picture
  //     // UploadTask uploadTask =  FirebaseStorage.instance.ref().child("profilepictures").child(Uuid().v1()).putFile(profilepic!);
  //     //         TaskSnapshot taskSnapshot = await uploadTask;
  //     //         String downloadUrl = await taskSnapshot.ref.getDownloadURL();
  //     Map<String, dynamic> userData = {
  //       "name": name,
  //       "username": username,
  //       "email": email,
  //       "age": age,
  //       "dob": dobString,
  //       "profilepic": downloadUrl,
  //       "sampleArray": [name, username, email, age, dobString]
  //     };
  //     FirebaseFirestore.instance.collection("users").add(userData);
  //     log("User created!");
  //   } else {
  //     log("Please fill all the fields!");
  //   }
  //
  //   setState(() {
  //     profilepic = null;
  //   });
  // }
  //

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
        child: Form(
          child: FormBuilder(
            child: Column(
              children: [
                Text(
                  "Booking Payment Page",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w900,
                    color: Colors.green,
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                CreditCardWidget(
                  glassmorphismConfig:
                      useGlassMorphism ? Glassmorphism.defaultConfig() : null,
                  cardNumber: cardNumber,
                  expiryDate: expiryDate,
                  cardHolderName: cardHolderName,
                  cvvCode: cvvCode,
                  bankName: 'Dutch Bangla Bank',
                  frontCardBorder:
                      !useGlassMorphism ? Border.all(color: Colors.grey) : null,
                  backCardBorder:
                      !useGlassMorphism ? Border.all(color: Colors.grey) : null,
                  showBackView: isCvvFocused,
                  obscureCardNumber: true,
                  obscureCardCvv: true,
                  isHolderNameVisible: true,
                  backgroundImage:
                      useBackgroundImage ? 'assets/user.jpg' : null,
                  isSwipeGestureEnabled: true,
                  onCreditCardWidgetChange:
                      (CreditCardBrand creditCardBrand) {},
                  customCardTypeIcons: <CustomCardTypeIcon>[
                    CustomCardTypeIcon(
                      cardType: CardType.mastercard,
                      cardImage: Image.asset(
                        "images/user.jpg",
                        height: 48,
                        width: 48,
                      ),
                    )
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                FormBuilderTextField(
                  controller: _usid,
                  keyboardType: TextInputType.number,
                  name: " User ID",
                  decoration: InputDecoration(
                    labelText: "User ID",
                    icon: Icon(Icons.verified_user),
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                const Text("Card Payment Section"),
                CreditCardForm(
                  formKey: formKey,
                  obscureCvv: true,
                  obscureNumber: true,
                  cardNumber: cardNumber,
                  expiryDate: expiryDate,
                  cardHolderName: cardHolderName,
                  cardNumberDecoration: InputDecoration(
                    labelText: ' Card Number',
                    hintText: 'XXXX XXXX XXXX XXXX',
                    hintStyle: const TextStyle(color: Colors.blue),
                    labelStyle: const TextStyle(color: Colors.black),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        width: 3,
                        color: Colors.green,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                      width: 3,
                      color: Colors.green,
                    )),
                  ),
                  expiryDateDecoration: InputDecoration(
                    labelText: 'Expire Date',
                    hintText: '12/2025  ',
                    hintStyle: const TextStyle(color: Colors.blue),
                    labelStyle: const TextStyle(color: Colors.black),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        width: 3,
                        color: Colors.green,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                      width: 3,
                      color: Colors.green,
                    )),
                  ),
                  cvvCodeDecoration: InputDecoration(
                    labelText: 'Cvv',
                    hintText: '2222222222222',
                    hintStyle: const TextStyle(color: Colors.blue),
                    labelStyle: const TextStyle(color: Colors.black),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        width: 3,
                        color: Colors.green,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                      width: 3,
                      color: Colors.green,
                    )),
                  ),
                  cardHolderDecoration: InputDecoration(
                    labelText: 'Card Holder Name ',
                    hintText: 'Mr. Rubel Hossain',
                    hintStyle: const TextStyle(color: Colors.blue),
                    labelStyle: const TextStyle(color: Colors.black),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        width: 3,
                        color: Colors.green,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                      width: 3,
                      color: Colors.green,
                    )),
                  ),
                  cvvCode: cvvCode,
                  themeColor: Colors.blue,
                  textColor: Colors.black,
                  isHolderNameVisible: true,
                  isCardNumberVisible: true,
                  isExpiryDateVisible: true,
                  onCreditCardModelChange: onCreditCardModelChange,
                ),
                const SizedBox(
                  height: 20,
                ),
                FormBuilderTextField(
                  keyboardType: TextInputType.number,
                  name: " Payment",
                  decoration: InputDecoration(
                    labelText: "Total Payment",
                    icon: Icon(Icons.calculate),
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                FormBuilderTextField(
                  controller: coupon,
                  keyboardType: TextInputType.text,
                  name: " Payment",
                  decoration: InputDecoration(
                    labelText: "Coupon",
                    icon: Icon(Icons.calculate),
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                FormBuilderTextField(
                  controller: disount,
                  keyboardType: TextInputType.number,
                  name: " Discount",
                  decoration: InputDecoration(
                    labelText: "Discount",
                    icon: Icon(Icons.calculate),
                    border: OutlineInputBorder(),
                  ),
                  onSaved: (value) {
                    setState(() {
                      discount();
                    });


                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                FormBuilderTextField(
                  controller: _advance,
                  keyboardType: TextInputType.number,
                  name: " Discount",
                  decoration: InputDecoration(
                    labelText: "Advance",
                    icon: Icon(Icons.money_rounded),
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                FormBuilderTextField(
                  controller: _due,
                  keyboardType: TextInputType.text,
                  name: " Discount",
                  decoration: InputDecoration(
                    labelText: "Due",
                    icon: Icon(Icons.money),
                    border: OutlineInputBorder(),
                  ),
                  onChanged: (value){
                    due();

                  },
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text("Back To Booking"),
                ),
                const SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      savePayment();
                    });
                  },
                  child: Text("Pay"),
                ),
              ],
            ),
          ),
        ),
      )),
    );
  }

  void onCreditCardModelChange(CreditCardModel? creditCardModel) {
    setState(() {
      cardNumber = creditCardModel!.cardNumber;
      expiryDate = creditCardModel.expiryDate;
      cardHolderName = creditCardModel.cardHolderName;
      cvvCode = creditCardModel.cvvCode;
      isCvvFocused = creditCardModel.isCvvFocused;
    });
  }
}
