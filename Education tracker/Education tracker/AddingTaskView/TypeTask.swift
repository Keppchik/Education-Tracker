//
//  TypeTask.swift
//  Education tracker
//
//  Создан Иваном Миронов 22.04.2025.
//

import SwiftUI

/// Выпадающий список выбора типа задачи (`TypeOptions`).
///
/// При тапе на строку "Type" раскрывает/сворачивает перечень всех вариантов.
/// Выбранный тип подсвечивается синим и отмечается галочкой.
/// Выбор сохраняется в привязку `selectedType`, переданную из родительского
/// экрана, а список автоматически закрывается.
struct TypeTask: View {
    // MARK: - Привязки и состояние
    /// Текущий выбранный тип задачи (двусторонняя связь с родителем).
    @Binding var selectedType: TypeOptions
    /// Флаг раскрытия списка вариантов.
    @State var ShowType: Bool = false
    
    // MARK: - UI
    var body: some View {
        // ===== Type =====
        VStack {
            // Заголовок с текущим значением
            HStack {
                Text("Type")
                Spacer()
                Text(selectedType.name)
            }
            .padding(.vertical, 10)
            .contentShape(Rectangle()) // Расширяем область тапа
            .onTapGesture {
                withAnimation(.easeInOut(duration: 0.2)) {
                    ShowType.toggle() // Раскрыть/свернуть список
                }
            }
            
            // Список всех вариантов типа
            if ShowType {
                ForEach(TypeOptions.allCases) { index in
                    HStack {
                        Spacer()
                        Text(index.name)
                            .padding(.vertical, 5)
                            .foregroundColor(selectedType == index ? .blue : .gray)
                        if selectedType == index {
                            Image(systemName: "checkmark")
                                .foregroundColor(.blue)
                        }
                    }
                    .padding(.trailing, 10)
                    .contentShape(Rectangle())
                    .onTapGesture {
                        withAnimation(.easeInOut(duration: 0.2)) {
                            selectedType = index  // Обновляем выбор
                            ShowType = false       // Закрываем список
                        }
                    }
                }
            }
        }
    }
}

// MARK: - Превью
struct PreviewWrapperType: View {
    @State private var selectedType: TypeOptions = .ToDo
    
    var body: some View {
        TypeTask(selectedType: $selectedType)
    }
}

#Preview {
    PreviewWrapperType()
}
