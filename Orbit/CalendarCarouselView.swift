//
//  CalendarCarouselView.swift
//  Orbit
//
//  Created by Samar A on 10/06/1447 AH.
//

import SwiftUI

enum CalendarSource {
    case home
    case mainHome
}
struct CalendarCarouselView: View {
    let source: CalendarSource
    
    @State private var currentIndex: Int = 0
    @State private var showSheet: Bool = false
    @State private var showNotificationAlert: Bool = false
    @State private var navigateHome = false
    @State private var navigateMainHome = false
    
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
                    Spacer().frame(height: 100)
                    
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
                
                // نخلي النافيقيشن جزء من نفس الـ ZStack
                NavigationLink(
                    "",
                    destination: HomeView(),
                    isActive: $navigateHome
                )
                .hidden()
                NavigationLink("",
                               destination: mainHomeView(),
                               isActive: $navigateMainHome)   // 👈 NEW
                .hidden()
                
            }
            .sheet(isPresented: $showSheet) {
                sheetView(navigateHome: $navigateHome)
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
                        switch source {
                        case .home:
                            navigateHome = true
                        case .mainHome:
                            navigateMainHome = true
                        }
                    } label: {
                        Image(systemName: "chevron.left")
                            .font(.system(size: 18, weight: .semibold))
                            .foregroundColor(Color("btnColor"))
                            .padding(8)
                            .background(Color.white)
                            .clipShape(Capsule())
                            .shadow(radius: 2)
                    }
                }
            }
        }
    }
    
    // 👇 THIS MUST BE OUTSIDE THE VIEW
    struct CalendarCarouselView_Previews: PreviewProvider {
        static var previews: some View {
            NavigationStack {
                CalendarCarouselView(source: .home)
            }
        }
    }
}
