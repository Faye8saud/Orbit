//
//  homeView.swift
//  Orbit
//
//  Created by Fay  on 25/11/2025.
//


import SwiftUI

struct MenuItem: Identifiable {
    let id = UUID()
    let icon: String
    let color: Color
    let size: CGFloat
    let distance: CGFloat
    let action: () -> Void
}


struct CircularMenuView: View {
    let items: [MenuItem]

    var body: some View {
        ZStack {
            ForEach(Array(items.enumerated()), id: \.element.id) { index, item in
                let angle = Angle.degrees(Double(index) / Double(items.count) * 360)

                Button(action: item.action) {
                    ZStack {
                        Circle()
                            .fill(item.color)
                            .frame(width: item.size, height: item.size)

                        Image(systemName: item.icon)
                            .foregroundColor(.white)
                            .font(.system(size: item.size * 0.28, weight: .bold))
                    }
                }
                .offset(
                    x: cos(CGFloat(angle.radians)) * item.distance,
                    y: sin(CGFloat(angle.radians)) * item.distance
                )
            }
        }
    }
}

struct HomeView: View {
    @State private var showSheet = false
    
    let menuItems: [MenuItem] = [

          MenuItem(
              icon: "house.fill",
              color: Color(.pinkc),
              size: 60,
              distance: 160
          ) { print("Home") },

          MenuItem(
              icon: "person.fill",
              color: Color(.lightbluec),
              size: 80,
              distance: 160
          ) { print("Profile 1") },

          MenuItem(
              icon: "person.3.fill",
              color: Color(.darkpinkc),
              size: 110,
              distance: 160
          ) { print("Group") },

          MenuItem(
              icon: "doc.fill",
              color: Color(.yellowc),
              size: 60,
              distance: 160
          ) { print("Documents") },

          MenuItem(
              icon: "person.crop.circle.fill",
              color: Color(.pinkc),
              size: 80,
              distance: 160
          ) { print("Profile 2") }
      ]

        
    var body: some View {
        ZStack {
            Color(.background)
                .ignoresSafeArea()
            
            // top calender button
            VStack {
                    HStack {
                        Spacer()

                        Button(action: {
                           //action
                        }) {
                            Image(systemName: "calendar")
                                .font(.system(size: 22, weight: .bold))
                                .foregroundColor(.white)
                                .padding(16)
                                .glassEffect(.regular.tint(.btn).interactive())
                                .clipShape(Circle())
                                .shadow(color: .black.opacity(0.25), radius: 4, x: 0, y: 2)
                        }
                        .padding(.top, 20)
                        .padding(.trailing, 20)
                    }
                    Spacer()
                }

            
            // Center circle
            ZStack {
                Circle()
                    .fill(
                        RadialGradient(
                            gradient: Gradient(colors: [
                                Color(.circleInner).opacity(1),
                                Color(.circleOuter).opacity(0.2),
                                Color(.circleOuter).opacity(0.2)
                            ]),
                            center: .center,
                            startRadius: 20,
                            endRadius: 200
                        )
                    )
                    .frame(width: 300, height: 300)
                    .blur(radius: 6)
                
             
                Circle()
                    .fill(
                        LinearGradient(
                            colors: [
                                Color(.circleInner).opacity(0.65),
                                Color(.circleOuter).opacity(0.55)
                            ],
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                    )
                    .frame(width: 330, height: 330)
                    .shadow(color: .black.opacity(0.2), radius: 12, x: 4, y: 8)
                
                    .blur(radius: 1)
                
                Text("١٨ نوفمبر")
                    .font(.system(size: 32, weight: .medium))
                    .foregroundColor(Color.black.opacity(0.7))
                
                // Circular menu buttons
                CircularMenuView(items: menuItems)
            }
            
            // bottom plus button
            VStack {
                Spacer()
                HStack {
                    Spacer()
                    
                    Button(action: {
                        showSheet = true
                    }) {
                        Image(systemName: "plus")
                            .font(.system(size: 22, weight: .bold))
                            .foregroundColor(.white)
                            .padding(20)
                            .glassEffect(.regular.tint(.btn).interactive())
                            .clipShape(Circle())
                            .shadow(color: .black.opacity(0.3), radius: 6, x: 0, y: 4)
                    }
                    .padding(.trailing, 20)
                    .padding(.bottom, 30)
                }
            }
        }
        .sheet(isPresented: $showSheet) {
            sheetView()
                .presentationDetents([.large])  // custom height
                .presentationDragIndicator(.visible)
        }
    }
    
}


#Preview {
    HomeView()
}
