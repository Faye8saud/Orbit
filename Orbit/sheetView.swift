//
//  sheetView.swift
//  Orbit
//
//  Fixed to properly save tasks to SwiftData
//

import SwiftUI
import SwiftData

struct TaskTypeButton: View {
    let icon: String
    let label: String
    let isSelected: Bool
    let color: Color
    let action: () -> Void
    
    var body: some View {
        VStack {
            Button(action: action) {
                ZStack(alignment: .topTrailing) {
                    Circle()
                        .fill(color)
                        .frame(width: 90, height: 90)
                        .overlay(
                            Circle()
                                .stroke(isSelected ? Color.green : Color.clear, lineWidth: 3)
                        )
                        .overlay(
                            Image(systemName: icon)
                                .font(.system(size: 28))
                                .foregroundColor(.white)
                        )
                    
                    if isSelected {
                        Image(systemName: "checkmark.circle.fill")
                            .foregroundColor(.green)
                            .background(Color.white.clipShape(Circle()))
                            .offset(x: 8, y: -8)
                    }
                }
            }
            
            Text(label)
                .font(.system(size: 18))
                .foregroundColor(.text)
        }
    }
}

struct TaskTypeCircle: View {
    let icon: String
    let color: Color
    
    var body: some View {
        Circle()
            .fill(color)
            .frame(width: 90, height: 90)
            .overlay(
                Image(systemName: icon)
                    .font(.system(size: 30))
                    .foregroundColor(.white)
            )
            .shadow(radius: 5)
            .padding(-10)
    }
}

@ViewBuilder
func typeButton(
    icon: String,
    label: String,
    color: Color,
    id: String,
    selectedType: Binding<String?>,
    action: @escaping () -> Void = {}
) -> some View {
    TaskTypeButton(
        icon: icon,
        label: label,
        isSelected: selectedType.wrappedValue == id,
        color: color
    ) {
        selectedType.wrappedValue = id
        action()
    }
}

struct sheetView: View {
    @Environment(\.modelContext) private var context
    @Environment(\.dismiss) private var dismiss
    
    @Binding var navigateHome: Bool
    init(navigateHome: Binding<Bool> = .constant(false)) {
        _navigateHome = navigateHome
    }
    
    @State private var selectedType: String? = "meeting"
    @State private var currentStep: Int = 1
    
    @State private var name: String = ""
    @State private var date: Date = Date()
    @State private var time: Date = Date()
    @State private var description: String = ""
    
    @State private var showAlert = false
    @State private var alertMessage = ""
    @State private var selectedPriority: Int = 2 // default medium

    
    @ViewBuilder
    private func priorityCircle(priority: Int, size: CGFloat, typeID: String?) -> some View {
        
        let config = TaskHelpers.allTypes[typeID ?? ""]
        
        Button {
            selectedPriority = priority
        } label: {
            ZStack {
                Circle()
                    .fill(
                        selectedPriority == priority
                        ? (config?.color ?? Color.gray).opacity(0.9)
                        : Color.gray.opacity(0.35)
                    )
                    .frame(width: size, height: size)
                    .overlay(
                        Circle()
                            .stroke(
                                selectedPriority == priority
                                ? (config?.color ?? Color.gray)
                                : Color.clear,
                                lineWidth: 4
                            )
                    )
                
                Image(systemName: config?.icon ?? "flag.fill")
                    .foregroundColor(.white)
                    .font(.system(size: size * 0.28))
            }
        }
    }
    
    var body: some View {
        ZStack {
            Color(.background)
                .ignoresSafeArea()
            
            VStack {
                if currentStep == 1 {
                    taskTypeSelectionView
                        .transition(.move(edge: .leading))
                } else if currentStep == 2 {
                    taskDetailsView
                        .transition(.move(edge: .trailing))
                }
            }
            .animation(.easeInOut, value: currentStep)
        }
        .alert("Alert", isPresented: $showAlert) {
            Button("Okay", role: .cancel) { }
        } message: {
            Text(alertMessage)
        }
    }
    
    // MARK: - Step 1 View
    var taskTypeSelectionView: some View {
        VStack(spacing: 30) {
            Text("Task Type")
                .font(.system(size:25, weight: .bold))
                .padding(.top)
            
            HStack(spacing: 60) {
                VStack {
                    typeButton(icon: "doc.fill", label: "Work", color: .yellowc, id: "work", selectedType: $selectedType)
                }
                VStack {
                    typeButton(icon: "heart.text.clipboard.fill", label: "Health", color: .darkpinkc, id: "health", selectedType: $selectedType)
                }
            }
            
            HStack(spacing: 60) {
                VStack {
                    typeButton(icon: "person.fill", label: "Personal", color: .pinkc, id: "personal", selectedType: $selectedType)
                }
                VStack {
                    typeButton(icon: "house.fill", label: "Home", color: .lightbluec, id: "home", selectedType: $selectedType)
                }
            }
            
            typeButton(icon: "ellipsis", label: "Other", color: .lighghtGreenc, id: "other", selectedType: $selectedType)
            
            Button {
                currentStep = 2
            } label: {
                Text("Next")
         
                    .font(.system(size: 18, weight: .semibold))
                    .frame(width: 200, height: 70)
              //      .background(Color("btnColor"))
                    .glassEffect(.regular.tint(.btn))
                    .foregroundColor(.white)
                    .cornerRadius(40)
                    .shadow(color: Color("btnColor").opacity(0.25),
                            radius: 10, x: 0, y: 2)
            }
            .padding(.leading)
        }
        .background(
            RoundedRectangle(cornerRadius: 30)
                .fill(Color(.background))
        )
        .padding(.top, 70)
    }
    
