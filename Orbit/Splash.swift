//
//  splash.swift
//  Orbit
//
//  Created by Samar A on 17/06/1447 AH.
//

import SwiftUI

struct SplashView: View {
    @State private var animate = false

    var body: some View {
        ZStack {
            Color("background")
                .ignoresSafeArea()

            Image("logo")
                .resizable()
                .scaledToFit()
                .frame(width: 180)
                .opacity(animate ? 1 : 0)
                .scaleEffect(animate ? 1 : 0.85)
                .animation(.easeOut(duration: 0.6), value: animate)
        }
        .onAppear {
            animate = true
        }
    }
}

#Preview {
    SplashView()
}

