//
//  taskSheet.swift
//  Orbit
//
//  Created by Fay  on 27/11/2025.
//
import SwiftUI


struct taskSheet: View {
    
    
    var body: some View {
        ZStack{
            Color(.background)
                .ignoresSafeArea()
            
            VStack(alignment: .center){
                
                
                Circle()
                    .fill(Color(.darkpinkc))
                    .frame(width: 120, height: 120)
                    .overlay(
                        Image(systemName: "person.fill")
                            .font(.system(size: 40, weight: .medium))
                            .foregroundColor(.white)
                    )
                    .shadow(color: .black.opacity(0.25), radius: 8, x: 0, y: 6)
                    .padding(.bottom, 50)
                    //.offset(y:-100)
                Spacer()
                
                VStack(spacing: 20) {
                    
                    // ----------------------
                    // TASK NAME FIELD
                    // ----------------------
                    VStack(alignment: .trailing, spacing: 6) {
                        Text("اسم المهمة مثال فقط")
                            .font(.headline)
                            .foregroundColor(.btn)
                            .multilineTextAlignment(.trailing)
                            .padding(10) // padding inside the box
                            .background(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(Color.btn.opacity(0.4), lineWidth: 1.5)
                            )
                        Text("الوقت : 10:00")
                            .font(.system(size: 18, weight: .bold))
                            .foregroundColor(.btn)
                            .multilineTextAlignment(.trailing)
                            .padding(10)
                            .padding(.top ,10)
                        

                    }
                    .frame(maxWidth: .infinity, alignment: .trailing)
                    // ----------------------
                    // DESCRIPTION FIELD
                    // ----------------------
                    VStack(alignment: .trailing, spacing: 6) {
                        Text("الوصف")
                            .font(.headline)
                            .foregroundColor(.btn)
                        
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
                            Button(action: {
                            // TODO: trigger recording logic
                            }) {
                                Image(systemName: "speaker.wave.3.fill")
                                    .font(.system(size: 20))
                                    .foregroundColor(.white)
                                    .padding(15)
                                    .background(Color.btn)
                                    .clipShape(Circle())
                                    .shadow(radius: 3)
                            }
                            .padding(.trailing, 12)
                            .padding(.bottom, 45)
                            .offset(y: -130)
                            // Display text
                            Text("هذا نص بسيط يمكن عرضه هنا")
                                .foregroundColor(Color.btn)
                                .padding(8)
                                .multilineTextAlignment(.trailing)
                                //.fixedSize(horizontal: false, vertical: true)
                        }
                        .padding(2)
                        Spacer()
                  
                    }
                }
                // ----------------------
                // SUBMIT BUTTON
                // ----------------------
               
                
            }
            .padding()
           
                
            
        }
        }
    }
        
    


#Preview {
    taskSheet()
}
