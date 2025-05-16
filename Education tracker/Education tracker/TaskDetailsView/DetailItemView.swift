//
//  DetailItemView.swift
//  Education tracker
//
//  Создан Иваном Кретовым 16.05.2025.
//

import SwiftUI

/// Строка детального представления с заголовком и значением.
///
/// Используется в `TaskDetailsView` для отображения пар «ключ–значение»
/// (например, тип задачи, дедлайн, статус и т. д.).
struct DetailItemView: View {
    /// Заголовок (ключ).
    let title: String
    /// Значение (данные).
    let value: String
    
    var body: some View {
        HStack {
            Text(title)
                .font(.system(size: 16))
                .foregroundColor(.gray)
            
            Spacer()
            
            Text(value)
                .font(.system(size: 16))
                .fontWeight(.medium)
                .foregroundColor(.primary)
        }
        .padding(.vertical, 8) // Вертикальный отступ между строками
    }
}

// MARK: - Превью
struct DetailItemView_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            DetailItemView(title: "Type", value: "Meeting")
            DetailItemView(title: "Deadline", value: "May 22, 2023")
        }
        .padding()
        .previewLayout(.sizeThatFits)
    }
}
