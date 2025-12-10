//
//  TaskHelpers.swift
//  Orbit
//
//  Centralized task configuration and utilities
//

import SwiftUI

struct TaskHelpers {
    
    // MARK: - Task Type Configuration
    
    struct TypeConfig {
        let id: String
        let icon: String
        let labelKey: String
        let color: Color
    }
    
    static let allTypes: [String: TypeConfig] = [
        "work": TypeConfig(id: "work", icon: "doc.fill", labelKey: "Task.work", color: .yellowc),
        "health": TypeConfig(id: "health", icon: "heart.text.clipboard.fill", labelKey: "Task.health", color: .darkpinkc),
        "personal": TypeConfig(id: "personal", icon: "person.fill", labelKey: "Task.personal", color: .pinkc),
        "home": TypeConfig(id: "home", icon: "house.fill", labelKey: "Task.home", color: .lightbluec),
        "other": TypeConfig(id: "other", icon: "ellipsis", labelKey: "Task.other", color: .lighghtGreenc)
    ]

    
    // MARK: - Helper Methods
    
    static func icon(for type: String) -> String {
        let normalized = type.lowercased().trimmingCharacters(in: .whitespacesAndNewlines)
        return allTypes[normalized]?.icon ?? "questionmark.circle"
    }

    static func color(for type: String) -> Color {
        let normalized = type.lowercased().trimmingCharacters(in: .whitespacesAndNewlines)
        return allTypes[normalized]?.color ?? .gray
    }

    static func size(for priority: Int) -> Double {
        switch priority {
        case 1: return 90
        case 2: return 90
        default: return 90
        }
    }
}
