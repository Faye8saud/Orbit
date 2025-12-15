//
//  OrbitApp.swift
//  Orbit
//
//  Created by Fay  on 19/11/2025.
import SwiftUI
import SwiftData

@main
struct OrbitApp: App {
    @State private var showSplash = true
    @AppStorage("didFinishOnboarding") private var didFinishOnboarding = false

    var body: some Scene {
        WindowGroup {
            ZStack {
                if showSplash {
                    SplashView()
                } else {
                    if didFinishOnboarding {
                        mainHomeView()
                    } else {
                        OnboardingView()
                    }
                }
            }
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.4) {
                    withAnimation(.easeInOut(duration: 0.25)) {
                        showSplash = false
                    }
                }
            }
        }
        .modelContainer(for: TaskModel.self)
    }
}

