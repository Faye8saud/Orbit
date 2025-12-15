//
//  homeView.swift
//  Orbit
//
//  Updated with improved code reusability
//


import SwiftUI
import SwiftData

// MARK: - Menu Item Model
struct MenuItem: Identifiable {
    let id = UUID()
    let icon: String
    let color: Color
    let size: CGFloat
    let distance: CGFloat
    let action: () -> Void
}

// MARK: - Date Formatter Extension
extension Date {
    var todayString: String {
        let formatter = DateFormatter()
        formatter.locale = Locale.current  // ← use system language
        formatter.dateFormat = "d MMMM"
        return formatter.string(from: self)
    }
    
    var timeString: String {
        let formatter = DateFormatter()
        formatter.locale = Locale.current  // ← use system language
        formatter.dateFormat = "hh:mm a"
        return formatter.string(from: self)
    }
}
// MARK: - Circular Menu View
struct CircularMenuView: View {
    let items: [MenuItem]

    var body: some View {
        ZStack {
            ForEach(Array(items.enumerated()), id: \.element.id) { index, item in
                let angle = Angle.degrees(Double(index) / Double(items.count) * 360 - 90)


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

// MARK: - Home View
struct HomeView: View {
    @Environment(\.modelContext) private var context
    @Query(sort: \TaskModel.date) var allTasks: [TaskModel]

    @State private var showSheet = false
    @State private var selectedTask: TaskModel? = nil

     var todaysTasks: [TaskModel] {
        let cal = Calendar.current
        return allTasks.filter { cal.isDate($0.date, inSameDayAs: Date()) }
    }

    // Convert tasks to menu items
    private var menuItems: [MenuItem] {
        let sortedTasks = todaysTasks.sorted { $0.date < $1.date } // SORT BY TIME

        return sortedTasks.enumerated().map { _, task in
            MenuItem(
                icon: task.icon,
                color: task.isExpired ? .gray.opacity(0.5) : task.taskColor,
                size: CGFloat(task.size),
                distance: CGFloat(task.distance),
                action: {
                    selectedTask = task
                }
            )
        }
    }

    var body: some View {
        NavigationStack {
            ZStack {
                Color(.background)
                    .ignoresSafeArea()

                // 🔼 Top calendar button
                VStack {
                    HStack {
                        Spacer()

                        NavigationLink {
                            CalendarCarouselView()
                        } label: {
                            Image(systemName: "calendar")
                                .font(.system(size: 22, weight: .bold))
                                .foregroundColor(.white)
                                .padding(16)
                                .glassEffect(.regular.tint(.btn).interactive())
                                .clipShape(Circle())
                                .shadow(color: .black.opacity(0.25),
                                        radius: 4, x: 0, y: 2)
                        }
                        .padding(.top, 0)
                        .padding(.trailing, 20)
                         .offset(y: -50)
                    }
                    Spacer()
                }

                // Center circle with date and tasks
                centerCircleView

                // Bottom plus button
                VStack {
                    Spacer()
                    HStack {
                        Spacer()

                        Button(action: {
                            showSheet = true
                        }) {
                            ZStack {
                                Circle()
                                    .fill(Color("btnColor"))
                                    .frame(width: 70, height: 70)
                                    .shadow(color: Color("btnColor").opacity(0.25),
                                            radius: 10, x: 0, y: 2)

                                Image(systemName: "plus")
                                    .font(.system(size: 30, weight: .bold))
                                    .foregroundColor(.white)
                            }
                        }
                        .padding(.trailing, 20)
                        .padding(.bottom, 30)
                    }
                }
            }
        }
        // 👇 keep your sheets & onAppear outside NavigationStack
        .sheet(isPresented: $showSheet) {
            sheetView()
                .presentationDetents([.large])
                .presentationDragIndicator(.visible)
        }
        .sheet(item: $selectedTask) { task in
            taskSheet(task: task)
                .presentationDetents([.large])
                .presentationDragIndicator(.visible)
        }
        .onAppear {
            printTaskDebugInfo()
        }
    }

    // MARK: - Center Circle View
    private var centerCircleView: some View {
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

            Text(Date().todayString)
                .font(.system(size: 32, weight: .medium))
                .foregroundColor(.text)

            // Circular menu buttons
            CircularMenuView(items: menuItems)
        }
    }

    // MARK: - Debug Helper
    private func printTaskDebugInfo() {
        print("📊 Total tasks in database: \(allTasks.count)")
        print("📅 Today's tasks: \(todaysTasks.count)")

        for task in allTasks {
            print("  - \(task.name) | Type: \(task.type) | Date: \(task.date)")
        }
        
    }
}

#Preview {
    HomeView()
        .modelContainer(for: TaskModel.self)
}

