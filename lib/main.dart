import 'package:flutter/material.dart';
import 'homepage.dart';
import 'landingpage.dart';
import 'bookingpage.dart';
import 'mapspage.dart';
import 'aboutpage.dart';
import 'termsandconditionspage.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ParkPal',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
      routes: {
        '/Book a Parking Sport': (context) => BookingPage(),
        '/maps': (context) => MapsPage(),
        '/about': (context) => aboutpage(),
        '/terms_and_conditions': (context) => TermsAndConditionsPage(),
      },
    );
  }
}
