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
    
      func requestAuthorization() {
        UNUserNotificationCenter.current().requestAuthorization(
            options: [.alert, .sound, .badge]
        ) { granted, error in
            if let error = error {
                print("Notification error: \(error.localizedDescription)")
            } else {
                print("Notifications granted: \(granted)")
            }
        }
    }
    
    // جدولة تنبيه لليوم اللي فيه مهمة
    func scheduleTaskReminder(taskName: String, date: Date) {
        let content = UNMutableNotificationContent()
        content.title = "Task Reminder"
        content.body = "You have a task today: \(taskName)"
        content.sound = .default
        
        // نخلي التنبيه مثلاً الساعة 9 الصباح في نفس اليوم
        var components = Calendar.current.dateComponents([.year, .month, .day], from: date)
        components.hour = 9
        components.minute = 0
        
        let trigger = UNCalendarNotificationTrigger(dateMatching: components, repeats: false)
        
        let request = UNNotificationRequest(
            identifier: UUID().uuidString,
            content: content,
            trigger: trigger
        )
        
        UNUserNotificationCenter.current().add(request) { error in
            if let error = error {
                print("Failed to schedule: \(error.localizedDescription)")
            }
        }
    }
}
