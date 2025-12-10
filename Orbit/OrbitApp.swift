//
//  OrbitApp.swift
//  Orbit
//
//  Created by Fay  on 19/11/2025.
import SwiftUI
import SwiftData
import UIKit

@main
struct OrbitApp: App {
    
//    init() {
//        UIView.appearance().overrideUserInterfaceStyle = .light
//    }
    
    @State private var showSplash = true
    
    var body: some Scene {
        WindowGroup {
            ZStack {
                if showSplash {
                    SplashView()
                        .onAppear {
                            DispatchQueue.main.asyncAfter(deadline: .now() + 1.4) {
                                withAnimation {
                                    showSplash = false
                                }
                            }
                        }
                } else {
                    OnboardingView()
                }
            }
//            .preferredColorScheme(.light)
        }
        .modelContainer(for: TaskModel.self)
    }
}
