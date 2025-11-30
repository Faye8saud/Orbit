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
        case "work": return "briefcase.fill"
        case "study": return "book.fill"
        default: return "questionmark.circle"
        }
    }

    static func color(for type: String) -> Color {
        switch type {
        case "work": return .blue
        case "study": return .green
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
