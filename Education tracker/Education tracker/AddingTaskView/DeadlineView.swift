//
//  DeadlineView.swift
//  Education tracker
//
//  Created by Иван Миронов on 22.04.2025.
//


import SwiftUI

struct DeadlineView: View {
    @Binding var selectedDate: Date
    @State private var isShowCalendar = false
    
    private var displayText: String {
        let calendar = Calendar.current
        if calendar.isDateInToday(selectedDate) {
            return "Today"
        } else if calendar.isDateInTomorrow(selectedDate) {
            return "Tomorrow"
        } else {
            return selectedDate.formatted(date: .abbreviated, time: .omitted)
        }
    }
    
    private var timeText: String {
        let calendar = Calendar.current
        let components = calendar.dateComponents([.hour, .minute], from: selectedDate)
        
        if let hour = components.hour, let minute = components.minute {
            return String(format: "%02d:%02d", hour, minute)
        } else {
            return ""
        }
    }
    
    var body: some View {
        HStack {
            Button(action: {
                isShowCalendar = true
            }) {
                HStack {
                    Text("Deadline")
                        .foregroundColor(.primary)
                    Spacer()
                    Text(displayText)
                        .foregroundColor(.primary)
                    Text(timeText)
                        .foregroundColor(.primary)
                }
            }
        }
        .sheet(isPresented: $isShowCalendar) {
            NavigationView {
                DatePicker(
                    "Deadline",
                    selection: $selectedDate,
                    displayedComponents: [.hourAndMinute, .date]
                )
                .datePickerStyle(.graphical)
                .navigationTitle("Select Date")
                .navigationBarTitleDisplayMode(.inline)
                .onTapGesture(count: 2) {
                    isShowCalendar = false
                }
                .toolbar {
                    ToolbarItem(placement: .confirmationAction) {
                        Button("Done") {
                            isShowCalendar = false
                        }
                    }
                }
            }
            .presentationDetents([.fraction(0.65)])
        }
    }
}


struct PreviewWrapperDeadline: View {
        @State private var date = Date()
        
        var body: some View {
            DeadlineView(selectedDate: $date)
        }
    }

#Preview {
    PreviewWrapperDeadline()
}
