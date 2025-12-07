//
//  CalendarCarouselView.swift
//  Orbit
//
//  Created by Samar A on 10/06/1447 AH.
//
import SwiftUI
import SwiftData

struct CalendarCarouselView: View {
    @Query(sort: \TaskModel.date) private var tasks: [TaskModel]
    
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
                    Spacer().frame(height: 150)
                    
                    TabView(selection: $currentIndex) {
                        ForEach(months.indices, id: \.self) { index in
                            MonthCard(
                                monthDate: months[index],
                                isCurrent: index == currentIndex,
                                tasks: tasks
                            )
                            .tag(index)
                        }
                    }
                    .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
                    .frame(height: 340)
                    .padding(.horizontal, 16)
                    
                    HStack(spacing: 8) {
                        ForEach(months.indices, id: \.self) { index in
                            Circle()
                                .fill(index == currentIndex ? Color("btnColor") : Color("btnColor").opacity(0.25))
                                .frame(width: index == currentIndex ? 10 : 6,
                                       height: index == currentIndex ? 10 : 6)
                                .animation(.easeInOut(duration: 0.2), value: currentIndex)
                        }
                    }
                    .padding(.top, 8)
                    
                    Spacer()
                    
                    HStack {
                        Spacer()
                        NavigationLink(
                            "",
                            destination: HomeView(),
                            isActive: $navigateHome
                        )
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
                
                }
            }
        }
    }
}

#Preview {
    CalendarCarouselView()
        .modelContainer(for: TaskModel.self)
}
