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

        notificationCenter.delegate = self
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

    func scheduleNotification(notificationType: String) {

        let identifier = "Local Notification"
        let userAction = "User Action"

        let content = UNMutableNotificationContent()
        content.title = notificationType
        content.body = "This is example how to create: " + notificationType
        content.sound = UNNotificationSound.default
        content.badge = 1
        content.categoryIdentifier = userAction

        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)

        let request = UNNotificationRequest(identifier: identifier, content: content, trigger: trigger)

        notificationCenter.add(request) { error in
            if let error = error {
                print("Error: ", error.localizedDescription)
            }
        }

        let snoozeAction = UNNotificationAction(identifier: "Snooze", title: "Snooze")
        let deleteAction = UNNotificationAction(identifier: "Delete", title: "Delete", options: [.destructive])

        let category = UNNotificationCategory(identifier: userAction, actions: [snoozeAction, deleteAction], intentIdentifiers: [])
        notificationCenter.setNotificationCategories([category])

    }
}

extension AppDelegate: UNUserNotificationCenterDelegate {

    // Notification while the application is active
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {

        completionHandler([.sound, .banner])
    }

    // Processing an action in response to a notification
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {

        if response.notification.request.identifier == "Local Notification" {
            print("Handling notification with the Local Notification Identifire")
        }

        switch response.actionIdentifier {
        case UNNotificationDismissActionIdentifier:
            print("Dissmiss action")
        case UNNotificationDefaultActionIdentifier:
            print("Default")
        case "Snooze":
            print("Snooze")
            scheduleNotification(notificationType: "Reminder")
        case "Delete":
            print("Delete")
        default:
            print("Unknown action")
        }

        completionHandler()
    }
}
