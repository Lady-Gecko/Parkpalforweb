import 'package:flutter/material.dart';
import 'dart:io';

class TermsAndConditionsPage extends StatelessWidget {
  final List<String> termsAndConditions = [];

  TermsAndConditionsPage() {
    // Read terms from the text file
    File file = File('assets/terms.txt'); // Adjust the path accordingly
    termsAndConditions.addAll(file.readAsLinesSync());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Terms and Conditions'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView.builder(
          itemCount: termsAndConditions.length,
          itemBuilder: (context, index) {
            return ListTile(
              contentPadding: EdgeInsets.all(0),
              leading: Icon(Icons.fiber_manual_record),
              title: Text(
                termsAndConditions[index],
                style: TextStyle(fontSize: 16.0),
              ),
            );
          },
        ),
      ),
    );
  }
}
