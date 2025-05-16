//
//  TasksList.swift
//  Education tracker
//
//  Создан Иваном Кретовым 04.04.2025.
//

import SwiftUI

/// Виджет, отвечающий за отображение всех пользовательских списков задач.
///
/// `TasksList` принимает массив `ClassTaskList` по привязке (`@Binding`) и
/// отображает его в виде вертикального списка (`ScrollView`).
/// Для каждой строки используется `ListRow`, к которому привязано контекстное меню
/// с действиями «Редактировать» (пока `TODO`) и «Удалить».
/// При удалении элемент убирается как из локального массива `myLists`, так и из
/// глобального хранилища `modelData`, после чего вызывается метод
/// `modelData.deleteList(_:)` для финального удаления из базы.
struct TasksList: View {
    // MARK: - Привязки и зависимости
    /// Списки задач, переданные из родительского экрана.
    @Binding var myLists: [ClassTaskList]
    
    /// Глобальная модель данных приложения.
    @EnvironmentObject var modelData: ModelData
    
    // MARK: - UI
    var body: some View {
        VStack {
            // Заголовок секции
            Text("My Lists")
                .fontWeight(.bold)
                .frame(maxWidth: .infinity, alignment: .leading)
                .font(.system(size: 28))
            
            // Прокручиваемая область со списками
            ScrollView {
                ForEach(myLists, id: \ .id) { list in
                    // Каждая строка списка
                    ListRow(name: list.name, items: list.tasksArray)
                        .contextMenu {
                            // TODO: экран изменения листа
                            Button {
                                // Переход на экран редактирования будет реализован позже
                            } label: {
                                Label("Редактировать", systemImage: "pencil")
                            }
                            
                            // Действие удаления списка
                            Button(role: .destructive) {
                                let delList = list
                                myLists.removeAll { $0.id == delList.id }
                                modelData.allLists.removeAll { $0.id == delList.id }
                                modelData.deleteList(delList)
                            } label: {
                                Label("Удалить", systemImage: "trash")
                            }
                        }
                }
                // Пустой цветной блок для отступа внизу
                Color.clear
                    .frame(height: 80)
            }
            .scrollIndicators(.hidden) // Скрываем индикаторы прокрутки
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.leading)
    }
}

#Preview {
    TasksList(myLists: .constant([]))
        .environmentObject(ModelData())
}
