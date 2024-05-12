import 'package:flutter/material.dart';
import 'dart:io';

class aboutpage extends StatelessWidget {
  final List<String> about = [];

  aboutpage() {
    // Read terms from the text file
    File file = File('assets/about.txt'); 
    about.addAll(file.readAsLinesSync());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('About Us'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView.builder(
          itemCount: about.length,
          itemBuilder: (context, index) {
            return ListTile(
              contentPadding: EdgeInsets.all(0),
              leading: Icon(Icons.fiber_manual_record),
              title: Text(
                about[index],
                style: TextStyle(fontSize: 16.0),
              ),
            );
          },
        ),
      ),
    );
  }
}