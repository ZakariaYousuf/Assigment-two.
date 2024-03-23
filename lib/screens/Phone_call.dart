import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text("Make Phone Calls"),
          centerTitle: true,
          backgroundColor: Colors.teal[700],
        ),
        body: PhoneCallScreen(),
      ),
    );
  }
}

class PhoneCallScreen extends StatelessWidget {
  final TextEditingController _phoneNumberController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextFormField(
            style: TextStyle(fontSize: 17.0, color: Colors.black),
            decoration: InputDecoration(
              prefixIcon: Icon(Icons.phone),
              labelText: "Enter Phone Number",
            ),
            keyboardType: TextInputType.phone,
            controller: _phoneNumberController,
            validator: (val) {
              return RegExp(
                "^[0-9]{4} [0-9]{7}",
              ).hasMatch(val!)
                  ? null
                  : 'Format: XXXX XXXXXXX';
            },
          ),
          SizedBox(height: 20.0),
          ElevatedButton(
            onPressed: () => _makePhoneCall(context),
            child: Text('Make Call'),
          ),
        ],
      ),
    );
  }

  _makePhoneCall(BuildContext context) {
    final String phoneNumber = _phoneNumberController.text.trim();
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Make Phone Call'),
        content: Text('Dial $phoneNumber?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(context),
            child: Text('OK'),
          ),
        ],
      ),
    );
  }
}
