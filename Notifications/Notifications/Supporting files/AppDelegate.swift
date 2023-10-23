//
//  AppDelegate.swift
//  Notifications
//
//  Created by mac on 21.10.2023.
//  Copyright © 2023 Heorhii. All rights reserved.
//

import UIKit
import UserNotifications

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    let notificationCenter = UNUserNotificationCenter.current()


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        requestAuthorization()
        return true
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        UIApplication.shared.applicationIconBadgeNumber = 0
    }

    // Request permission to send notifications
    func requestAuthorization() {
        notificationCenter.requestAuthorization(options: [.alert, .badge, .sound]) { granted, error in
            print("Permission notifications: \(granted)")

            guard granted else { return }
            self.getNotificationsSettings()
        }
    }

    // Checking app settings for notifications
    func getNotificationsSettings() {
        notificationCenter.getNotificationSettings { settings in
            print("Notification settings: \(settings)")
        }
    }

    func sheduleNotification(notificationType: String) {

        let content = UNMutableNotificationContent()
        content.title = notificationType
        content.body = "This is example how to create: " + notificationType
        content.sound = UNNotificationSound.default
        content.badge = 1

        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
        let identifier = "Local Notification"

        let request = UNNotificationRequest(identifier: identifier, content: content, trigger: trigger)

        notificationCenter.add(request) { error in
            if let error = error {
                print("Error: ", error.localizedDescription)
            }
        }
    }
}

