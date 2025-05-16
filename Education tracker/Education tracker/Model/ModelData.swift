//
//  ModelData.swift
//  Education tracker
//
//  Создан Иваном Кретовым 13.05.2025.
//

import CoreData
import SwiftUI

/// Главная точка доступа к данным приложения (слой **View‑Model**).
///
/// Содержит репозитории `TaskRepository` и `ListRepository`, кэширует все задачи
/// и списки в `@Published` массивах, уведомляя UI о любых изменениях через
/// `objectWillChange`.
/// Все публичные методы — это фасад над репозиториями, добавляющий связанные
/// операции (например, установка `parentList`) и автоматический `saveContext()`.
class ModelData: ObservableObject {
    // MARK: - Репозитории
    /// Репозиторий для операций с задачами.
    let taskRepository: TaskRepository
    /// Репозиторий для операций со списками.
    let listRepository: ListRepository
    
    // MARK: - Публично наблюдаемые коллекции
    /// Все задачи, используемые UI.
    @Published var allTasks: [ClassTask] = []
    /// Все списки задач.
    @Published var allLists: [ClassTaskList] = []
    
    // MARK: - Инициализация
    init(
        taskRepository: TaskRepository = TaskRepository(),
        listRepository: ListRepository = ListRepository()
    ) {
        self.taskRepository = taskRepository
        self.listRepository = listRepository
        fetchAllData() // Загружаем данные при старте
    }
    
    // MARK: - Загрузка данных из Core Data
    /// Получает актуальные данные из репозиториев и отправляет событие об изменении.
    func fetchAllData() {
        allTasks = taskRepository.fetchAllTasks()
        allLists = listRepository.fetchAllLists()
        objectWillChange.send()
    }
    
    // MARK: - Создание задачи
    /// Создаёт новую задачу, при необходимости добавляя её в список, и сохраняет контекст.
    func createTask(
        title: String,
        list: ClassTaskList? = nil,
        date: Date,
        description: String = "",
        type: TypeOptions,
        status: StatusOptions,
        score: Int16 = 0,
        maxScore: Int16 = 0,
        isDone: Bool = false
    ) {
        let task = taskRepository.createTask(
            title: title,
            in: list,
            date: date,
            description: description,
            type: type,
            status: status,
            score: score,
            maxScore: maxScore,
            isDone: isDone
        )
        
        if let list = list {
            // Устанавливаем обратную связь между задачей и списком
            task.parentList = list
            list.addToTasks(task)
        }
        
        saveContext()
    }
    
    // MARK: - Обновление задачи
    /// Универсальное обновление полей задачи.
    func updateTask(_ task: ClassTask, newTitle: String? = nil, isDone: Bool? = nil, newDate: Date? = nil, newStatus: StatusOptions? = nil, newDescription: String? = nil, newType: TypeOptions? = nil, newScore: Int16? = nil, newMaxScore: Int16? = nil) {
        taskRepository.updateTask(
            task,
            newTitle: newTitle,
            isDone: isDone,
            newDate: newDate,
            newDescription: newDescription,
            newType: newType,
            newStatus: newStatus,
            newScore: newScore,
            newMaxScore: newMaxScore
        )
        saveContext()
        objectWillChange.send()
    }
    
    // MARK: - Создание списка
    /// Создаёт новый список задач и возвращает его объект.
    func createList(name: String) -> ClassTaskList {
        let list = listRepository.createList(name: name)
        allLists.append(list)
        return list
    }
    
    // MARK: - Удаление объектов
    /// Удаляет задачу из хранилища.
    func deleteTask(_ task: ClassTask) {
        taskRepository.deleteTask(task)
    }
    /// Удаляет список задач из хранилища.
    func deleteList(_ list: ClassTaskList) {
        listRepository.deleteList(list)
    }
    
    // MARK: - Сохранение контекста
    /// Сохраняет изменения Core Data и перезагружает кэш.
    private func saveContext() {
        CoreDataManager.shared.saveContext()
        fetchAllData()
    }
}
