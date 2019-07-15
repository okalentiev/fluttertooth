import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class BluetoothAvailabilityScreen extends StatefulWidget {
  final BluetoothAvailabilityProvider availabilityProvider = BluetoothAvailabilityProvider();

  @override
  _BluetoothAvailabilityScreenState createState() =>
      _BluetoothAvailabilityScreenState();
}

class _BluetoothAvailabilityScreenState extends State<BluetoothAvailabilityScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Fluttertooth'),
      ),
      body: Center(child: StreamBuilder(stream: widget.availabilityProvider.bluetoothState, builder: (context, AsyncSnapshot<String> bluetooth) {
        if (bluetooth.hasData) {
          return Text(bluetooth.data);
        }
        return Text('Undefined',);
      }),),
    );
  }

  @override
  void dispose() {
    widget.availabilityProvider.dispose();
    super.dispose();
  }
}

class BluetoothAvailabilityProvider {
  // We are using stream to not trigger the redraw of the whole screen
  // and only propagate the change to the status title
  final _streamController = StreamController<String>.broadcast();
  Stream<String> get bluetoothState => _streamController.stream;

  void dispose() {
    _streamController.close();
  }
}