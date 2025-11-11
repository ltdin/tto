import UIKit
import Flutter
import Firebase
import SmartPush
import smartech_base
import Smartech
import UserNotifications
import UserNotificationsUI

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate, SmartechDelegate {
    
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
     
      
    // Use Firebase library to configure APIs
    FirebaseApp.configure()
    
    // User Smartech
    Smartech.sharedInstance().initSDK(with: self, withLaunchOptions: launchOptions)
    // Smartech.sharedInstance().setDebugLevel(.verbose)
    Smartech.sharedInstance().trackAppInstallUpdateBySmartech()
    SmartPush.sharedInstance().registerForPushNotificationWithDefaultAuthorizationOptions()
      
    GeneratedPluginRegistrant.register(with: self)
    UNUserNotificationCenter.current().delegate = self
      
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
    
    override func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        
      SmartPush.sharedInstance().didRegisterForRemoteNotifications(withDeviceToken: deviceToken)
      // print("\n----------- deviceToken : \(deviceToken.description)")
    
    }
    
    override func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
      SmartPush.sharedInstance().didFailToRegisterForRemoteNotificationsWithError(error)
    }
    
    //MARK:- UNUserNotificationCenterDelegate Methods
    override func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
      SmartPush.sharedInstance().willPresentForegroundNotification(notification)
      completionHandler([.alert, .badge, .sound])
    }
        
    override func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
      NSLog("Call userNotificationCenter")
      SmartPush.sharedInstance().didReceive(response)
      
      completionHandler()
    }
    
    
    func handleDeeplinkAction(withURLString deeplinkURLString: String, andNotificationPayload notificationPayload: [AnyHashable : Any]?) {
        // SMT deeplink native callback
        SmartechBasePlugin.handleDeeplinkAction(deeplinkURLString, andCustomPayload: notificationPayload)
    }

}


