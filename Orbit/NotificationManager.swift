//
//  NotificationManager.swift
//  Orbit
//
//  Created by Samar A on 11/06/1447 AH.
//

import Foundation
import UserNotifications

final class NotificationManager {
    static let shared = NotificationManager()
    private init() {}
    
    func requestAuthorizationIfNeeded() {
        let key = "didAskForNotifications"
        let didAskBefore = UserDefaults.standard.bool(forKey: key)
        
        // إذا سبق طلبنا، خلاص
        guard !didAskBefore else {
            print("🔔 Already asked for notifications before")
            return
        }
        
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { granted, error in
            if let error = error {
                print("❌ Notification error: \(error.localizedDescription)")
                return
            }
            
            print("✅ Notifications granted: \(granted)")
            
            // مهم: نخزن "سألنا" بغض النظر عن granted عشان ما نزعج المستخدم
            // لكن لا تمنعين نفسك من تفعيلها لاحقاً: المستخدم يقدر يغيرها من الإعدادات
            UserDefaults.standard.set(true, forKey: key)
        }
    }
    
    func scheduleTaskReminder(taskId: String, taskName: String, date: Date) {
        let center = UNUserNotificationCenter.current()
        
        center.getNotificationSettings { settings in
            guard settings.authorizationStatus == .authorized || settings.authorizationStatus == .provisional else {
                print("❌ Notifications not allowed. status=\(settings.authorizationStatus.rawValue)")
                return
            }
            
            let calendar = Calendar.current
            
            var components = calendar.dateComponents([.year, .month, .day], from: date)
            components.hour = 9
            components.minute = 0
            
            guard let reminderDate = calendar.date(from: components) else {
                print("❌ Failed to build reminder date")
                return
            }
            
            let finalReminderDate: Date
            if reminderDate <= Date() {
                finalReminderDate = Date().addingTimeInterval(10)
                print("⚠️ Reminder time is past; scheduling test notification in 10 seconds")
            } else {
                finalReminderDate = reminderDate
            }
            
            let trigger = UNTimeIntervalNotificationTrigger(
                timeInterval: max(5, finalReminderDate.timeIntervalSinceNow),
                repeats: false
            )
            
            let content = UNMutableNotificationContent()
            content.title = "Task Reminder"
            content.body
        }
    }
            }
