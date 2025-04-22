//
//  DeadlineView.swift
//  Education tracker
//
//  Created by Иван Миронов on 22.04.2025.
//


import SwiftUI

struct DeadlineView: View {
    @State private var selectedDate: Date = Date()
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
                    .foregroundColor(.black)
                Spacer()
                Text(displayText)
                    .foregroundColor(.black)
            }
        }
        .sheet(isPresented: $isShowCalendar) {
            NavigationView {
                DatePicker(
                    "Select deadline",
                    selection: $selectedDate,
                    in: Date()...,
                    displayedComponents: .date
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

#Preview {
    DeadlineView()
}
