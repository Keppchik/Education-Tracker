//
//  TaskListModel.swift
//  Education tracker
//
//  Создан Иваном Кретовым 13.05.2025.
//

import CoreData
import Foundation

/// Репозиторий для сущности `ClassTaskList` (списки задач).
///
/// Инкапсулирует операции создания, получения и удаления списков, работая
/// напрямую с `NSManagedObjectContext`. Используется `CoreDataManager.shared`
/// для сохранения изменений.
/// Расширения внизу файла добавляют удобные методы управления отношением
/// «список — задачи» и вычисляемое свойство `tasksArray` с сортировкой.
class ListRepository {
    // MARK: - Контекст Core Data
    private let context: NSManagedObjectContext
    
    init(context: NSManagedObjectContext = CoreDataManager.shared.context) {
        // Храним ссылку на общий контекст, позволяем передать иной (для тестов).
        self.context = CoreDataManager.shared.context
    }
    
    // MARK: - CRUD операции
    /// Создаёт новый список задач и сохраняет контекст.
    func createList(name: String) -> ClassTaskList {
        let list = ClassTaskList(context: context)
        list.id = UUID()
        list.name = name
        CoreDataManager.shared.saveContext()
        return list
    }
    
    /// Получает все списки, сортировка не применялась (можно добавить позже).
    func fetchAllLists() -> [ClassTaskList] {
        let request: NSFetchRequest<ClassTaskList> = ClassTaskList.fetchRequest()
        
        do {
            return try context.fetch(request)
        } catch {
            print("Error fetching lists: \(error)")
            return []
        }
    }
    
    /// Удаляет список и сохраняет изменения.
    func deleteList(_ list: ClassTaskList) {
        context.delete(list)
        CoreDataManager.shared.saveContext()
    }
}

// MARK: - Расширение: управление отношением «список — задачи»
extension ClassTaskList {
    @objc(addTasksObject:)
    @NSManaged public func addToTasks(_ value: ClassTask)

    @objc(removeTasksObject:)
    @NSManaged public func removeFromTasks(_ value: ClassTask)

    @objc(addTasks:)
    @NSManaged public func addToTasks(_ values: NSSet)

    @objc(removeTasks:)
    @NSManaged public func removeFromTasks(_ values: NSSet)
}

// MARK: - Расширение: вычисляемое свойство удобного массива задач
extension ClassTaskList {
    /// Отсортированный массив связанных задач: невыполненные сначала, по дате.
    var tasksArray: [ClassTask] {
        if let tasks = tasks?.allObjects as? [ClassTask] {
            return tasks.sorted {
                if $0.isDone != $1.isDone {
                    return !$0.isDone && $1.isDone
                }
                return $0.date < $1.date
            }
        }
        return []
    }
}
