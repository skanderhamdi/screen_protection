import Flutter
import UIKit

public class ScreenProtectionPlugin: NSObject, FlutterPlugin {

  public var textField: UITextField
  public var window: UIWindow
    
  init(window: UIWindow, textField: UITextField) {
      self.window = window
      self.textField = textField
  }

  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "screen_protection", binaryMessenger: registrar.messenger())
    let instance = ScreenProtectionPlugin(window: UIApplication.shared.delegate!.window!!, textField: UITextField())
    registrar.addMethodCallDelegate(instance, channel: channel)
    instance.startScreenProtection()
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    switch call.method {
        case "secureScreen":
            self.textField.isSecureTextEntry = true
            result(true)
        case "unsecureScreen":
            self.textField.isSecureTextEntry = false
            result(true)
        case "isScreenSecured":
            result(self.textField.isSecureTextEntry == true)
        case "toggleScreenSecurity":
            self.textField.isSecureTextEntry = !self.textField.isSecureTextEntry
            result(true)
        default:
            result(FlutterMethodNotImplemented)
    }
  }

  public func startScreenProtection() {
    if (!self.window.subviews.contains(textField)) {
       let view = UIView(frame: CGRect(x: 0, y: 0, width: textField.frame.self.width, height: textField.frame.self.height))
       self.window.addSubview(textField)
       self.window.layer.superlayer?.addSublayer(textField.layer)
       textField.layer.sublayers?.last!.addSublayer(self.window.layer)
       textField.leftView = view
       textField.leftViewMode = .always
    }
  }
}
