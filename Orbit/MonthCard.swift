//
//  Calendar.swift
//  Orbit
//
//  Created by Samar A on 10/06/1447 AH.
//

import SwiftUI

struct MonthCard: View {
    let monthDate: Date
    let isCurrent: Bool
    
    private let calendar = Calendar.current
    
    var body: some View {
        let days = generateDays()
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en")
        formatter.dateFormat = "LLLL"
        
        let monthName = formatter.string(from: monthDate)
        let year = calendar.component(.year, from: monthDate)
        
        return VStack(spacing: 18) {
            HStack{
                Text("\(monthName)\(String(year))")
                .font(.system(size: 20 , weight: .semibold))
                   
            }
            
            HStack {
                ForEach(["Su", "Mo", "Tu", "We", "Th", "Fr", "Sa"], id: \.self) { name in
                    Text(name)
                        .font(.system(size: 15, weight: .medium))
                        .frame(maxWidth: .infinity, alignment: .center)
                }
            }
            
            VStack(spacing: 11) {
                ForEach(days, id: \.self) { week in
                    HStack {
                        ForEach(week, id: \.self) { day in
                            dayView(for: day)
                    .frame(maxWidth: .infinity, alignment: .center)
                  

                        }
                    }
                }
            }
            
            Spacer(minLength: 0)
        }
        .padding(16)
        .frame(width: 320, height: 320)
        .background(Color("Color1"))
        .cornerRadius(32)
        .shadow(radius: isCurrent ? 6 : 0)
        .opacity(isCurrent ? 1.0 : 0.4)
        .allowsHitTesting(isCurrent)
        
    }
    
    private func dayView(for date: Date?) -> some View {
        let isToday = date.map { calendar.isDateInToday($0) } ?? false
        
        return Group {
            if let date = date {
                Text("\(calendar.component(.day, from: date))")
                    .font(.system(size: 14))
                    .frame(width: 28, height: 28)
                    .background(
                        Circle()
                            .fill(isToday ? Color("background").opacity(0.3) : .clear)
                    )
                    .overlay(
                        Circle()
                            .stroke(isToday ? Color("background") : .clear, lineWidth: 0.3)
                    )
            } else {
                Text("")
                    .frame(width: 28, height: 28)
            }
        }
    }
    
    private func generateDays() -> [[Date?]] {
        var weeks: [[Date?]] = []
        let range = calendar.range(of: .day, in: .month, for: monthDate)!
        
        var components = calendar.dateComponents([.year, .month], from: monthDate)
        components.day = 1
        let firstOfMonth = calendar.date(from: components)!
        
        let weekdayOffset = (calendar.component(.weekday, from: firstOfMonth) + 6) % 7
        
        var currentWeek: [Date?] = Array(repeating: nil, count: weekdayOffset)
        
        for day in range {
            components.day = day
            let date = calendar.date(from: components)!
            currentWeek.append(date)
            
            if currentWeek.count == 7 {
                weeks.append(currentWeek)
                currentWeek = []
            }
        }
        
        if !currentWeek.isEmpty {
            currentWeek += Array(repeating: nil, count: 7 - currentWeek.count)
            weeks.append(currentWeek)
        }
        
        return weeks
    }
}

#Preview {
    MonthCard(monthDate: Date(), isCurrent: true)
}
