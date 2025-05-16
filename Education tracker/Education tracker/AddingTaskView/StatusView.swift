//
//  StatusView.swift
//  Education tracker
//
//  Создан Иваном Миронов 22.04.2025.
//

import SwiftUI

/// Выпадающий список для выбора статуса задачи (`StatusOptions`).
///
/// По аналогии с `TypeTask`: заголовок «Status» отображает текущий статус.
/// Тап раскрывает список всех статусов; выбранный выделен синим и помечен
/// галочкой.
/// Выбор записывается в двустороннюю привязку `selectedStatus`, после чего
/// список автоматически сворачивается.
struct StatusView: View {
    // MARK: - Привязки и состояние
    /// Текущий выбранный статус задачи.
    @Binding var selectedStatus: StatusOptions
    /// Флаг раскрытия списка статусов.
    @State var showStatus: Bool = false
    
    // MARK: - UI
    var body: some View {
        VStack {
            // Заголовок с текущим значением
            HStack {
                Text("Status")
                Spacer()
                Text(selectedStatus.name)
            }
            .padding(.vertical, 10)
            .contentShape(Rectangle())
            .onTapGesture {
                withAnimation(.easeInOut(duration: 0.2)) {
                    showStatus.toggle()
                }
            }
            // Список возможных статусов
            if showStatus {
                ForEach(StatusOptions.allCases) { index in
                    HStack {
                        Spacer()
                        Text(index.name)
                            .padding(.vertical, 5)
                            .foregroundColor(selectedStatus == index ? .blue : .gray)
                        if selectedStatus == index {
                            Image(systemName: "checkmark")
                                .foregroundColor(.blue)
                        }
                    }
                    .padding(.trailing, 10)
                    .contentShape(Rectangle())
                    .onTapGesture {
                        withAnimation(.easeInOut(duration: 0.2)) {
                            selectedStatus = index  // Обновляем привязку
                            showStatus = false       // Сворачиваем список
                        }
                    }
                }
            }
        }
    }
}

// MARK: - Превью
struct PreviewWrapperStatus: View {
    @State private var selectedStatus: StatusOptions = .ToDo
    
    var body: some View {
        StatusView(selectedStatus: $selectedStatus)
    }
}

#Preview {
    PreviewWrapperStatus()
}
