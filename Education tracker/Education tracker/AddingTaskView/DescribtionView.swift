//
//  DescribtionView.swift
//  Education tracker
//
//  Создан Иваном Миронов 23.04.2025.
//

import SwiftUI

/// Поле ввода описания задачи на основе `TextEditor`.
///
/// Отображает многострочное текстовое поле с placeholder‑текстом
/// «Description», который пропадает при вводе. Высота поля ограничена от 200 до
/// 500 поинтов, фон слегка серый для визуального выделения.
struct DescribtionView: View {
    // MARK: - Привязка
    /// Двустороннее связывание текста описания.
    @Binding var descriptionText: String
    
    // MARK: - UI
    var body: some View {
        ZStack(alignment: .topLeading) {
            // Многострочный редактор
            TextEditor(text: $descriptionText)
                .frame(minHeight: 200, maxHeight: 500)
                .frame(maxWidth: .infinity)
                .padding()
                .background(Color.gray.opacity(0.2))
                .cornerRadius(10)
                .scrollContentBackground(.hidden) // Убираем системный фон
            
            // Placeholder, показывается только при пустом тексте
            if descriptionText.isEmpty {
                Text("Description")
                    .foregroundColor(Color(.placeholderText))
                    .padding(.horizontal, 21)
                    .padding(.vertical, 23)
            }
        }
    }
}

// MARK: - Превью
struct PreviewWrapperDescribtion: View {
    @State private var text = ""
    var body: some View {
        DescribtionView(descriptionText: $text)
    }
}

#Preview {
    PreviewWrapperDescribtion()
}
