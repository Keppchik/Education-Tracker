//
//  AttachmentItemView.swift
//  Education tracker
//
//  Создан Иваном Кретовым 16.05.2025.
//

import SwiftUI

/// Строка вложения с иконкой, названием и кнопкой скачивания.
///
/// Используется в `TaskDetailsView` для отображения списка привязанных файлов.
struct AttachmentItemView: View {
    // MARK: - Параметры
    /// Системное имя иконки (SF Symbols).
    let icon: String
    /// Имя файла или папки.
    let name: String
    
    // MARK: - UI
    var body: some View {
        HStack {
            // Иконка типа вложения
            Image(systemName: icon)
                .foregroundColor(.primary)
                .frame(width: 30)
            
            // Название файла
            Text(name)
                .font(.subheadline)
                .foregroundColor(.primary)
            
            Spacer()
            
            // Иконка скачивания
            Image(systemName: "arrow.down.circle.fill")
                .foregroundColor(.primary)
        }
        .padding(.vertical, 6)
        .cornerRadius(8) // Визуальное скругление при использовании списка/меню
    }
}

// MARK: - Превью
struct AttachmentItemView_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            AttachmentItemView(icon: "doc.fill", name: "Document.pdf")
            AttachmentItemView(icon: "folder.fill", name: "Assets.zip")
        }
        .padding()
        .previewLayout(.sizeThatFits)
    }
}