    // MARK: - Priority Selection UI
    var prioritySelectionView: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Priority")
                .font(.system(size: 17, weight: .semibold))
                .padding(.leading, -20)

            HStack(spacing: 30) {
                priorityCircle(priority: 3, size: 60, typeID: selectedType)
                priorityCircle(priority: 2, size: 80, typeID: selectedType)
                priorityCircle(priority: 1, size: 110, typeID: selectedType)
            }
            .padding(.vertical, -10)
        }
    }

    
    // MARK: - Step 2 View
    var taskDetailsView: some View {
        ScrollView {
            VStack(alignment: .center, spacing: 20) {
                HStack {
                    Button(action: { currentStep = 1 }) {
                        HStack(spacing: 6) {
                            Image(systemName: "chevron.left")
                                .font(.system(size: 18, weight: .bold))
                                .foregroundColor(.btn)
                        }
                        .padding(.vertical, 15)
                        .padding(.horizontal, 18)
                    }
                    .padding(.leading, 4)
                    .padding(.top, 15)
                    Spacer()
                }

                prioritySelectionView
                
                VStack(spacing: 20) {
                    VStack(alignment: .leading, spacing: 6) {
                        Text("Task Name")
                            .font(.system(size: 17 , weight: .semibold))
                        
                        TextField("Enter the task name here", text: $name)
                            .padding()
                            .multilineTextAlignment(.leading)
                            .background(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(Color.btn.opacity(0.4), lineWidth: 1.5)
                            )
                    }
                    
                    HStack(spacing: 20){
                        Text("Date")
                            .multilineTextAlignment(.leading)
                            .font(.system(size: 16 , weight: .semibold))
                        
                        DatePicker(
                            "",
                            selection: $date,
                            displayedComponents: .date
                        )
                        .labelsHidden()
                        .datePickerStyle(.compact)
                        .tint(.btn)
                        
                        Spacer()
                    }
                    
                    VStack(alignment: .leading, spacing: 70) {
                        Text("Time")
                            .font(.system(size: 17 , weight: .semibold))
                        
                        DatePicker(
                            "",
                            selection: $time,
                            displayedComponents: .hourAndMinute
                        )
                        .labelsHidden()
                        .datePickerStyle(.wheel)
                        .scaleEffect(0.85)
                        .frame(height: 30)
                        
                        VStack(alignment: .leading, spacing: 10) {
                            Text("Description")
                                .font(.system(size: 17 , weight: .semibold))
                            
                            ZStack(alignment: .topLeading) {
                                TextEditor(text: $description)
                                    .scrollContentBackground(.hidden)
                                    .background(Color(.background))
                                    .frame(minHeight: 100)
                                    .padding(8)
                                    .multilineTextAlignment(.leading)
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 10)
                                            .stroke(Color.btn.opacity(0.4), lineWidth: 1.5)
                                    )
                            }
                        }
                    }
                    
                    Button(action: {
                        if saveTask() {
                            navigateHome = true
                            dismiss()
                        }
                    }) {
                        Text("Save")
                            .font(.system(size: 18, weight: .semibold))
                            .frame(width: 200, height: 70)
                          
                           .background(Color("btnColor"))
                            .foregroundColor(.white)
                          
                            
                            .cornerRadius(40)
                            .shadow(color: Color("btnColor").opacity(0.25),
                                    radius: 10, x: 0, y: 2)
                    }
                    .frame(maxWidth: .infinity, alignment: .center)
                    
                    .padding(.top, 5)
                }
                .padding()
                .background(
                    RoundedRectangle(cornerRadius: 30)
                        .fill(Color(.background))
                )
            }
        }
    }
    
    @discardableResult
    private func saveTask() -> Bool {
        guard !name.trimmingCharacters(in: .whitespaces).isEmpty else {
            alertMessage = "Please enter the task name "
            showAlert = true
            return false
        }
        
        guard let taskType = selectedType else {
            alertMessage = "Please select the task type"
            showAlert = true
            return false
        }
        
        // Combine date and time
        let calendar = Calendar.current
        let dateComponents = calendar.dateComponents([.year, .month, .day], from: date)
        let timeComponents = calendar.dateComponents([.hour, .minute], from: time)
        
        var combinedComponents = DateComponents()
        combinedComponents.year = dateComponents.year
        combinedComponents.month = dateComponents.month
        combinedComponents.day = dateComponents.day
        combinedComponents.hour = timeComponents.hour
        combinedComponents.minute = timeComponents.minute
        
        guard let finalDate = calendar.date(from: combinedComponents) else {
            alertMessage = "Invalid date/time combination"
            showAlert = true
            return false
        }
  
        // Validate that the task is in the future
        if finalDate <= Date() {
            alertMessage = "Please select a future date and time"
            showAlert = true
            return false
        }
        
        let newTask = TaskModel(
            name: name,
            type: taskType,
            desc: description,
            priority: selectedPriority,
            distance: 160,
            actionType: "openTask",
            date: finalDate
        )
        
        context.insert(newTask)
        
        do {
            try context.save()
            print("Task saved successfully: \(newTask.name) at \(finalDate)")
            
            // ⏰ هنا نحدد تنبيه الساعة 9 صباح يوم المهمة
            NotificationManager.shared.scheduleTaskReminder(
                taskName: newTask.name,
                date: finalDate
            )
            
            return true
        } catch {
            alertMessage = "Error saving task: \(error.localizedDescription)"
            showAlert = true
            print("Error saving task: \(error)")
            return false
        }
    }
}

#Preview {
    sheetView(navigateHome: .constant(false))
        .modelContainer(for: TaskModel.self)
}
