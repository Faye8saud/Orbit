//
//  AppDelegate.swift.swift
//  Orbit
//
//  Created by Samar A on 23/06/1447 AH.
//

import UIKit
import UserNotifications

final class AppDelegate: NSObject, UIApplicationDelegate, UNUserNotificationCenterDelegate {

    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {

        let center = UNUserNotificationCenter.current()
        center.delegate = self

        // اطلب الإذن أول ما يشتغل التطبيق
        NotificationManager.shared.requestAuthorizationIfNeeded()

        return true
    }

    // هذا يخلي الإشعار يطلع كبانر حتى لو التطبيق مفتوح
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                willPresent notification: UNNotification,
                                withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.banner, .sound, .badge])
    }
}

