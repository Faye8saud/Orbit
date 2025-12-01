//
//  Last.swift
//  Orbit
//
//  Created by Samar A on 09/06/1447 AH.
//

import SwiftUI

struct ColorTheme: Identifiable {
    let id = UUID()
    let left: Color
    let right: Color
}

struct LastOnboardingView: View {
    @Binding var selectedThemeIndex: Int
    let themes: [ColorTheme] = [
        ColorTheme(left: Color(red: 0.45, green: 0.05, blue: 0.23),
                   right: Color(red: 0.94, green: 0.72, blue: 0.70)),
        ColorTheme(left: Color(red: 0.06, green: 0.16, blue: 0.16),
                   right: Color(red: 0.77, green: 0.87, blue: 0.73)),
        ColorTheme(left: Color(red: 0.25, green: 0.43, blue: 0.60),
                   right: Color.white)
    ]
    
    var body: some View {
        VStack(spacing: 32) {
            
         
            Spacer(minLength: 20)
            
            VStack(spacing: 80) {
             Text("Choose your colors ")
                    .font(.system(size: 25, weight: .bold))
                 
                
                VStack(spacing: 50) {
                    ForEach(themes.indices, id: \.self) { index in
                        ColorOptionRow(
                            leftColor: themes[index].left,
                            rightColor: themes[index].right,
                            isSelected: selectedThemeIndex == index
                        )
                        .onTapGesture {
                            selectedThemeIndex = index
                        }
                    }
                }
            }
            .padding(.horizontal, 30)
            Spacer()
            
        }
    }
    
    struct ColorOptionRow: View {
        let leftColor: Color
        let rightColor: Color
        let isSelected: Bool
        
        var body: some View {
            ZStack(alignment: .trailing) {
                Capsule()
                    .fill(Color.clear)
                    .frame(height: 40)
                    .overlay(
                        HStack(spacing: 0) {
                            leftColor
                            rightColor
                        }
                            .clipShape(Capsule())
                    )
                    .overlay(
                        Capsule()
                            .stroke(isSelected ? Color.green : Color.clear, lineWidth: 3)
                    )
                
                if isSelected {
                    ZStack {
                        Circle()
                            .fill(Color.green)
                            .frame(width: 30, height: 30)
                        Image(systemName: "checkmark")
                            .font(.system(size: 16, weight: .bold))
                            .foregroundColor(.white)
                        
                        
                    }

                }
                
            }
        
            
        }
    }
}
#Preview {
    OnboardingView()
}
