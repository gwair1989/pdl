//
//  ReminderViewModel.swift
//  pdl
//
//  Created by Oleksandr Khalypa on 05.09.2022.
//

import Foundation

class ReminderViewModel: ObservableObject, ProtocolsViewModel {
    
    @Published var reminders: [Reminder] = []
    
    private let remindersKeyName = "Reminders"
    
    init() {
        loadReminders()
        removeOldReminder()
    }
    
    func addReminder(reminder: Reminder) {
        reminders.append(reminder)
        NotificationManager.instance.scheduleNotification(reminder: reminder)
        saveReminders()
    }
    
    func removeReminder(uuid: UUID) {
        if let index = reminders.firstIndex(where: {$0.id == uuid}) {
            reminders.remove(at: index)
            saveReminders()
        }
    }
    
    func loadReminders() {
        if let savedReminders = UserDefaults.standard.object(forKey: remindersKeyName) as? Data {
            if let items = try? JSONDecoder().decode([Reminder].self, from: savedReminders) {
                self.reminders = items
            }
        }
    }
    
    func removeOldReminder() {
        let filterReminders = self.reminders.filter { remider in
            remider.date.timeIntervalSince1970 >= Date().timeIntervalSince1970
        }
        self.reminders = filterReminders
        saveReminders()
        
    }
    
    private func saveReminders() {
        if let encoded = try? JSONEncoder().encode(reminders) {
            UserDefaults.standard.set(encoded, forKey: remindersKeyName)
        }
    }
    
    
    func getCurrentDay(date: Date) -> String {
        let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.locale = Locale(identifier: "us")
        dateFormatterPrint.dateFormat = "E, d MMM yyyy, HH:mm"
        
        return dateFormatterPrint.string(from: date)
    }
    
    func getSeletedDay(date: Date) -> String {
        let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.locale = Locale(identifier: "us")
        dateFormatterPrint.dateFormat = "MMM d, yyyy"
        
        return dateFormatterPrint.string(from: date)
    }
    
    func getSeletedHours(date: Date) -> String {
        let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.locale = Locale(identifier: "us")
        dateFormatterPrint.dateFormat = "HH"
        
        return dateFormatterPrint.string(from: date)
    }
    
    func getSeletedMinute(date: Date) -> String {
        let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.locale = Locale(identifier: "us")
        dateFormatterPrint.dateFormat = "mm"
        
        return dateFormatterPrint.string(from: date)
    }
    
    func getDaysLeft(date: Date) -> Int {
        var daysLeft = 0
        let calendar = Calendar.current
        let currentDate = Date()
        
        let days = calendar.dateComponents([.day], from: currentDate, to: date)
        if let leftDay = days.day {
            daysLeft = leftDay
        }
        return daysLeft
    }
    
    
}
