//
//  OrbitApp.swift
//  Orbit
//
//  Created by Fay  on 19/11/2025.
//
import SwiftUI
import SwiftData
@main
struct MyApp: App {
    var body: some Scene {
        WindowGroup {
OnboardingView()
            // HomeView()
        }
        .modelContainer(for: TaskModel.self)
    }
}
