//
//  AppDelegate.swift
//  Color Change
//
//  Created by xr on 4/30/18.
//  Copyright © 2018 Josh. All rights reserved.
//

import UIKit
import UserNotifications

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        registerForPushNotifications()
        
        // save Device's default brightness value
        return true
    }
    
    func applicationDidEnterBackground(_ application: UIApplication) {
        let brightness_value = Helper.loadObjectDataToNSUserDefault(forKey: Global.BRIGHTNESS_VALUE) ?? UIScreen.main.brightness as NSObject
        Helper.setBrightness(value: brightness_value as! CGFloat)
    }
    
    
    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
        if var topController = UIApplication.shared.keyWindow?.rootViewController {
            while let presentedViewController = topController.presentedViewController {
                topController = presentedViewController
            }
            
            if (topController as! UINavigationController).viewControllers.last is HomeViewController {
                Helper.setBrightness(value: 1.0)
            }
            else {
                let brightness_value = UIScreen.main.brightness
                Helper.saveObjectDataToNSUserDefault(saveObject: brightness_value as NSObject, forKey: Global.BRIGHTNESS_VALUE)
            }
        }
        
        
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
        
        let brightness_value = Helper.loadObjectDataToNSUserDefault(forKey: Global.BRIGHTNESS_VALUE) ?? UIScreen.main.brightness as NSObject
        Helper.setBrightness(value: brightness_value as! CGFloat)
    }
    

    //MARK - Push notification
    func registerForPushNotifications() {
        UNUserNotificationCenter.current().delegate = self
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { (granted, error) in
            print("Permission granted: \(granted)")
            
            guard granted else {return}
            self.getNotificationSettings()
        }
    }
    
    func getNotificationSettings() {
        UNUserNotificationCenter.current().getNotificationSettings { (settings) in
            print("NotificationSettings \(settings)")
            
            guard settings.authorizationStatus == .authorized else { return }
            DispatchQueue.main.async {
                UIApplication.shared.registerForRemoteNotifications()
            }
        }
    }
    
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        let tokenParts = deviceToken.map { data -> String in
            return String(format: "%02.2hhx", data)
        }
        
        let token = tokenParts.joined()
        Helper.saveObjectDataToNSUserDefault(saveObject: token as NSObject, forKey: "device_token")
    }
    
    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        print("Failed to register: \(error)")
    }
    
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any]) {
        print("applicationIconBadgeNumber----- \(application.applicationIconBadgeNumber)")
    }
    
    func application(_ application: UIApplication, handleActionWithIdentifier identifier: String?, forRemoteNotification userInfo: [AnyHashable : Any], completionHandler: @escaping () -> Void) {
        print("kadjfaldkfjdfasdfjaldksfja")
    }
    
    
    func application(_ application: UIApplication, handleActionWithIdentifier identifier: String?, forRemoteNotification userInfo: [AnyHashable : Any], withResponseInfo responseInfo: [AnyHashable : Any], completionHandler: @escaping () -> Void) {
        print("127987419284712034138")
    }
    
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        if var topController = application.keyWindow?.rootViewController {
            while let presentedViewController = topController.presentedViewController {
                topController = presentedViewController
            }
            
            if topController is UINavigationController {
                topController = (topController as! UINavigationController).viewControllers.last!
            }
            
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: Global.COLOR_CHANGE), object: nil, userInfo: ["color": "#ffad34"])
            application.applicationIconBadgeNumber += 1
        }
    }
}

extension AppDelegate: UNUserNotificationCenterDelegate {
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        
        //https://www.raywenderlich.com/156966/push-notifications-tutorial-getting-started
        
        let userInfo = response.notification.request.content.userInfo
        print(userInfo)
        print("Push Notification")
        
        completionHandler()
    }
}
