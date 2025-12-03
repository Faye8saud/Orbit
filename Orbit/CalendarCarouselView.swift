//
//  CalendarCarouselView.swift
//  Orbit
//
//  Created by Samar A on 10/06/1447 AH.
//

import SwiftUI

struct CalendarCarouselView: View {
    @State private var currentIndex: Int = 0
    @State private var showSheet: Bool = false
    @State private var showNotificationAlert: Bool = false
    @State private var navigateHome = false
    
    private let calendar = Calendar.current
    
    private var months: [Date] {
        let now = Date()
        return (0..<3).compactMap { offset in
            calendar.date(byAdding: .month, value: offset, to: now)
        }
    }
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color("background")
                    .ignoresSafeArea()
                
                VStack {
                    Spacer().frame(height: 80)
                    
                    TabView(selection: $currentIndex) {
                        ForEach(months.indices, id: \.self) { index in
                            MonthCard(
                                monthDate: months[index],
                                isCurrent: index == 0
                            )
                            .tag(index)
                        }
                    }
                    .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
                    .frame(height: 340)
                    
                    Spacer()
                    
                    HStack {
                        Spacer()
                        
                        Button {
                            showNotificationAlert = true
                        } label: {
                            ZStack {
                                Circle()
                                    .fill(Color("btnColor"))
                                    .frame(width: 90, height: 90)
                                    .shadow(color: Color("btnColor").opacity(0.25),
                                            radius: 10, x: 0, y: 2)
                                
                                Image(systemName: "plus")
                                    .font(.system(size: 30, weight: .bold))
                                    .foregroundColor(.white)
                            }
                        }
                        .padding(.trailing, 32)
                        .padding(.bottom, 40)
                    }
                }
                
                NavigationLink(
                    "",
                    destination: HomeView(),
                    isActive: $navigateHome
                )
                .hidden()
            }
            .sheet(isPresented: $showSheet) {
                sheetView()
            }
            .alert("Enable Notifications", isPresented: $showNotificationAlert) {
                Button("Yes") {
                    NotificationManager.shared.requestAuthorization()
                    showSheet = true
                }
                Button("Later", role: .cancel) {
                    showSheet = true
                }
            } message: {
                Text("We’ll remind you on the days you have tasks.")
            }
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button {
                        navigateHome = true
                    } label: {
                        HStack(spacing: 1) {
                            Image(systemName: "house.fill")
                            Text("Home")
                        }
                        .font(.system(size: 16, weight: .semibold))
                        .foregroundColor(Color("btnColor"))
                    }
                }
            }
        }
    }
}

#Preview {
    CalendarCarouselView()
}
