import 'package:flutter/material.dart';

import 'bluetooth_availability_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fluttertooth',
      theme: ThemeData(
        primarySwatch: Colors.purple,
      ),
      home: BluetoothAvailabilityScreen(),
    );
  }
}