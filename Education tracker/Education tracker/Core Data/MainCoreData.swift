//
//  MainCoreData.swift
//  Education tracker
//
//  Создан Иваном Кретовым 13.05.2025.
//

import Foundation
import CoreData

/// Синглтон‑менеджер Core Data.
///
/// Отвечает за инициализацию `NSPersistentContainer`, предоставляет общий контекст
/// (`viewContext`) и метод `saveContext()` для сохранения изменений.
class CoreDataManager {
    // MARK: - Синглтон
    /// Глобальный экземпляр менеджера.
    static let shared = CoreDataManager()
    
    // MARK: - Приватные свойства
    /// Контейнер Core Data, загружающий модель *Education_tracker.xcdatamodeld*.
    private let persistentContainer: NSPersistentContainer
    
    /// Удобный доступ к контексту `viewContext`.
    var context: NSManagedObjectContext {
        return persistentContainer.viewContext
    }
    
    // MARK: - Инициализация
    /// Приватный инициализатор: настраивает контейнер и загружает хранилища.
    private init() {
        // Имя должно совпадать с названием .xcdatamodeld
        persistentContainer = NSPersistentContainer(name: "Education_tracker")
        persistentContainer.loadPersistentStores { description, error in
            if let error = error {
                fatalError("Core Data store failed to load: \(error.localizedDescription)")
            }
        }
    }

    // MARK: - Сохранение контекста
    /// Сохраняет изменения в `viewContext`, если они есть.
    func saveContext() {
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                print("Error saving context: \(error)")
            }
        }
    }
}
