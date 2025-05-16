//
//  ModelData.swift
//  Education tracker
//
//  Created by Иван Кретов on 13.05.2025.
//

import CoreData
import SwiftUI

class ModelData: ObservableObject {
    let taskRepository: TaskRepository
    let listRepository: ListRepository
    
    @Published var allTasks: [ClassTask] = []
    @Published var allLists: [ClassTaskList] = []
    
    init(
        taskRepository: TaskRepository = TaskRepository(),
        listRepository: ListRepository = ListRepository()
    ) {
        self.taskRepository = taskRepository
        self.listRepository = listRepository
        fetchAllData()
    }
    
    func fetchAllData() {
        allTasks = taskRepository.fetchAllTasks()
        allLists = listRepository.fetchAllLists()
        objectWillChange.send()
    }
    
    func createTask(
        title: String,
        list: ClassTaskList? = nil,
        date: Date,
        description: String = "",
        type: TypeOptions,
        status: StatusOptions,
        score: Int16 = 0,
        maxScore: Int16 = 0,
        isDone: Bool = false
    ) {
        let task = taskRepository.createTask(
            title: title,
            in: list,
            date: date,
            description: description,
            type: type,
            status: status,
            score: score,
            maxScore: maxScore,
            isDone: isDone
        )
        
        if let list = list {
            task.parentList = list
            list.addToTasks(task)
        }
        
        saveContext()
    }
    
    func updateTask(_ task: ClassTask, newTitle: String? = nil, isDone: Bool? = nil, newDate: Date? = nil, newStatus: StatusOptions? = nil, newDescription: String? = nil, newType: TypeOptions? = nil, newScore: Int16? = nil, newMaxScore: Int16? = nil) {
        taskRepository.updateTask(
            task,
            newTitle: newTitle,
            isDone: isDone,
            newDate: newDate,
            newDescription: newDescription,
            newType: newType,
            newStatus: newStatus,
            newScore: newScore,
            newMaxScore: newMaxScore
        )
        saveContext()
        objectWillChange.send()
    }
    
    func createList(name: String) -> ClassTaskList {
        let list = listRepository.createList(name: name)
        allLists.append(list)
        return list
    }
    
    func deleteTask(_ task: ClassTask) {
        taskRepository.deleteTask(task)
    }
    
    func deleteList(_ list: ClassTaskList) {
        listRepository.deleteList(list)
    }
    
    private func saveContext() {
        CoreDataManager.shared.saveContext()
        fetchAllData()
    }
}
