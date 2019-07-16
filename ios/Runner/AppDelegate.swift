import UIKit
import Flutter
import CoreBluetooth

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
    var bluetoothPeripheralManager: CBCentralManager?
    var bluetoothState: String?
    override func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        let options = [CBCentralManagerOptionShowPowerAlertKey: false]
        bluetoothPeripheralManager = CBCentralManager(delegate: self, queue: nil, options: options)
        
        let controller : FlutterViewController = window?.rootViewController as! FlutterViewController
        let bluetoothChannel = FlutterMethodChannel(name: "flutter.getaround.com/bluetooth",
                                                    binaryMessenger: controller)
        bluetoothChannel.setMethodCallHandler { (call, result) in
            if (call.method == "getBluetoothState") {
                result(self.bluetoothState)
            } else {
                result(FlutterMethodNotImplemented)
            }
        }
        
        GeneratedPluginRegistrant.register(with: self)
        return super.application(application, didFinishLaunchingWithOptions: launchOptions)
    }
}

extension AppDelegate: CBCentralManagerDelegate {
    func centralManagerDidUpdateState(_ central: CBCentralManager) {
        switch central.state {
        case .poweredOn:
            bluetoothState = "Turned On"
        case .poweredOff:
            bluetoothState = "Turned Off"
        case .resetting:
            bluetoothState = "Resetting"
        case .unauthorized:
            bluetoothState = "Not Authorized"
        case .unsupported:
            bluetoothState = "Not Supported"
        case .unknown:
            bluetoothState = "Unknown"
        default:
            break
        }
    }
}
