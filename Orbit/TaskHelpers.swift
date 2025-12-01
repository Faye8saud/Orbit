//
//  TaskHelpers..swift
//  Orbit
//
//  Created by Hissah Alohali on 09/06/1447 AH.
//

import SwiftUI

struct TaskHelpers {
    static func icon(for type: String) -> String {
        switch type {
        case "work": return "doc.fill"
        case "home": return "home.fill"
        case "personal": return "person.crop.circle.fill"
        case "meeting": return "person.3.fill"
        case "other": return "circle.fill"
        default: return "questionmark.circle"
        }
    }

    static func color(for type: String) -> Color {
        switch type {
        case "work": return Color(.darkpinkc)
        case "home": return Color(.btn)
        case "personal": return Color(.pinkc)
        case "meeting": return Color(.yellowc)
        case "other": return Color(.lighghtGreenc)
        default: return .gray
        }
    }

    static func size(for priority: Int) -> Double {
        switch priority {
        case 1: return 60
        case 2: return 80
        case 3: return 110
        default: return 60
        }
    }
}
