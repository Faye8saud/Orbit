//
//  taskSheet.swift
//  Orbit
//
//  Created by Fay  on 27/11/2025.
//
import SwiftUI
import SwiftData

struct taskSheet: View {
    private let speechService = SpeechService()
    @State private var isSpeakingDescription = false
    @State private var descriptionText:
    String = "هذا نص بسيط يمكن وضعه هنا"
    @State private var showDeleteConfirm = false

    let task: TaskModel
    
    //
        init(task: TaskModel) {
            self.task = task
        }

        // init إضافي بدون باراميتر عشان الأماكن القديمة اللي تستدعي taskSheet()
        init() {
            self.task = TaskModel(
                name: "",
                type: "work",
                desc: "",
                priority: 1,
                distance: 160,
                actionType: "openTask",
                date: .now
            )
        }
    @Environment(\.modelContext) private var context
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        VStack(alignment: .center, spacing: 16) {
            
            // الأيقونة
 
                
                
                Circle()
                    .fill(task.taskColor)
                    .frame(width: 120, height: 120)
                    .overlay(
                        Image(systemName: task.icon)
                            .font(.system(size: 30))
                            .foregroundColor(.white)
                    )
                    .shadow(color: .black.opacity(0.25), radius: 8, x: 0, y: 6)
                    .padding(.bottom, 50)
                //.offset(y:-100)
              
            
            VStack(alignment: .leading, spacing: 6) {
                
                Text(task.name)
                    .font(.headline)
                    .foregroundColor(.btn)
                 //   .multilineTextAlignment(.trailing)
                    .padding(10) // padding inside the box
                    .background(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color.btn.opacity(0.4), lineWidth: 1.5)
                    )
                Text("Time: \(task.date.formatted(date: .omitted, time: .shortened))")
                    .font(.system(size: 18, weight: .bold))
                    .foregroundColor(.btn)                                .multilineTextAlignment(.trailing)
                    .padding(10)
                    .padding(.top ,10)
            }
                .frame(maxWidth: .infinity, alignment: .leading)
      
            VStack(alignment: .trailing, spacing: 10) {

                HStack(alignment: .top) {
                    Button {
                        descriptionSpeakTapped()
                    } label: {
                        Image(systemName: isSpeakingDescription ? "speaker.wave.3.fill" : "speaker.wave.2")
                            .font(.system(size: 20))
                            .foregroundColor(.white)
                            .padding(12)
                            .background(Color.btn)
                            .clipShape(Circle())
                            .shadow(radius: 3)
                    }
                    .padding(.trailing, 10)
                    
                    VStack(alignment: .trailing) {
                        if task.desc.isEmpty {
                            Text("No Description")
                                .foregroundColor(Color.btn)
                        } else {
                            Text(task.desc)
                                .foregroundColor(Color.btn)
                                .fixedSize(horizontal: false, vertical: true)
                        }
                    }
                    .padding(12)
                    .background(
                        RoundedRectangle(cornerRadius: 10)
                            .fill(Color(.background))
                            .overlay(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(Color.btn.opacity(0.4), lineWidth: 1.5)
                            )
                    )

               
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            Spacer()
            
            Button(role: .destructive) {
                showDeleteConfirm = true
            } label: {
                Text("Delete task")
                    .font(SwiftUI.Font.system(size: 20, weight: .regular))
                    .frame(maxWidth: 200)
                    .padding(20)
                    .background(Color(.deletred))
                    .foregroundColor(.white)
                    .cornerRadius(45)
            }
            .padding(.top, 10)
        }
        .padding()
        .background(Color(.background))
        .onAppear {
                descriptionText = task.desc   //  loads task description into the state
            
            }
        .alert("Are you sure?", isPresented: $showDeleteConfirm) {
            Button("Delete", role: .destructive) {
                deleteTask()
            }

            Button("Cancel", role: .cancel) {}
        } message: {
            Text("this task will be deleted entirely")
        }
    }
    private func descriptionSpeakTapped() {
        if isSpeakingDescription {
            // stop speaking
            speechService.stop()
            isSpeakingDescription = false
        } else {
            // start speaking the Arabic description
            speechService.speak(descriptionText)
            isSpeakingDescription = true
        }
    
    }
    
    private func deleteTask() {
        context.delete(task)
        try? context.save()
        dismiss()
    }
}




#Preview {
    
    let example = TaskModel(
        name: "مهمة تجريبية",
        type: "work",
        desc: "test description",
        priority: 2,
        actionType: "openTask",
        date: .now
    )
    return taskSheet(task: example)
}

