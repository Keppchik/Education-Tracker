//
//  TaskRow.swift
//  Education tracker
//
//  Создан Иваном Кретовым 21.04.2025.
//

import SwiftUI

/// Отдельная строка задачи в списке «Сегодня / Завтра / Позже».
///
/// Содержит:
/// * чекбокс (SF Symbol `circle` / `checkmark.circle.fill`),
/// * заголовок задачи,
/// * дополнительную метку даты/времени в зависимости от секции.
///
/// При нажатии на чекбокс выполняет замыкание `onTap` (переданное из родительского
/// списка), после чего локально меняет состояние `isTapped`, окрашивая текст в
/// серый и заменяя иконку.
struct TaskRow: View {
    // MARK: - Окружение, состояние и пропсы
    /// Цветовая схема для адаптивного фона / тени.
    @Environment(\.colorScheme) private var colorScheme
    /// Экземпляр задачи, отображаемой в строке.
    @State var task: ClassTask
    /// Локальный флаг «задача отмечена» (UI‑уровень).
    @State private var isTapped: Bool = false
    /// Секция, к которой принадлежит задача (`today`, `tomorrow`, `later`).
    var sectionEnum: SectionEnum
    /// Замыкание, вызываемое при тапе на чекбокс (например, обновить Core Data).
    var onTap: () -> Void
    
    // MARK: - UI
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            HStack {
                // Чекбокс
                Image(systemName: isTapped ? "checkmark.circle.fill" : "circle")
                    .font(.title3)
                    .onTapGesture {
                        onTap()
                        isTapped.toggle()
                    }
                
                // Заголовок задачи
                Text(task.title)
                    .font(.subheadline)
                    .foregroundColor(isTapped ? .gray : .primary)
                
                Spacer()
            }
            // Дополнительная дата/время
            if sectionEnum == .today || sectionEnum == .tomorrow {
                Text("\(formatDateHourMin(task.date))")
                    .font(.caption)
                    .foregroundColor(.gray)
            }
            if sectionEnum == .later {
                Text("\(formatDateDayMonth(task.date))")
                    .font(.caption)
                    .foregroundColor(.gray)
            }
        }
        // Карточка
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 12)
                .fill(colorScheme == .light ? .white : .white.opacity(0.12))
        )
        .shadow(color: Color.primary.opacity(0.1), radius: 3, x: 2, y: 2)
        .padding(.horizontal)
    }
}

// MARK: - Превью
#Preview {
    let context = CoreDataManager.shared.context
    
    let task1 = ClassTask(context: context)
    task1.id = UUID()
    task1.title = "Test Task 1"
    task1.date = Date()
    task1.type = TypeOptions.ToDo.rawValue
    task1.status = StatusOptions.ToDo.rawValue
    task1.score = 0
    task1.maxScore = 10
    task1.taskDescription = "Test description 1"
    task1.isDone = false
    
    return NavigationView {
        TaskRow(task: task1, sectionEnum: .today, onTap: {})
            .environmentObject(ModelData())
            .environment(\.managedObjectContext, context)
    }
}
