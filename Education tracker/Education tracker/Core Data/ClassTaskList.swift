//
//  ClassTaskList.swift
//  Education tracker
//
//  Created by Иван Кретов on 13.05.2025.
//

import CoreData

@objc(ClassTaskList)
public class ClassTaskList: NSManagedObject {
    @NSManaged public var id: UUID
    @NSManaged public var name: String
    @NSManaged public var tasks: NSSet?
}

extension ClassTaskList {
    @nonobjc public class func fetchRequest() -> NSFetchRequest<ClassTaskList> {
        return NSFetchRequest<ClassTaskList>(entityName: "ClassTaskList")
    }
}
