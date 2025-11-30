//
//  sheetView.swift
//  Orbit
//
//  Created by Fay  on 26/11/2025.
//

import SwiftUI

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



struct sheetView: View {
    @State private var selectedType: String? = "meeting"
    @State private var currentStep: Int = 1
    
    
    @State private var name: String = ""
    @State private var date: Date = Date()
    @State private var time: Date = Date()
    @State private var description: String = ""

    
    // --------------------------
       let types: [String: TaskType] = [
           "work": TaskType(id: "work", icon: "doc.fill", label: "عمل", color: .yellowc),
           "meeting": TaskType(id: "meeting", icon: "person.3.fill", label: "اجتماع", color: .lightbluec),
           "personal": TaskType(id: "personal", icon: "person.fill", label: "شخصي", color: .darkpinkc),
           "home": TaskType(id: "home", icon: "house.fill", label: "منزل", color: .pinkc),
           "other": TaskType(id: "other", icon: "ellipsis", label: "اخرى", color: .circleInner)
       ]
    
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
       }

       // ----------------------------------
       // MARK: STEP 1 VIEW
       // ----------------------------------
       var taskTypeSelectionView: some View {
           VStack(spacing: 30) {
               
               Text("نوع المهمة")
                   .font(.system(size: 28, weight: .bold))
                   .padding(.top, 20)
                   .foregroundColor(.btn)
               
               HStack(spacing: 60) {
                   VStack{
                       typeButton(icon: "doc.fill", label: "عمل", color: .yellowc, id: "work")
                   }
                   VStack{
                       typeButton(icon: "person.3.fill", label: "اجتماع", color: .lightbluec, id: "meeting")
                   }
               }

               HStack(spacing: 60) {
                   VStack{
                       typeButton(icon: "person.fill", label: "شخصي", color: .darkpinkc, id: "personal")
                   }
                   VStack{
                       typeButton(icon: "house.fill", label: "منزل", color: .pinkc, id: "home")
                   }
               }

               typeButton(icon: "ellipsis", label: "اخرى", color: .circleInner, id: "other")

               Button {
                   currentStep = 2      // ← NAVIGATE INSIDE SAME SHEET
               } label: {
                   HStack {
                       Text("انتقل")
                           .font(.system(size: 18, weight: .bold))
                       Image(systemName: "arrow.right")
                   }
                   .padding()
                   .frame(width: 140)
                   .background(Color.btn)
                   .foregroundColor(.white)
                   .cornerRadius(20)
               }
               .padding(.bottom, 10)
           }
           .padding(.horizontal)
           .background(
               RoundedRectangle(cornerRadius: 30)
                   .fill(Color(.background))
           )
           .padding(.top, 50)
       }


    var taskDetailsView: some View {
    
        VStack(alignment: .center){
            
            
            if let id = selectedType, let type = types[id] {
                            TaskTypeCircle(icon: type.icon, color: type.color)
                                //.padding(.top, 40)
                        }
            
            
            VStack(spacing: 20) {
                        
                        // ----------------------
                        // TASK NAME FIELD
                        // ----------------------
                        VStack(alignment: .trailing, spacing: 6) {
                            Text("اسم المهمة")
                                .font(.headline)
                                .foregroundColor(.btn)
                            
                            TextField("اكتب اسم المهمة هنا", text: $name)
                                .padding()
                               // .background(Color(.systemGray6))
                                .cornerRadius(10)
                                .multilineTextAlignment(.trailing)
                                .background(
                                                   RoundedRectangle(cornerRadius: 10)
                                                    .stroke(Color.btn.opacity(0.4), lineWidth: 1.5) // ← border
                                               )
                        }
                        
                        // ----------------------
                        // DATE PICKER
                        // ----------------------
                        VStack(alignment: .trailing, spacing: 6) {
                            Text("التاريخ")
                                .font(.headline)
                                .foregroundColor(.btn)
                                .padding(.leading, 200)
                            DatePicker(
                                "",
                                selection: $date,
                                displayedComponents: .date
                            )
                            .labelsHidden()
                            .datePickerStyle(.compact)
                            .padding()
                          //  .background(Color(.systemGray6))
                            .cornerRadius(10)
                            .padding(.leading, 200)
                        }
                     
                        // ----------------------
                        // TIME PICKER
                        // ----------------------
                        VStack(alignment: .trailing, spacing: 6) {
                            Text("الوقت")
                                .font(.headline)
                                .foregroundColor(.btn)
                            
                            DatePicker(
                                "",
                                selection: $time,
                                displayedComponents: .hourAndMinute
                            )
                            .labelsHidden()
                            .datePickerStyle(.wheel)
                            .frame(height: 70)
                            .padding()
                          //  .background(Color(.systemGray6))
                            .cornerRadius(10)
                        }
                        
                        // ----------------------
                        // DESCRIPTION FIELD
                        // ----------------------
                        VStack(alignment: .trailing, spacing: 6) {
                            Text("الوصف")
                                .font(.headline)
                                .foregroundColor(.btn)
                            
                            ZStack(alignment: .bottomLeading) {   // ← position button inside editor
                                   TextEditor(text: $description)
                                       .scrollContentBackground(.hidden)
                                       .background(Color(.background))
                                       .frame(minHeight: 120)
                                       .padding(8)
                                       .multilineTextAlignment(.trailing)
                                       .overlay(
                                           RoundedRectangle(cornerRadius: 10)
                                               .stroke(Color.btn.opacity(0.4), lineWidth: 1.5)
                                       )

                                   // -----------------------------
                                   // VOICE BUTTON OVERLAY
                                   // -----------------------------
                                   Button(action: {
                                       // TODO: trigger recording logic
                                   }) {
                                       Image(systemName: "mic.fill")
                                           .font(.system(size: 20))
                                           .foregroundColor(.white)
                                           .padding(10)
                                           .background(Color.btn)
                                          // .frame(width: 60, height: 60)  // ← button size
                                           .clipShape(Circle())
                                           .shadow(radius: 3)
                                   }
                                   .padding(.leading, 12)
                                   .padding(.bottom, 45)
                               }
                           }
                        // ----------------------
                        // SUBMIT BUTTON
                        // ----------------------
                        Button(action: {
                            print("Task saved: \(name)")
                        }) {
                            Text("حفظ")
                                .font(.system(size: 18, weight: .bold))
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(Color.btn)
                                .foregroundColor(.white)
                                .cornerRadius(12)
                        }
                        .padding(.top, 10)
                        
                    }
            .padding()
            .background(
                RoundedRectangle(cornerRadius: 30)
                    .fill(Color(.background))
            )
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
        
        
        // --------------------------
        // TaskType Model
        // --------------------------
        struct TaskType {
            let id: String
            let icon: String
            let label: String
            let color: Color
        }
        
        
        // --------------------------
        // Type Button Builder
        // --------------------------
        @ViewBuilder
        func typeButton(icon: String, label: String, color: Color, id: String) -> some View {
            TaskTypeButton(
                icon: icon,
                label: label,
                isSelected: selectedType == id,
                color: color
            ) {
                selectedType = id
            }
        }
    }

    #Preview {
        sheetView()
    }
