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
    
    func requestAuthorization() {
        UNUserNotificationCenter.current()
            .requestAuthorization(options: [.alert, .badge, .sound]) { granted, error in
                if let error = error {
                    print("Notification error:", error)
                } else {
                    print("Notifications granted:", granted)
                }
            }
    }
    
    func scheduleTaskNotification(taskName: String, taskDate: Date) {
        let content = UNMutableNotificationContent()
        content.title = "📌 Reminder"
        content.body  = "You have a task: \(taskName)"
        content.sound = .default
        
        let calendar = Calendar.current
        
        guard let notifyDate = calendar.date(byAdding: .day, value: -1, to: taskDate) else {
            return
        }
        
        var comps = calendar.dateComponents([.year, .month, .day], from: notifyDate)
        comps.hour = 20
        comps.minute = 0
        
        let trigger = UNCalendarNotificationTrigger(dateMatching: comps, repeats: false)
        
        let request = UNNotificationRequest(
            identifier: UUID().uuidString,
            content: content,
            trigger: trigger
        )
        
        UNUserNotificationCenter.current().add(request) { error in
            if let error = error {
                print("Failed to schedule:", error)
            } else {
                print("Notification scheduled for", comps)
            }
        }
    }
}
