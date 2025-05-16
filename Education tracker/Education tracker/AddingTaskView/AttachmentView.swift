//
//  AttachmentView.swift
//  Education tracker
//
//  Создан Иваном Миронов 22.04.2025.
//

import SwiftUI

/// Кнопка для добавления/просмотра вложений.
///
/// Сейчас содержит иконку «paperclip» и текст «Attachment». Реальное действие
/// (открыть файловый менеджер или галерею) помечено `TODO` и будет добавлено
/// позже.
struct AttachmentView: View {
    var body: some View {
        Button(action: {}) {
            HStack {
                Text("Attachment")
                    .foregroundColor(.primary)
                Spacer()
                Image(systemName: "paperclip")
                    .foregroundColor(.primary)
            }
        }
    }
}

// MARK: - Превью
#Preview {
    AttachmentView()
}
