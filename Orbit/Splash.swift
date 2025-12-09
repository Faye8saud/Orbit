//
//  splash.swift
//  Orbit
//
//  Created by Samar A on 17/06/1447 AH.
//

import SwiftUI

struct SplashView: View {
    @State private var isActive = false
    
    var body: some View {
        ZStack {
            Color("background")
                .ignoresSafeArea()
            
              Image("logo")
                .resizable()
                .scaledToFit()
                .frame(width: 180)
                .opacity(isActive ? 1 : 0)
                .scaleEffect(isActive ? 1 : 0.8)
                .animation(.easeOut(duration: 0.6), value: isActive)
        }
        .onAppear {
            isActive = true
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                withAnimation {
                    isActive = true
                }
            }
        }
    }
}
