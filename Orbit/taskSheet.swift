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
              
            
            VStack(alignment: .trailing, spacing: 6) {
                
                Text(task.name)
                    .font(.headline)
                    .foregroundColor(.btn)
                    .multilineTextAlignment(.trailing)
                    .padding(10) // padding inside the box
                    .background(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color.btn.opacity(0.4), lineWidth: 1.5)
                    )
                Text("الوقت: \(task.date.formatted(date: .omitted, time: .shortened))")
                    .font(.system(size: 18, weight: .bold))
                    .foregroundColor(.btn)                                .multilineTextAlignment(.trailing)
                    .padding(10)
                    .padding(.top ,10)
            }
                .frame(maxWidth: .infinity, alignment: .trailing)
      
            ZStack(alignment: .trailing) {
                
                RoundedRectangle(cornerRadius: 10)
                    .fill(Color(.background))
                    .frame(minHeight:100)
                    .padding(10)
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color.btn.opacity(0.4), lineWidth: 1.5)
                    )
                // -----------------------------
                // VOICE BUTTON OVERLAY
                // -----------------------------
                Button {
                    descriptionSpeakTapped()
                } label: {
                    Image(systemName: isSpeakingDescription ? "speaker.wave.3.fill" : "speaker.wave.2")
                        .font(.system(size: 20))
                        .foregroundColor(.white)
                        .padding(15)
                        .background(Color.btn)
                        .clipShape(Circle())
                        .shadow(radius: 3)
                }
                .padding(.trailing, 12)
                .padding(.bottom, 45)
                .offset(y: -138)
                // Display text
                Text(task.desc.isEmpty ? "لا يوجد وصف" : task.desc)
                    .foregroundColor(Color.btn)
                    .padding(8)
                    .multilineTextAlignment(.trailing)
            }
            .padding(2)
            Spacer()
        }
        .padding()
        .background(Color(.background))
        .onAppear {
                descriptionText = task.desc   //  loads task description into the state
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
}

#Preview {
    let example = TaskModel(
        name: "مهمة تجريبية",
        type: "work",
        desc: "هذا وصف بسيط للتاسك.",
        priority: 2,
        actionType: "openTask",
        date: .now
    )
    return taskSheet(task: example)
}
