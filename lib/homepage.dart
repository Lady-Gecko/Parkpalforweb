import 'package:flutter/material.dart';
import 'landingpage.dart';
import 'bookingpage.dart';
import 'mapspage.dart';
import 'aboutpage.dart';
import 'termsandconditionspage.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ParkPal'),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text(
                'ParkPal Menu',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            // Menu List ...
            ListTile(
              title: Text('Home'),
              onTap: () {
                setState(() {
                  _currentIndex = 0;
                  Navigator.pop(context);
                });
              },
            ),
            ListTile(
              title: Text('Book a Parking Spot'),
              onTap: () {
                setState(() {
                  _currentIndex = 1;
                  Navigator.pop(context);
                });
              },
            ),
            ListTile(
              title: Text('Maps'),
              onTap: () {
                setState(() {
                  _currentIndex = 2;
                  Navigator.pop(context);
                });
              },
            ),
            ListTile(
              title: Text('About'),
              onTap: () {
                setState(() {
                  _currentIndex = 3;
                  Navigator.pop(context);
                });
              },
            ),
            ListTile(
              title: Text('Terms and Conditions'),
              onTap: () {
                setState(() {
                  _currentIndex = 4;
                  Navigator.pop(context);
                });
              },
            ),
          ],
        ),
      ),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    switch (_currentIndex) {
      case 0:
        return LandingPage();
      case 1:
        return BookingPage();
      case 2:
        return MapsPage();
      case 3:
        return aboutpage();
      case 4:
        return TermsAndConditionsPage();
      default:
        return LandingPage();
    }
  }
}