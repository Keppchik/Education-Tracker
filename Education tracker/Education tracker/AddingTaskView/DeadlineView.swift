//
//  DeadlineView.swift
//  Education tracker
//
//  Создан Иваном Миронов 22.04.2025.
//

import SwiftUI

/// Компонент выбора дедлайна задачи.
///
/// Кнопка отображает текущую дату дедлайна строкой «Today / Tomorrow / 22 May».
/// При нажатии открывается модальный `DatePicker` в графическом стиле.
/// Закрывается по двойному тапу на календарь или по кнопке «Done» в тулбаре.
struct DeadlineView: View {
    // MARK: - Привязки и состояние
    /// Текущая выбранная дата дедлайна (двусторонняя связь с родителем).
    @Binding var selectedDate: Date
    /// Флаг отображения модального календаря.
    @State private var isShowCalendar = false
    
    /// Текст, отображаемый в кнопке: Today / Tomorrow / отформатированная дата.
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
    
    // MARK: - UI
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
        // Модальный календарь
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
                // Двойной тап по календарю закрывает окно
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
            .presentationDetents([.height(450)]) // Высота шита
        }
    }
}

// MARK: - Превью
struct PreviewWrapperDeadline: View {
    @State private var date = Date()
    var body: some View {
        DeadlineView(selectedDate: $date)
    }
}

#Preview {
    PreviewWrapperDeadline()
}
