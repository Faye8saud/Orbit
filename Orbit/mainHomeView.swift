//
//  mainHomeView.swift
//  Orbit
//
//  Created by Fay  on 27/11/2025.
//
import SwiftUI
import SwiftData

struct mainHomeView: View {
    @State private var navigate = false
    @State private var addTaskSheet = false
    @State private var selectedTask: TaskModel? = nil

    @Environment(\.modelContext) private var context
    @Query(sort: \TaskModel.date) private var allTasks: [TaskModel]

    // MARK: - Find next upcoming task
    private var nextTask: TaskModel? {
        let now = Date()
        let futureTasks = allTasks.filter { $0.date.timeIntervalSince(now) >= 0 }
        return futureTasks.min(by: { $0.date < $1.date })
    }
    
    private var todaysTasks: [TaskModel] {
        let calendar = Calendar.current
        return allTasks.filter { calendar.isDate($0.date, inSameDayAs: Date()) }
    }
    
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
                       CalendarCarouselView()
                    } label: {
                        Image(systemName: "calendar")
                            .font(.system(size: 22, weight: .medium))
                            .foregroundColor(.white)
                            .frame(width: 55, height: 55)
                            .background(Color(.btn))
                            .clipShape(Circle())
                            .shadow(color: .black.opacity(0.25), radius: 6, x: 0, y: 4)
                    }
                    .padding(.trailing, 70)
                    .padding(.top, 24)
                    .offset(y: 20)
                }
                Spacer()
            }
            
            // --------------------------------------------
            // CENTER GLASS SEARCH BUTTON
            // --------------------------------------------
            VStack {
                Spacer().frame(height: 300)
                if !todaysTasks.isEmpty {
                    Button { navigate = true } label: {
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
                }

                Spacer()
            }
            
            // --------------------------------------------
            // BOTTOM CIRCLE + NEXT TASK OR PLUS BUTTON
            // --------------------------------------------
            VStack {
                Spacer()
                VStack {
                    Spacer()

                    ZStack {
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
                            .offset(y: 520)
                    }
                    .edgesIgnoringSafeArea(.bottom)

                    VStack(spacing: 18) {

                        // ------------------------------------------------
                        // CONDITIONAL BUTTON (next task OR plus button)
                        // ------------------------------------------------
                        if let task = nextTask {
                            Button {
                                selectedTask = task
                            } label: {
                                ZStack {
                                    Circle()
                                        .fill(task.taskColor)
                                        .frame(width: task.size, height: task.size)
                                        .shadow(color: .black.opacity(0.25), radius: 8, x: 0, y: 6)

                                    Image(systemName: task.icon)
                                        .foregroundColor(.white)
                                        .font(.system(size: task.size * 0.35, weight: .bold))
                                }
                            }
                            .offset(y: -60)
                        }
                        else {
                            Button {
                                addTaskSheet = true
                            } label: {
                                Circle()
                                    .fill(Color(.btn))
                                    .frame(width: 90, height: 90)
                                    .overlay(
                                        Image(systemName: "plus")
                                            .font(.system(size: 40))
                                            .foregroundColor(.white)
                                    )
                                    .shadow(color: .black.opacity(0.25),
                                            radius: 8, x: 0, y: 6)
                            }
                            .offset(y: -60)
                        }

                        // Date + Time
                        Text(Date().todayString)
                            .font(.system(size: 30, weight: .medium))
                            .foregroundColor(Color.btn.opacity(0.8))
                            .offset(y: -20)

                        Text(Date().timeString)
                            .font(.system(size: 20))
                            .foregroundColor(Color.btn)
                            .offset(y: -10)
                    }
                    .padding(.bottom, 50)
                }
            }
        }
        .sheet(item: $selectedTask)  { task in
            taskSheet(task: task)
                .presentationDetents([.large])
                .presentationDragIndicator(.visible)
        }
            
        .sheet(isPresented: $addTaskSheet) {
            sheetView()
                .presentationDetents([.large])
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

