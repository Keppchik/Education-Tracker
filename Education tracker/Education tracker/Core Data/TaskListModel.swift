//
//  TaskListModel.swift
//  Education tracker
//
//  Created by Иван Кретов on 13.05.2025.
//

import CoreData
import Foundation

class ListRepository {
    private let context: NSManagedObjectContext
    
    init(context: NSManagedObjectContext = CoreDataManager.shared.context) {
        self.context = CoreDataManager.shared.context
    }
    
    func createList(name: String) -> ClassTaskList {
        let list = ClassTaskList(context: context)
        list.id = UUID()
        list.name = name
        CoreDataManager.shared.saveContext()
        return list
    }
    
    func fetchAllLists() -> [ClassTaskList] {
        let request: NSFetchRequest<ClassTaskList> = ClassTaskList.fetchRequest()
        
        do {
            return try context.fetch(request)
        } catch {
            print("Error fetching lists: \(error)")
            return []
        }
    }
    
    func deleteList(_ list: ClassTaskList) {
        context.delete(list)
        CoreDataManager.shared.saveContext()
    }
}

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


extension ClassTaskList {
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
