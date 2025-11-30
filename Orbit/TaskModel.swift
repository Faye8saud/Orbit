//
//  TaskModel.swift
//  Orbit
//
//  Created by Hissah Alohali on 09/06/1447 AH.
//
import SwiftData
import SwiftUI
import Foundation

@Model
class TaskModel: Identifiable {
    @Attribute(.unique) var id: UUID
    var name: String
    var type: String
    var desc: String
    var priority: Int   // 1 = low, 2 = medium, 3 = high
    var distance: Double
    var actionType: String   // example: "openProfile", "openTasks"
    var date: Date
    
    var icon: String {
        TaskHelpers.icon(for: type)
    }
    
    var taskColor: Color {
        TaskHelpers.color(for: type)
    }
    
    var size: Double {
        TaskHelpers.size(for: priority)
    }

    init(id: UUID = UUID(), name: String, type: String, desc: String, priority: Int,
         distance: Double = 160, actionType: String, date: Date) {
        self.id = id
        self.name = name
        self.type = type
        self.desc = desc
        self.priority = priority
        self.distance = distance
        self.actionType = actionType
        self.date = date
    }
}

