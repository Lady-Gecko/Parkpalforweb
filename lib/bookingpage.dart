import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'sendtoserver.dart';
import 'package:flutter/gestures.dart';

class BookingPage extends StatefulWidget {
  @override
  _BookingPageState createState() => _BookingPageState();
}

class _BookingPageState extends State<BookingPage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController regController = TextEditingController();
  TextEditingController startdateController = TextEditingController();
  TextEditingController enddateController = TextEditingController();

  bool agreeToTerms = false;
  bool blueBadgeHolder = false;

  DateTime? selectedDate;
  TimeOfDay? selectedStartTime;
  TimeOfDay? selectedEndTime;

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    regController.dispose();
    startdateController.dispose();
    enddateController.dispose();
    super.dispose();
  }

  Future<void> _selectstartDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate ?? DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(DateTime.now().year + 1),
    );

    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
        startdateController.text = "${picked.year}/${picked.month}/${picked.day}";
      });
    }
  }

Future<void> _selectendDate(BuildContext context) async {
  final DateTime? picked = await showDatePicker(
    context: context,
    initialDate: selectedDate ?? DateTime.now(),
    firstDate: DateTime.now(),
    lastDate: DateTime(DateTime.now().year + 1),
  );

  if (picked != null && (picked.isAfter(selectedDate!) || picked.isAtSameMomentAs(selectedDate!))) {
    setState(() {
      selectedDate = picked;
      enddateController.text = "${picked.year}/${picked.month}/${picked.day}";
    });
  } else {
    print('End date must be after or the same as the start date.');
  }
  }

  Future<void> _selectStartTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: selectedStartTime ?? TimeOfDay.now(),
    );

    if (picked != null && picked != selectedStartTime) {
      setState(() {
        selectedStartTime = picked;
      });
    }
  }

  Future<void> _selectEndTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: selectedEndTime ?? TimeOfDay.now(),
    );

    if (picked != null && picked != selectedEndTime) {
      setState(() {
        selectedEndTime = picked;
      });
    }
  }

  String? validateEmail(String value) {
    if (!RegExp(r"^[a-zA-Z0-9_.+-]+@[a-zA-Z0-9-]+\.[a-zA-Z0-9-.]+$").hasMatch(value)) {
      return 'Enter a valid email address';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Book a Parking Spot'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Enter Your Details',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 20),
              TextField(
                controller: nameController,
                decoration: InputDecoration(
                  labelText: 'Name',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 20),
              TextFormField(
                controller: emailController,
                decoration: InputDecoration(
                  labelText: 'Email Address',
                  border: OutlineInputBorder(),
                ),
                validator: (value) => validateEmail(value!),
              ),
              SizedBox(height: 20),
              TextField(
                controller: phoneController,
                decoration: InputDecoration(
                  labelText: 'Phone Number',
                  border: OutlineInputBorder(),
                ),
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r'^\d{0,11}$')),
                ],
                keyboardType: TextInputType.number,
                maxLength: 11,
              ),
              SizedBox(height: 20),
              TextField(
                controller: regController,
                decoration: InputDecoration(
                  labelText: 'Car Registration',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 20),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Start Time',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: () => _selectStartTime(context),
                    child: Text(selectedStartTime?.format(context) ?? 'Select Time'),
                  ),
                ],
              ),
              SizedBox(height: 20),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'End Time',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: () => _selectEndTime(context),
                    child: Text(selectedEndTime?.format(context) ?? 'Select Time'),
                  ),
                ],
              ),
              SizedBox(height: 20),
              TextField(
                controller: startdateController,
                decoration: InputDecoration(
                  labelText: 'Arrival Date YYYY/MM/DD',
                  border: OutlineInputBorder(),
                ),
                onTap: () => _selectstartDate(context),
                readOnly: true,
              ),
              SizedBox(height: 20),
              TextField(
                controller: enddateController,
                decoration: InputDecoration(
                  labelText: 'End Date YYYY/MM/DD',
                  border: OutlineInputBorder(),
                ),
                onTap: () => _selectendDate(context),
                readOnly: true,
              ),
              SizedBox(height: 20),
              Row(
                children: [
                  Checkbox(
                    value: blueBadgeHolder,
                    onChanged: (value) {
                      setState(() {
                        blueBadgeHolder = value!;
                      });
                    },
                  ),
                  RichText(
                    text: TextSpan(
                      text: 'I am a ',
                      style: TextStyle(
                        color: Colors.black,
                      ),
                      children: <TextSpan>[
                        TextSpan(
                          text: 'Blue Badge holder',
                          style: TextStyle(
                            color: Colors.blue,
                            decoration: TextDecoration.underline,
                          ),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              Navigator.pushNamed(context, '/terms_and_conditions');
                            },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
              Row(
                children: [
                  Checkbox(
                    value: agreeToTerms,
                    onChanged: (value) {
                      setState(() {
                        agreeToTerms = value!;
                      });
                    },
                  ),
                  RichText(
                    text: TextSpan(
                      text: 'I accept the ',
                      style: TextStyle(
                        color: Colors.black,
                      ),
                      children: <TextSpan>[
                        TextSpan(
                          text: 'Terms and Conditions',
                          style: TextStyle(
                            color: Colors.blue,
                            decoration: TextDecoration.underline,
                          ),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              Navigator.pushNamed(context, '/terms_and_conditions');
                            },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (agreeToTerms) {
                    DateTime selectedStartDateAndTime = DateTime(
                      selectedDate!.year,
                      selectedDate!.month,
                      selectedDate!.day,
                      selectedStartTime!.hour,
                      selectedStartTime!.minute,
                    );
                    DateTime selectedEndDateAndTime = DateTime(
                      selectedDate!.year,
                      selectedDate!.month,
                      selectedDate!.day,
                      selectedEndTime!.hour,
                      selectedEndTime!.minute,
                    );

                    sendDataToServer(
                      name: nameController.text,
                      email: emailController.text,
                      phone: phoneController.text,
                      reg: regController.text,
                      selectedStartDateAndTime: selectedStartDateAndTime.toString(),
                      selectedEndDateAndTime: selectedEndDateAndTime.toString(),
                      blueBadgeHolder: blueBadgeHolder,
                    );
                  } else {
                    print('Please agree to the terms before booking.');
                  }
                },
                child: Text('Book Now'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
