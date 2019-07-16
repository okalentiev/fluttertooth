package com.example.fluttertooth

import android.bluetooth.BluetoothAdapter
import android.os.Bundle
import io.flutter.app.FlutterActivity
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugins.GeneratedPluginRegistrant

class MainActivity : FlutterActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)

        MethodChannel(flutterView, "flutter.getaround.com/bluetooth").setMethodCallHandler { call, result ->
            if (call.method == "getBluetoothState") {
                result.success(getBluetoothState())
            } else {
                result.notImplemented()
            }
        }

        GeneratedPluginRegistrant.registerWith(this)
    }

    private fun getBluetoothState(): String? {
        val bluetoothState: String?
        val mBluetoothAdapter = BluetoothAdapter.getDefaultAdapter()
        when {
            mBluetoothAdapter == null -> {
                bluetoothState = "Not Supported"
            }
            mBluetoothAdapter.state == BluetoothAdapter.STATE_ON -> {
                bluetoothState = "Turned On"
            }

            mBluetoothAdapter.state == BluetoothAdapter.STATE_OFF -> {
                bluetoothState = "Turned Off"
            }

            else -> {
                bluetoothState = "Unknown"
            }
        }
        return bluetoothState
    }
}
