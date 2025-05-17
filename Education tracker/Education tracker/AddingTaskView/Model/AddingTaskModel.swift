//
//  AddingTaskModel.swift
//  Education tracker
//
//  Created by Иван Кретов on 26.04.2025.
//

import Foundation

enum StatusOptions: Int16, Identifiable, CaseIterable {
    case ToDo = 0
    case InProgress = 1
    case Done = 2
    
    var name: String {
        switch self {
        case .ToDo:
            return "ToDo"
        case .InProgress:
            return "In Progress"
        case .Done:
            return "Completed"
        }
    }
    var id: Int16 {
        rawValue
    }
}

enum TypeOptions: Int16, Identifiable, CaseIterable{
    case ToDo = 0
    case Meeting = 1
    case Remind = 2
    case Learn = 3
        
    var name: String {
        switch self {
        case .ToDo:
            return "To Do"
        case .Meeting:
            return "Meeting"
        case .Remind:
            return "Remind"
        case .Learn:
            return "Learn"
        
        }
    }
    var id: Int16 {
        rawValue
    }
}
