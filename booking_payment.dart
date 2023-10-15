import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
class BookinPaymentScrren extends StatefulWidget {
  const BookinPaymentScrren({super.key});

  @override
  State<BookinPaymentScrren> createState() => _BookinPaymentScrrenState();
}

class _BookinPaymentScrrenState extends State<BookinPaymentScrren> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Booking Payment"),
      ),
      body: SafeArea(child: SingleChildScrollView(
        child: Form(child:FormBuilder(child: Column(
          children: [
            TextFormField(
              decoration: InputDecoration(
                labelText: "User ID",
                border: OutlineInputBorder(),
              ),
            )

          ],
        ),
        ),

        ),
      )),
    );
  }
}
