//
//  TaskModel.swift
//  Education tracker
//
//  Created by Иван Кретов on 13.05.2025.
//

import Foundation
import CoreData

import Foundation
import CoreData

class TaskRepository {
    private let context: NSManagedObjectContext
    
    init(context: NSManagedObjectContext = CoreDataManager.shared.context) {
        self.context = context
    }
    
    
    func createTask(title: String, in list: ClassTaskList? = nil, date: Date, description: String, type: TypeOptions, status: StatusOptions, score: Int16, maxScore: Int16, isDone: Bool) -> ClassTask {
        let task = ClassTask(context: context)
        task.id = UUID()
        task.title = title
        task.date = date
        task.taskDescription = description
        task.type = type.rawValue
        task.status = status.rawValue
        task.score = score
        task.maxScore = maxScore
        task.isDone = isDone
        
        do {
            try context.save()
        } catch {
            print("Failed to save task: \(error)")
        }
        
        return task
    }

    func fetchAllTasks() -> [ClassTask] {
        let request: NSFetchRequest<ClassTask> = ClassTask.fetchRequest()
        
        do {
            return try context.fetch(request)
        } catch {
            print("Fetch failed: \(error)")
            return []
        }
    }
    
    func updateTask(_ task: ClassTask, newTitle: String? = nil, isDone: Bool? = nil, newDate: Date? = nil, newDescription: String? = nil, newType: TypeOptions? = nil, newStatus: StatusOptions? = nil, newScore: Int16? = nil, newMaxScore: Int16? = nil) {
        if let newTitle = newTitle { task.title = newTitle }
        if let isDone = isDone { task.isDone = isDone }
        if let newDate = newDate { task.date = newDate }
        if let newDescription = newDescription { task.taskDescription = newDescription }
        if let newType = newType { task.type = newType.rawValue }
        if let newStatus = newStatus { task.status = newStatus.rawValue }
        if let newScore = newScore { task.score = newScore }
        if let newMaxScore = newMaxScore { task.maxScore = newMaxScore }
        
        CoreDataManager.shared.saveContext()
    }
    
    func deleteTask(_ task: ClassTask) {
        context.delete(task)
        CoreDataManager.shared.saveContext()
    }
}
