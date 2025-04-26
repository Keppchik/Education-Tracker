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
    
    var body: some View {
        Button(action: {
            isShowCalendar = true
        }) {
            HStack {
                Text("Deadline")
                    .foregroundColor(.primary)
                Spacer()
                Text(displayText)
                    .foregroundColor(.primary)
            }
        }
        .sheet(isPresented: $isShowCalendar) {
            NavigationView {
                DatePicker(
                    "Select deadline",
                    selection: $selectedDate,
                    displayedComponents: [.date]
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
            .presentationDetents([.height(450)])
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
