//
//  ClassTask.swift
//  Education tracker
//
//  Создан Иваном Кретовым 13.05.2025.
//

import CoreData

/// Модель Core Data, описывающая задачу.
///
/// Каждое свойство помечено `@NSManaged`, что позволяет Core Data генерировать
/// устойчивые геттеры/сеттеры и хранить значения в хранилище.
@objc(ClassTask)
public class ClassTask: NSManagedObject {
    // MARK: - Атрибуты Core Data
    /// Уникальный идентификатор задачи.
    @NSManaged public var id: UUID
    /// Заголовок (название) задачи.
    @NSManaged public var title: String
    /// Дата выполнения / дедлайн задачи.
    @NSManaged public var date: Date
    /// Флаг «выполнено».
    @NSManaged public var isDone: Bool
    /// Тип задачи (`TypeOptions.rawValue`).
    @NSManaged public var type: Int16
    /// Текущий статус (`StatusOptions.rawValue`).
    @NSManaged public var status: Int16
    /// Набранные баллы.
    @NSManaged public var score: Int16
    /// Максимально возможные баллы.
    @NSManaged public var maxScore: Int16
    /// Описание задачи (дополнительные детали).
    @NSManaged public var taskDescription: String
    /// Ссылка на родительский список задач.
    @NSManaged public var parentList: ClassTaskList?
}

extension ClassTask {
    /// Стандартный запрос выборки всех объектов `ClassTask`.
    @nonobjc public class func fetchRequest() -> NSFetchRequest<ClassTask> {
        return NSFetchRequest<ClassTask>(entityName: "ClassTask")
    }
}
