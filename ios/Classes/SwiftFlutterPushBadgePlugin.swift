import Flutter
import UIKit

public class SwiftFlutterPushBadgePlugin: NSObject, FlutterPlugin {
  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "flutter_push_badge", binaryMessenger: registrar.messenger())
    let instance = SwiftFlutterPushBadgePlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    
  }
}
