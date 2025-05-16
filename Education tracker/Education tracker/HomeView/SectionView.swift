//
//  SectionView.swift
//  Education tracker
//
//  Created by Иван Кретов on 21.04.2025.
//

import SwiftUI

struct SectionView: View {
    let sectionName: String
    @State private var pendingDeletionIndices = Set<Int>()
    @State private var deletionTimer: Timer?
    @Binding var tasks: [ClassTask]

    @EnvironmentObject var modelData: ModelData
    var sectionEnum: SectionEnum
    var updateTasks: () -> Void
    
    private func tasksUpdate(index: Int) {
        if pendingDeletionIndices.contains(index) {
            pendingDeletionIndices.remove(index)
        } else {
            pendingDeletionIndices.insert(index)
        }
            
        deletionTimer?.invalidate() 
            
        deletionTimer = Timer.scheduledTimer(withTimeInterval: 2.0, repeats: false) { _ in
            for index in pendingDeletionIndices {
                if tasks[index].isDone {
                    modelData.updateTask(tasks[index], isDone: false, newStatus: .ToDo)
                } else {
                    modelData.updateTask(tasks[index], isDone: true, newStatus: .Done)
                }
            }
            pendingDeletionIndices.removeAll()
            updateTasks()
        }
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(sectionName)
                .font(.headline)
                .padding(.horizontal)
            
            ForEach(Array(tasks.enumerated()), id: \.element.id) { index, task in
                NavigationLink {
                    TaskDetailsView(task: task)
                        .environmentObject(modelData)
                } label: {
                    TaskRow(
                        task: task,
                        sectionEnum: sectionEnum,
                        onTap: {
                            tasksUpdate(index: index)
                        }
                    )
                    .contextMenu {
                        Button(role: .destructive) {
                            let delTask = task
                            tasks.removeAll { $0.id == delTask.id }
                            modelData.allTasks.removeAll { $0.id == delTask.id }
                            modelData.deleteTask(delTask)
                            updateTasks()
                        } label: {
                            Label("Удалить", systemImage: "trash")
                        }
                    }
                }
            }
        }
        .padding(.vertical, 8)
    }
}

#Preview {
    let context = CoreDataManager.shared.context
    
    let task1 = ClassTask(context: context)
    task1.id = UUID()
    task1.title = "Test Task 1"
    task1.date = Date()
    task1.type = TypeOptions.ToDo.rawValue
    task1.status = StatusOptions.ToDo.rawValue
    task1.score = 0
    task1.maxScore = 10
    task1.taskDescription = "Test description 1"
    task1.isDone = false
    
    return NavigationView {
        SectionView(
            sectionName: "Test Section",
            tasks: .constant([task1]),
            sectionEnum: .today,
            updateTasks: {}
        )
        .environmentObject(ModelData())
        .environment(\.managedObjectContext, context)
    }
}
