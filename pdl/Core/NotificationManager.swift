//
//  NotificationManager.swift
//  pdl
//
//

import Foundation
import UserNotifications

class NotificationManager {
    
    static let instance = NotificationManager()
    let notificationCenter = UNUserNotificationCenter.current()
    
    func requestAuthorization() {
        let options: UNAuthorizationOptions = [.alert, .sound, .badge]
        UNUserNotificationCenter.current().requestAuthorization(options: options) { isSuccess, error in
            if let error = error {
                print("Notification Error: ", error.localizedDescription)
            } else {
                if isSuccess {
                    self.notificationCenter.getNotificationSettings { settings in
                        guard settings.authorizationStatus == .authorized else { return }
                        print(settings)
                    }
                }
            }
        }
    }
    
    
    func scheduleNotification(reminder: Reminder) {
        
        let content = UNMutableNotificationContent()
        content.title  = reminder.title.isEmpty ? "Reminder!" : reminder.title
        content.sound = .default
        content.badge = 1
        
        
        let comps = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute], from: reminder.date)
        
        let trigger = UNCalendarNotificationTrigger(dateMatching: comps, repeats: reminder.isRepeat == .Repeat ? true : false)
        let request = UNNotificationRequest(identifier: reminder.id.uuidString,
                                            content: content,
                                            trigger: trigger)
        
        if reminder.isRemind {
            notificationCenter.add(request) { error in
                if let error = error {
                    print("Add Notification Error: ", error.localizedDescription)
                }
            }
        }
    }
    
    
}

class NotificationManagerDelegate: NSObject, UNUserNotificationCenterDelegate {
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        completionHandler()
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.banner, .sound, .badge])
    }
}
