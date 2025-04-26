//
//  AddingTaskModel.swift
//  Education tracker
//
//  Created by Иван Кретов on 26.04.2025.
//

import Foundation

enum StatusOptions:  Int, Identifiable, CaseIterable {
    case ToDo
    case InProgress
    case Done
    
    var name: String {
        switch self {
        case .ToDo:
            return "To Do"
        case .InProgress:
            return "In Progress"
        case .Done:
            return "Done"
        }
    }
    var id: Int {
        rawValue
    }
}

enum TypeOptions: Int, Identifiable, CaseIterable{
    case ToDo
    case Meeting
    case Remind
    case Learn
        
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
    var id: Int{
        rawValue
    }
}
