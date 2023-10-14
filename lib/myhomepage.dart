import 'package:carrentalservices/Booking/carreservation.dart';
import 'package:carrentalservices/Driver/driverregistration.dart';
import 'package:carrentalservices/Transport/car.dart';
import 'package:carrentalservices/Transport/showcar.dart';
import 'package:carrentalservices/User/customer.dart';
import 'package:carrentalservices/googlemap/googlemap.dart';
import 'package:carrentalservices/googlemap/liveLocation.dart';
import 'package:carrentalservices/googlemap/locationtrack.dart';
import 'package:carrentalservices/googlemap/nearbyplace.dart';
import 'package:carrentalservices/googlemap/polyline.dart';
import 'package:carrentalservices/home.dart';
import 'package:carrentalservices/model/nearby_response.dart';
import 'package:carrentalservices/restapi/addtrainee.dart';
import 'package:carrentalservices/restapi/payment.dart';
import 'package:carrentalservices/restapi/profile.dart';
import 'package:flutter/material.dart';
class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Widget> tasklist = <Widget>[
    const Profiles(),
    const Payment(),
    const AddTrainee(),
    const HomeScreen(),
    const MapSample(),
    const DriverRegistration(),
    const  GeolocatorWidget(),
    const CurrentLocationScreen(),
    const PolylineScreen(),
    const NearByPlacesScreen(),
    const CarScreen(),
    const ShowCar(),
    const CustomerScreen(),
    const BookingScrren(),

  ];
  int _selectedwork = 0;
  onChange(int i){
    setState(() {
      _selectedwork = i;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Car Rental Services"),
      ),
      drawer: Container(
        color: Colors.green,
        child: Drawer(
          child: ListView(
            children: [
              const UserAccountsDrawerHeader(
                currentAccountPicture: CircleAvatar(
                  backgroundImage: AssetImage("images/user.jpg"),

                ),
                  accountName: Text("Md Sharif Hossain"),
                  accountEmail: Text("sharifdu44@gmail.com"),
              ),
              ListTile(
                leading: const Icon(Icons.shower),
                title: Text("Trainee Profile"),
                onTap: (){
                  onChange(0);
                  Navigator.pop(context);
                },
              ),
              const SizedBox(
                height: 5,
              ),
              ListTile(
                leading: const Icon(Icons.payment),
                title: Text("Payment"),
                onTap: (){
                  onChange(1);
                  Navigator.pop(context);
                },
              ),
              const SizedBox(
                height: 5,
              ),
              ListTile(
                leading: const Icon(Icons.add),
                title: Text("Add Trainee"),
                onTap: (){
                  onChange(2);
                  Navigator.pop(context);
                },
              ),
              const SizedBox(
                height: 5,
              ),
              ListTile(
                leading: const Icon(Icons.person),
                title: Text("UserScreen"),
                onTap: (){
                  onChange(3);
                  Navigator.pop(context);
                },
              ),
              const SizedBox(
                height: 5,
              ),
              ListTile(
                leading: const Icon(Icons.location_city),
                title: Text("Location"),
                onTap: (){
                  onChange(4);
                  Navigator.pop(context);
                },
              ),
              const SizedBox(
                height: 5,
              ),
              ListTile(
                leading: const Icon(Icons.add),
                title: Text("Add Driver"),
                onTap: (){
                  onChange(5);
                  Navigator.pop(context);
                },
              ),
              const SizedBox(
                height: 5,
              ),
              ListTile(
                leading: const Icon(Icons.map),
                title: Text("Live Location"),
                onTap: (){
                  onChange(6);
                  Navigator.pop(context);
                },
              ),
              const SizedBox(
                height: 5,
              ),
              ListTile(
                leading: const Icon(Icons.map),
                title: Text("Current Location"),
                onTap: (){
                  onChange(7);
                  Navigator.pop(context);
                },
              ),
              const SizedBox(
                height: 5,
              ),
              ListTile(
                leading: const Icon(Icons.map),
                title: Text("PolyLine"),
                onTap: (){
                  onChange(8);
                  Navigator.pop(context);
                },
              ),
              const SizedBox(
                height: 5,
              ),
              ListTile(
                leading: const Icon(Icons.map),
                title: Text("NearBy Location"),
                onTap: (){
                  onChange(9);
                  Navigator.pop(context);
                },
              ),
              const SizedBox(
                height: 5,
              ),
              ListTile(
                leading: const Icon(Icons.map),
                title: Text("Add Car"),
                onTap: (){
                  onChange(10);
                  Navigator.pop(context);
                },
              ),
              const SizedBox(
                height: 5,
              ),
              ListTile(
                leading: const Icon(Icons.map),
                title: Text("Booking"),
                onTap: (){
                  onChange(11);
                  Navigator.pop(context);
                },
              ),

              const SizedBox(
                height: 5,
              ),
              ListTile(
                leading: const Icon(Icons.map),
                title: Text("Reservation"),
                onTap: (){
                  onChange(12);
                  Navigator.pop(context);
                },
              ),

              const SizedBox(
                height: 5,
              ),
            ],
          ),
        ),
      ),
      body: Center(
        child: tasklist[_selectedwork],
      ),
    );
  }
}
