import Flutter
import UIKit
import GoogleMaps

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  private var isScreenRecordingBlocked = false
  private var screenRecordingAlert: UIAlertController?
  
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    GMSServices.provideAPIKey("AIzaSyDGt6Gd15T9xJtLexdiMb-l6nO86j3ZTqA")
    
    let controller = window?.rootViewController as! FlutterViewController
    let screenRecordingChannel = FlutterMethodChannel(
      name: "screen_recording_control",
      binaryMessenger: controller.binaryMessenger
    )
    
    screenRecordingChannel.setMethodCallHandler { [weak self] (call, result) in
      switch call.method {
      case "enableScreenRecordingBlock":
        self?.enableScreenRecordingBlock()
        result(nil)
      case "disableScreenRecordingBlock":
        self?.disableScreenRecordingBlock()
        result(nil)
      case "isScreenRecordingActive":
        let isActive = UIScreen.main.isCaptured
        result(isActive)
      default:
        result(FlutterMethodNotImplemented)
      }
    }
    
    GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
  
  private func enableScreenRecordingBlock() {
    if !isScreenRecordingBlocked {
      // On iOS, we can't completely block screen recording due to system limitations,
      // but we can add a notification observer to detect when screen recording starts
      NotificationCenter.default.addObserver(
        self,
        selector: #selector(screenRecordingDidChange),
        name: UIScreen.capturedDidChangeNotification,
        object: nil
      )
      isScreenRecordingBlocked = true
      
      // Check if screen recording is already active
      if UIScreen.main.isCaptured {
        screenRecordingDidChange()
      }
    }
  }
  
  private func disableScreenRecordingBlock() {
    if isScreenRecordingBlocked {
      NotificationCenter.default.removeObserver(
        self,
        name: UIScreen.capturedDidChangeNotification,
        object: nil
      )
      isScreenRecordingBlocked = false
      
      // Dismiss any existing alert
      if let alert = screenRecordingAlert {
        alert.dismiss(animated: true)
        screenRecordingAlert = nil
      }
    }
  }
  
  @objc private func screenRecordingDidChange() {
    if UIScreen.main.isCaptured {
      // Screen recording is active - show a warning to the user
      DispatchQueue.main.async { [weak self] in
        // Dismiss any existing alert first
        if let existingAlert = self?.screenRecordingAlert {
          existingAlert.dismiss(animated: false)
        }
        
        let alert = UIAlertController(
          title: "تم اكتشاف تسجيل الشاشة",
          message: "لا يُسمح بتسجيل الشاشة أثناء الدروس. يرجى إيقاف التسجيل للمتابعة.",
          preferredStyle: .alert
        )
        alert.addAction(UIAlertAction(title: "حسناً", style: .default) { _ in
          self?.screenRecordingAlert = nil
        })
        
        if let rootViewController = self?.window?.rootViewController {
          self?.screenRecordingAlert = alert
          rootViewController.present(alert, animated: true)
        }
      }
    } else {
      // Screen recording stopped - dismiss alert if present
      DispatchQueue.main.async { [weak self] in
        if let alert = self?.screenRecordingAlert {
          alert.dismiss(animated: true)
          self?.screenRecordingAlert = nil
        }
      }
    }
  }
}
