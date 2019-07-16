import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

class BluetoothAvailabilityScreen extends StatefulWidget {
  final BluetoothAvailabilityProvider availabilityProvider =
      BluetoothAvailabilityProvider();

  @override
  _BluetoothAvailabilityScreenState createState() =>
      _BluetoothAvailabilityScreenState();
}

class _BluetoothAvailabilityScreenState
    extends State<BluetoothAvailabilityScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.refresh),
        onPressed: () => widget.availabilityProvider.fetch(),
      ),
      appBar: AppBar(
        title: Text('Fluttertooth'),
      ),
      body: Center(
        child: StreamBuilder(
            stream: widget.availabilityProvider.bluetoothState,
            builder: (context, AsyncSnapshot<String> bluetooth) {
              if (bluetooth.hasData) {
                return Text(bluetooth.data);
              }
              return Text(
                'Undefined',
              );
            }),
      ),
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

  String _state;

  // Method channel to fetch the state from the native
  static const _bluetoothMethodChannel =
      MethodChannel('flutter.getaround.com/bluetooth');

  Future<void> fetch() async {
    // Asynchronously invoking the method on the channel
    _state = await _bluetoothMethodChannel.invokeMethod('getBluetoothState');
    // Sinking the new state to the stream
    _streamController.sink.add(_state);
  }

  void dispose() {
    _streamController.close();
  }
}
