//
//  Actions.swift
//  Education tracker
//
//  Created by Иван Миронов on 16.05.2025.
//

import SwiftUI
import Combine

class Actions: ObservableObject {
    @Published var isAllSelected: Bool = false
    @Published var selectedLists: Set<UUID> = []
    @Published var selectedTasks: Set<UUID> = []
    
    private let listRepository = ListRepository()
    private let taskRepository = TaskRepository()
    
    func toggleSelectAll(taskLists: [ClassTaskList], tasks: [ClassTask]) {
        isAllSelected.toggle()
        if isAllSelected {
            selectedLists = Set(taskLists.map { $0.id })
            selectedTasks = Set(tasks.map { $0.id })
        } else {
            selectedLists.removeAll()
            selectedTasks.removeAll()
        }
    }
    
    func deleteSelected(taskLists: inout [ClassTaskList], tasks: inout [ClassTask]) {
        // Удаляем выбранные списки
        for list in taskLists where selectedLists.contains(list.id) {
            listRepository.deleteList(list)
        }
        
        // Удаляем выбранные задачи
        for task in tasks where selectedTasks.contains(task.id) {
            taskRepository.deleteTask(task)
        }
        
        // Обновляем данные
        taskLists = listRepository.fetchAllLists()
        tasks = taskRepository.fetchAllTasks()
        
        // Очищаем выбор
        selectedLists.removeAll()
        selectedTasks.removeAll()
        isAllSelected = false
    }
}
