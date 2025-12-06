//
//  mainHomeView.swift
//  Orbit
//
//  Created by Fay  on 27/11/2025.
//
import SwiftUI

struct mainHomeView: View {
    @State private var navigate = false
    @State private var showTaskSheet = false
    
    var body: some View {
        NavigationStack {
        ZStack {
            Color(.background)
                .ignoresSafeArea()
            
            // --------------------------------------------
            // TOP RIGHT BUTTON
            // --------------------------------------------
            VStack {
                HStack {
                    Spacer()
                    NavigationLink {
                        CalendarCarouselView(source: .mainHome)
                    } label: {
                        Image(systemName: "calendar")
                            .font(.system(size: 22, weight: .medium))
                            .foregroundColor(.white)
                            .frame(width: 55, height: 55)
                            .background(Color(.btn))
                            .clipShape(Circle())
                            .shadow(color: .black.opacity(0.25), radius: 6, x: 0, y: 4)
                    }
                    .padding(.trailing, 60)
                    .padding(.top, 24)
                }
                Spacer()
            }
            
            // --------------------------------------------
            // CENTER GLASS SEARCH BUTTON
            // --------------------------------------------
            VStack {
                Spacer().frame(height: 300)
                
                Button {
                    navigate = true
                } label: {
                    Image(systemName: "minus.magnifyingglass")
                        .font(.system(size: 30, weight: .medium))
                        .foregroundColor(Color.btn.opacity(0.8))
                        .frame(width: 150, height: 55)
                        .background(
                            RoundedRectangle(cornerRadius: 28)
                                .fill(.white.opacity(0.8))
                                .blur(radius: 0.5)
                        )
                        .glassEffect(.regular.tint(.lightyellow))
                        .shadow(color: .black.opacity(0.1), radius: 8)
                }
                
                Spacer()
            }
            
            // --------------------------------------------
            // BOTTOM HALF LARGE CIRCLE + TASK DETAILS
            // --------------------------------------------
            VStack {
                Spacer()
                
                VStack {
                    Spacer() // pushes everything up
                    
                    ZStack {
                        // BIG HALF CIRCLE
                        Circle()
                            .fill(
                                RadialGradient(
                                    gradient: Gradient(colors: [
                                        Color(.circleInner),
                                        Color(.circleOuter).opacity(0.3)
                                    ]),
                                    center: .center,
                                    startRadius: 20,
                                    endRadius: 400
                                )
                            )
                            .frame(width: 500, height: 550)
                            .blur(radius: 1)
                            .offset(y: 520) // push down so only top half is visible
                    }
                
                .edgesIgnoringSafeArea(.bottom)
                    
                    VStack(spacing: 18) {
                        
                        // BIG TASK ICON CIRCLE
                        Button {
                            showTaskSheet = true
                                   } label: {
                                       Circle()
                                           .fill(Color(.darkpinkc))
                                           .frame(width: 120, height: 120)
                                           .overlay(
                                               Image(systemName: "person.fill")
                                                   .font(.system(size: 40, weight: .medium))
                                                   .foregroundColor(.white)
                                           )
                                           .shadow(color: .black.opacity(0.25), radius: 8, x: 0, y: 6)
                                   }
                                   .offset(y: -60)
                        
                        Text("١٨ نوفمبر")
                            .font(.system(size: 30, weight: .medium))
                            .foregroundColor(Color.btn.opacity(0.8))
                            .offset(y: -50)
                        
                        Text("٤:٣٠ مساءً")
                            .font(.system(size: 20))
                            .foregroundColor(Color.btn)
                            .offset(y: -50)
                    }
                    .padding(.bottom, 50)
                }
            }
        }
        .sheet(isPresented: $showTaskSheet) {
            taskSheet()
                .presentationDetents([.large])  // custom height
                .presentationDragIndicator(.visible)
        }
        .navigationDestination(isPresented: $navigate) {
                    HomeView()
                }
        }
        
    }
    
}

#Preview {
    mainHomeView()
}

