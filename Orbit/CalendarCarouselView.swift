//
//  CalendarCarouselView.swift
//  Orbit
//
//  Created by Samar A on 10/06/1447 AH.
//

import SwiftUI

struct CalendarCarouselView: View {
    @State private var currentIndex: Int = 0
    @State private var showSheet : Bool = false
    private let calendar = Calendar.current
    
    private var months: [Date] {
        let now = Date()
        return (0..<3).compactMap { offset in
            calendar.date(byAdding: .month, value: offset, to: now)
        }
    }
    
    var body: some View {
        ZStack {
            Color("Background").ignoresSafeArea()
            
            VStack {
                Spacer().frame(height: 40)
                
                TabView(selection: $currentIndex) {
                    ForEach(months.indices, id: \.self) { index in
                        MonthCard(
                            monthDate: months[index],
                            isCurrent: index == 0
                        )
                        .tag(index)
                    }
                }
                .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
                .frame(height: 340)
                
                Spacer()
                
                
                HStack {
                    Spacer()
                    
                    Button {
                        showSheet = true
                    } label: {
                        ZStack {
                            Circle()
                                .fill(Color("Color"))
                                .frame(width: 90, height: 90)
                                .shadow(color: Color("Color").opacity(0.25),
                                        radius: 10, x: 0, y: 2)
                            
                            Image(systemName: "plus")
                                .font(.system(size: 30, weight: .bold))
                                .foregroundColor(.white)
                        }
                    }
                    .padding(.trailing, 32)
                    .padding(.bottom, 40)
                }
                
            }
        }
        .sheet(isPresented: $showSheet) {
            sheetView()
        }
    }
}
    

#Preview {
    CalendarCarouselView()
   
}
