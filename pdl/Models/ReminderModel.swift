//
//  ReminderModel.swift
//  pdl
//
//

import Foundation
import SwiftUI


struct Reminder: Codable, Identifiable {
    var id: UUID
    let date: Date
    let isRemind: Bool
    let isRepeat: Repeat
    let title: String
}

enum Repeat: String, Equatable, CaseIterable, Codable {
    case Never = "Never"
    case Repeat = "Repeat"
    
    var localizedName: LocalizedStringKey { LocalizedStringKey(self.rawValue) }
}
