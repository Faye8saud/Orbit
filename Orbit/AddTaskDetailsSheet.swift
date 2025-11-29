//
//  AddTaskDetailsSheet.swift
//  Orbit
//
//  Created by Fay  on 26/11/2025.
//
import SwiftUI

var taskDetailsView: some View {
    VStack(spacing: 20) {
        Text("اسم المهمة")
            .font(.system(size: 24, weight: .bold))

        // Your full form UI here (text fields, date pickers, etc.)

        Button {
            // finish action
        } label: {
            HStack {
                Text("تم")
                Image(systemName: "checkmark")
            }
            .padding()
            .frame(width: 140)
            .background(Color.blue)
            .foregroundColor(.white)
            .cornerRadius(20)
        }
    }
}
