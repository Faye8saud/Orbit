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
        let label: String
        let color: Color
    }
    
    static let allTypes: [String: TypeConfig] = [
        "work": TypeConfig(id: "work", icon: "doc.fill", label: "عمل", color: .darkpinkc),
        "meeting": TypeConfig(id: "meeting", icon: "person.3.fill", label: "اجتماع", color: .yellowc),
        "personal": TypeConfig(id: "personal", icon: "person.fill", label: "شخصي", color: .pinkc),
        "home": TypeConfig(id: "home", icon: "house.fill", label: "منزل", color: .btn),
        "other": TypeConfig(id: "other", icon: "ellipsis", label: "اخرى", color: .lighghtGreenc)
    ]
    
    // MARK: - Helper Methods
    
    static func icon(for type: String) -> String {
        allTypes[type]?.icon ?? "questionmark.circle"
    }

    static func color(for type: String) -> Color {
        allTypes[type]?.color ?? .gray
    }

    static func size(for priority: Int) -> Double {
        switch priority {
        case 1: return 95
        case 2: return 65
        default: return 45
        }
    }
}
