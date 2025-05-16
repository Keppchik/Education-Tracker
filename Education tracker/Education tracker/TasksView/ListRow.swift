//
//  ListRow.swift
//  Education tracker
//
//  Создан Иваном Кретовым 04.04.2025.
//

import SwiftUI

/// Строка списка задач c возможностью разворачивания для показа элементов.
///
/// `ListRow` отображает название списка, количество задач и иконку-гамбургер.
/// По нажатию строка раскрывается, показывая навигационные ссылки на детали
/// каждой задачи. Анимация поворота иконки ☰ и постепенное появление элементов
/// реализованы через `withAnimation` и `transition`.
struct ListRow: View {
    // MARK: - Состояние
    /// Название списка.
    @State var name: String
    /// Массив задач, ассоциированных со списком.
    @State var items: [ClassTask]
    /// Флаг раскрытия/сворачивания.
    @State var isExpanded = false
    /// Цветовая схема для адаптивного фона иконки.
    @Environment(\.colorScheme) private var colorScheme
    
    // MARK: - UI
    var body: some View {
        // Основная кнопка строки — переключает раскрытие
        Button {
            isExpanded.toggle()
        } label: {
            HStack {
                // Иконка-гамбургер с поворотом при раскрытии
                ZStack {
                    RoundedRectangle(cornerRadius: 8)
                        .fill(colorScheme == .light ? Color.gray.opacity(0.3) : Color.gray.opacity(0.7))
                        .frame(width: 30, height: 30)
                    Text("☰")
                        .font(.system(size: 24))
                        .padding(.bottom, 5)
                        .rotationEffect(.degrees(isExpanded ? 90 : 0))
                        .animation(.default, value: isExpanded)
                }
                
                Text(name)
                
                Spacer()
                
                Text(String(items.count))
                    .padding(.trailing)
            }
            .contentShape(Rectangle()) // Увеличиваем область нажатия
            .frame(maxWidth: .infinity, alignment: .leading)
            .foregroundColor(.primary)
            .padding(.leading)
        }
        
        // Дополнительные строки с задачами, появляются при isExpanded == true
        ForEach(Array(items.enumerated()), id: \ .element) { index, item in
            if isExpanded {
                NavigationLink { TaskDetailsView(task: item) } label: {
                    HStack {
                        Image(systemName: "circle.fill")
                            .font(.system(size: 8))
                        
                        Text(item.title)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .foregroundColor(.primary)
                    .padding(.leading, 56)
                    .padding(.bottom, 8)
                }
                // Анимация появления элементов списка
                .transition(
                    .asymmetric(
                        insertion: .opacity,
                        removal: .identity
                    )
                    .animation(
                        .spring(response: 0.5, dampingFraction: 0.7)
                        .delay(Double(index) * 0.15)
                    )
                )
            }
        }
    }
}

#Preview {
    ListRow(name: "List name", items: [])
}
