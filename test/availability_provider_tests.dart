import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fluttertooth/bluetooth_availability_screen.dart';

void main() {
  test('Provider should sink the value from the method channel', () {
    // Given
    final expectedBluetoothStatus = 'test_expectedBluetoothStatus';
    MethodChannel channel = const MethodChannel('flutter.getaround.com/bluetooth');
    // Register the mock handler.
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      if (methodCall.method == 'getBluetoothState') {
        // Return mocked value
        return expectedBluetoothStatus;
      } else {
        return null;
      }
    });
    final provider = BluetoothAvailabilityProvider();

    // When
    provider.fetch();

    // Then
    expect(provider.bluetoothState, emits(expectedBluetoothStatus));
  });
}