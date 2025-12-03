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
                .foregroundColor(.btn)
        }
    }
}

struct TaskTypeCircle: View {
    let icon: String
    let color: Color
    
    var body: some View {
        Circle()
            .fill(color)
            .frame(width: 120, height: 120)
            .overlay(
                Image(systemName: icon)
                    .font(.system(size: 40))
                    .foregroundColor(.white)
            )
            .shadow(radius: 5)
    }
}

@ViewBuilder
func typeButton(icon: String, label: String, color: Color, id: String, selectedType: Binding<String?>, action: @escaping () -> Void = {}) -> some View {
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

// MARK: - Sheet View
struct sheetView: View {
    @Environment(\.modelContext) private var context
    @Environment(\.dismiss) private var dismiss
    
    @State private var selectedType: String? = "meeting"
    @State private var currentStep: Int = 1
    
    @State private var name: String = ""
    @State private var date: Date = Date()
    @State private var time: Date = Date()
    @State private var description: String = ""
    
    @State private var showAlert = false
    @State private var alertMessage = ""
    
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
        .alert("تنبيه", isPresented: $showAlert) {
            Button("حسناً", role: .cancel) { }
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
            //.foregroundColor(.btn)
            
            HStack(spacing: 60) {
                VStack {
                    typeButton(icon: "doc.fill", label: "Work", color: .darkpinkc, id: "work", selectedType: $selectedType)
                }
                VStack {
                    typeButton(icon: "person.3.fill", label: "Meeting", color: .yellowc, id: "meeting", selectedType: $selectedType)
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
                    .background(Color("btnColor"))
                    .foregroundColor(.white)
                    .cornerRadius(40)
                    .shadow(color: Color("btnColor").opacity(0.25),
                            radius: 10, x: 0, y: 2)
            }
            .padding(.leading)
        }
        //.padding(.horizontal)
        .background(
            RoundedRectangle(cornerRadius: 30)
                .fill(Color(.background))
        )
        .padding(.top, 70)
        
    }
    
    var taskDetailsView: some View {
        ScrollView {
            VStack(alignment: .center, spacing: 20) {
                HStack {
                    Button(action: { currentStep = 1 }) {
                        HStack {
                            Image(systemName: "arrow.left")
                            Text("رجوع")
                        }
                        .font(.system(size: 16, weight: .semibold))
                        .foregroundColor(.btn)
                    }
                    Spacer()
                }
                .padding(.horizontal)
                
                if let id = selectedType, let type = TaskHelpers.allTypes[id] {
                    TaskTypeCircle(icon: type.icon, color: type.color)
                }
                
                VStack(spacing: 16) {
                    // TASK NAME
                    VStack(alignment: .leading, spacing: 6) {
                        Text("Task Name")
                            .font(.system(size: 20 , weight: .semibold))
                        
                        TextField("Enter the task name here", text: $name)
                            .padding()
                            .multilineTextAlignment(.leading)
                            .background(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(Color.btn.opacity(0.4), lineWidth: 1.5)
                            )
                    }
                    
                    VStack(alignment: .leading, spacing: 6) {
                        Text("Date")
                            .multilineTextAlignment(.leading)
                            .font(.system(size: 20 , weight: .semibold))
                        
                        DatePicker(
                            "",
                            selection: $date,
                            displayedComponents: .date
                        )
                        .labelsHidden()
                        .datePickerStyle(.compact)
                        .padding()
                       // .background(
                           // RoundedRectangle(cornerRadius: 10)
                                //.stroke(Color.btn.opacity(0.4), lineWidth: 1.5)
                       // )
                    }
                    
                    // TIME PICKER
                    VStack(alignment: .leading, spacing: 6) {
                        Text("Time")
                            .font(.system(size: 20 , weight: .semibold))
                        
                        DatePicker(
                            "",
                            selection: $time,
                            displayedComponents: .hourAndMinute
                        )
                        .labelsHidden()
                        .datePickerStyle(.wheel)
                        .frame(height: 70)
                       // .padding()
                       // .background(
                          //  RoundedRectangle(cornerRadius: 10)
                            //    .stroke(Color.btn.opacity(0.4), lineWidth: 1.5)
                       // )
                    }
                    
                    // DESCRIPTION
                    VStack(alignment: .leading, spacing: 6) {
                        Text("Description")
                            .font(.system(size: 20 , weight: .semibold))
                        
                        ZStack(alignment: .topLeading) {
                            TextEditor(text: $description)
                                .scrollContentBackground(.hidden)
                                .background(Color(.background))
                                .frame(minHeight: 120)
                                .padding(8)
                                .multilineTextAlignment(.leading) // يسار للإنجليزي
                                .overlay(
                                    RoundedRectangle(cornerRadius: 10)
                                        .stroke(Color.btn.opacity(0.4), lineWidth: 1.5)
                                )
                            
                            
                            //لو حبيتي تفعّلينه لاحقاً
                            // Button(action: {
                            //     // TODO: trigger recording logic
                            // }) {
                            //     Image(systemName: "mic.fill")
                            //         .font(.system(size: 18, weight: .semibold))
                            //         .foregroundColor(.btn)
                            // }
                            // .padding(.leading, 16)
                            // .padding(.top, 16)
                        }
                    }
                    
                    Button(action: {
                        saveTask()
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
                    .padding(.top, 10)
                }
                .padding()
                .background(
                    RoundedRectangle(cornerRadius: 30)
                        .fill(Color(.background))
                )
            }
        }
    }
    
    private func saveTask() {
        guard !name.trimmingCharacters(in: .whitespaces).isEmpty else {
            alertMessage = "الرجاء إدخال اسم المهمة"
            showAlert = true
            return
        }
        
        guard let taskType = selectedType else {
            alertMessage = "الرجاء اختيار نوع المهمة"
            showAlert = true
            return
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
        
        let finalDate = calendar.date(from: combinedComponents) ?? date
        
        // Create new task
        let newTask = TaskModel(
            name: name,
            type: taskType,
            desc: description,
            priority: 3, 
            distance: 160,
            actionType: "openTask",
            date: finalDate
        )
        
        // Insert into context
        context.insert(newTask)
        
        // Save context
        do {
            try context.save()
            print("Task saved successfully: \(newTask.name)")
            dismiss()
        } catch {
            alertMessage = "حدث خطأ أثناء حفظ المهمة: \(error.localizedDescription)"
            showAlert = true
            print("Error saving task: \(error)")
        }
    }
}
    

// MARK: - Preview
#Preview {
    sheetView()
        .modelContainer(for: TaskModel.self)
}
