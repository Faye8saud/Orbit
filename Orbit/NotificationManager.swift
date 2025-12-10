//
//  NotificationManager.swift
//  Orbit
//
//  Created by Samar A on 11/06/1447 AH.
//

import Foundation
import UserNotifications

class NotificationManager {
    static let shared = NotificationManager()
    
    private init() {}
    
    /// يطلب إذن النوتيفكيشن مرة وحدة بس
    func requestAuthorizationIfNeeded() {
        let key = "didAskForNotifications"
        let didAskBefore = UserDefaults.standard.bool(forKey: key)
        
        guard !didAskBefore else {
            print("🔔 Already asked for notifications before")
            return
        }
        
        UNUserNotificationCenter.current().requestAuthorization(
            options: [.alert, .sound, .badge]
        ) { granted, error in
            if let error = error {
                print("❌ Notification error: \(error.localizedDescription)")
            } else {
                print("✅ Notifications granted: \(granted)")
                UserDefaults.standard.set(true, forKey: key)
            }
        }
    }
    
    /// تذكير الساعة 9 صباحًا في اليوم اللي فيه المهمة
    func scheduleTaskReminder(taskName: String, date: Date) {
        let center = UNUserNotificationCenter.current()
        
        // أول شيء نتأكد إن عندنا إذن
        center.getNotificationSettings { settings in
            guard settings.authorizationStatus == .authorized || settings.authorizationStatus == .provisional else {
                print("❌ Notifications not allowed by user")
                return
            }
            
            let calendar = Calendar.current
            
            // نحدد 9 صباحًا في نفس اليوم حق المهمة
            var components = calendar.dateComponents([.year, .month, .day], from: date)
            components.hour = 9
            components.minute = 0
            
            guard let reminderDate = calendar.date(from: components) else {
                print("❌ Failed to build reminder date")
                return
            }
            
            // لو 9 صباح اليوم هذا عدّت، بنطنش التذكير عشان ما يكون في الماضي
            if reminderDate <= Date() {
                print("⚠️ 9am for this day is already in the past, will not schedule notification")
                return
            }
            
            let triggerComponents = calendar.dateComponents(
                [.year, .month, .day, .hour, .minute],
                from: reminderDate
            )
            
            let trigger = UNCalendarNotificationTrigger(dateMatching: triggerComponents, repeats: false)
            
            let content = UNMutableNotificationContent()
            content.title = "Task Reminder"
            content.body = "You have a task today: \(taskName)"
            content.sound = .default
            
            let request = UNNotificationRequest(
                identifier: UUID().uuidString,
                content: content,
                trigger: trigger
            )
            
            center.add(request) { error in
                if let error = error {
                    print("❌ Failed to schedule: \(error.localizedDescription)")
                } else {
                    print("✅ Notification scheduled for \(reminderDate) for task: \(taskName)")
                }
            }
        }
    }
}
