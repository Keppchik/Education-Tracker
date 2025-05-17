//
//  ClassTask.swift
//  Education tracker
//
//  Created by Иван Кретов on 13.05.2025.
//

import CoreData

@objc(ClassTask)
public class ClassTask: NSManagedObject {
    @NSManaged public var id: UUID
    @NSManaged public var title: String
    @NSManaged public var date: Date
    @NSManaged public var isDone: Bool
    @NSManaged public var type: Int16
    @NSManaged public var status: Int16
    @NSManaged public var score: Int16
    @NSManaged public var maxScore: Int16
    @NSManaged public var taskDescription: String
    @NSManaged public var list: ClassTaskList?
}

extension ClassTask {
    @nonobjc public class func fetchRequest() -> NSFetchRequest<ClassTask> {
        return NSFetchRequest<ClassTask>(entityName: "ClassTask")
    }
}
