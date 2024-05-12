import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:mysql_client/mysql_client.dart';
import 'bookingpage.dart';

void sendDataToServer({
  required String name,
  required String email,
  required String phone,
  required String reg,
  required String selectedStartDateAndTime,
  required String selectedEndDateAndTime,
  required bool blueBadgeHolder,
}) async {
  // MySQL connection setup
  final conn = await MySQLConnection.createConnection(
    host: "146.148.2.155", // Modify with your MySQL server IP
    port: 3306, // Modify with your MySQL server port
    userName: "root", // Modify with your MySQL username
    password: "Cardiffmet1", // Modify with your MySQL password
    databaseName: "ParkingAppdatabase", // Modify with your MySQL database name
  );
  await conn.connect(); // Establish the MySQL connection

  // HTTP client setup with timeout
  http.Client client = http.Client();
  Duration timeoutDuration = Duration(seconds: 60); // Timeout duration

  final String apiUrl = 'http://146.148.2.155:22/'; // Server address

  // Prepare data to send
  Map<String, dynamic> postData = {
    'name': name,
    'email': email,
    'phone': phone,
    'reg': reg,
    'start': selectedStartDateAndTime,
    'end': selectedEndDateAndTime,
    'blueBadgeHolder': blueBadgeHolder.toString(),
  };

  // Make the HTTP POST request with timeout
  try {
    final response = await client.post(
      Uri.parse(apiUrl),
      body: jsonEncode(postData),
      headers: {'Content-Type': 'application/json'},
    ).timeout(timeoutDuration);

    // Check the server response
    if (response.statusCode == 200) {
      print('Data sent successfully!');
    } else {
      print('Failed to send data. Server responded with ${response.statusCode}.');
    }
  } catch (error) {
    print('Error sending data: $error');
  } finally {
    client.close(); // Close the HTTP client
    await conn.close(); // Close MySQL connection
  }
}
