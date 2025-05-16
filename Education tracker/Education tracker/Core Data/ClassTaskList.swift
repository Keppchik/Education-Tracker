//
//  ClassTaskList.swift
//  Education tracker
//
//  Создан Иваном Кретовым 13.05.2025.
//

import CoreData

/// Модель Core Data, описывающая список задач (категорию).
///
/// Содержит уникальный `id`, имя списка и отношение «один‑ко‑многим» к сущности
/// `ClassTask` через `tasks`.
@objc(ClassTaskList)
public class ClassTaskList: NSManagedObject {
    // MARK: - Атрибуты Core Data
    /// Уникальный идентификатор списка.
    @NSManaged public var id: UUID
    /// Название списка задач.
    @NSManaged public var name: String
    /// Набор связанных задач (`NSSet` содержит объекты `ClassTask`).
    @NSManaged public var tasks: NSSet?
}

extension ClassTaskList {
    /// Стандартный запрос выборки всех объектов `ClassTaskList`.
    @nonobjc public class func fetchRequest() -> NSFetchRequest<ClassTaskList> {
        return NSFetchRequest<ClassTaskList>(entityName: "ClassTaskList")
    }
}
