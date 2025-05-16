//
//  SectionView.swift
//  Education tracker
//
//  Создан Иваном Кретовым 21.04.2025.
//

import SwiftUI

/// Контейнер раздела задач («Сегодня», «Завтра», «Позже»).
///
/// Отображает название секции и список `TaskRow`.
/// Поддерживает «отложенное» завершение задачи: после тап‑нажатия на чекбокс
/// задача помещается в очередь `pendingDeletionIndices`; если в течение 2 секунд
/// пользователь не отменил действие, вызывается `modelData.updateTask` со
/// статусом `.Done` и происходит обновление списка через `updateTasks()`.
struct SectionView: View {
    // MARK: - Параметры
    let sectionName: String
    /// Индексы задач в очереди «будет отмечена как выполненная».
    @State private var pendingDeletionIndices = Set<Int>()
    /// Таймер обратного отсчёта перед финальным завершением.
    @State private var deletionTimer: Timer?
    /// Задачи, относящиеся к текущей секции.
    @State var tasks: [ClassTask]
    
    // MARK: - Зависимости среды
    @EnvironmentObject var modelData: ModelData
    /// Текущая секция (`today`, `tomorrow`, `later`).
    var sectionEnum: SectionEnum
    /// Колбэк родительского экрана — вызов при изменении задач.
    var updateTasks: () -> Void
    
    // MARK: - Локальная логика
    /// Обрабатывает тап на чекбокс: добавляет/убирает индекс и перезапускает таймер.
    private func tasksUpdate(index: Int) {
        if pendingDeletionIndices.contains(index) {
            // Отмена, если нажали повторно
            pendingDeletionIndices.remove(index)
        } else {
            pendingDeletionIndices.insert(index)
        }
        
        // Сброс и запуск таймера
        deletionTimer?.invalidate()
        deletionTimer = Timer.scheduledTimer(withTimeInterval: 2.0, repeats: false) { _ in
            for index in pendingDeletionIndices {
                modelData.updateTask(tasks[index], isDone: true, newStatus: .Done)
            }
            pendingDeletionIndices.removeAll()
            updateTasks()
        }
    }
    
    // MARK: - UI
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            // Заголовок секции
            Text(sectionName)
                .font(.headline)
                .padding(.horizontal)
            
            // Список задач
            ForEach(Array(tasks.enumerated()), id: \ .element.id) { index, task in
                NavigationLink {
                    TaskDetailsView(task: task)
                        .environmentObject(modelData)
                } label: {
                    TaskRow(
                        task: task,
                        sectionEnum: sectionEnum,
                        onTap: {
                            tasksUpdate(index: index)
                        }
                    )
                    // Контекстное меню удаления
                    .contextMenu {
                        Button(role: .destructive) {
                            let delTask = task
                            tasks.removeAll { $0.id == delTask.id }
                            modelData.allTasks.removeAll { $0.id == delTask.id }
                            modelData.deleteTask(delTask)
                            updateTasks()
                        } label: {
                            Label("Удалить", systemImage: "trash")
                        }
                    }
                }
            }
        }
        .padding(.vertical, 8)
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
        SectionView(
            sectionName: "Test Section",
            tasks: [task1],
            sectionEnum: .today,
            updateTasks: {}
        )
        .environmentObject(ModelData())
        .environment(\.managedObjectContext, context)
    }
}
