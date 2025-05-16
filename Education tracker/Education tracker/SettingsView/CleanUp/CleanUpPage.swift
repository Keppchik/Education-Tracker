//
//  CleanUpPage.swift
//  Education tracker
//
//  Created by Иван Миронов on 16.05.2025.
//

import SwiftUI

struct CleanUpPage: View {
    @StateObject private var actions = Actions()
    @State private var taskLists: [ClassTaskList] = []
    @State private var tasks: [ClassTask] = []
    
    var body: some View {
        NavigationView{
            VStack {
                HStack {
                    Button(action: {
                        actions.toggleSelectAll(taskLists: taskLists, tasks: tasks)
                    }) {
                        Text(actions.isAllSelected ? "Deselect All" : "Select All")
                            .foregroundColor(.blue)
                            .font(.subheadline)
                    }
                    Spacer()
                    Button(action: {
                        actions.deleteSelected(taskLists: &taskLists, tasks: &tasks)
                    }) {
                        Image(systemName: "trash")
                            .foregroundColor(.red)
                    }
                }
                .padding([.leading, .bottom, .trailing])
                
                
                ScrollView {
                    VStack(spacing: 20) {
                        // Lists
                        if !taskLists.isEmpty{
                            VStack(alignment: .leading, spacing: 8) {
                                Text("Lists")
                                    .font(.headline.bold())
                                
                                ForEach(taskLists, id: \.id) { list in
                                    HStack {
                                        Image(systemName: actions.selectedLists.contains(list.id) ? "checkmark.circle.fill" : "circle")
                                            .foregroundColor(.blue)
                                        
                                        VStack(alignment: .leading) {
                                            Text(list.name)
                                                .font(.headline)
                                            Text("\(list.tasksArray.count) tasks")
                                                .font(.subheadline)
                                                .foregroundColor(.secondary)
                                        }
                                    }
                                    .padding()
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    .background(Color(.systemGray6))
                                    .cornerRadius(10)
                                    .onTapGesture {
                                        if actions.selectedLists.contains(list.id) {
                                            actions.selectedLists.remove(list.id)
                                        } else {
                                            actions.selectedLists.insert(list.id)
                                        }
                                    }
                                }
                            }
                        }
                        
                        // Tasks
                        if !tasks.isEmpty{
                            VStack(alignment: .leading, spacing: 8) {
                                Text("Tasks")
                                    .font(.headline.bold())
                                
                                ForEach(tasks, id: \.id) { task in
                                    HStack {
                                        Image(systemName: actions.selectedTasks.contains(task.id) ? "checkmark.circle.fill" : "circle")
                                            .foregroundColor(.blue)
                                        
                                        VStack(alignment: .leading) {
                                            Text(task.title)
                                                .font(.headline)
                                            Text("Due: \(task.date.formatted())")
                                                .font(.caption)
                                                .foregroundColor(.secondary)
                                        }
                                    }
                                    .padding()
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    .background(Color(.systemGray6))
                                    .cornerRadius(10)
                                    .onTapGesture {
                                        if actions.selectedTasks.contains(task.id) {
                                            actions.selectedTasks.remove(task.id)
                                        } else {
                                            actions.selectedTasks.insert(task.id)
                                        }
                                    }
                                }
                            }
                        }
                        if taskLists.isEmpty && tasks.isEmpty {
                            Text("Nothing yet")
                                .foregroundColor(.gray)
                                .padding(.top, 50)
                        }
                    }
                }
                .scrollIndicators(.hidden)
            }
            .padding(.horizontal)
            .onAppear {
                taskLists = ListRepository().fetchAllLists()
                tasks = TaskRepository().fetchAllTasks()
            }
        }
        .navigationTitle("Clean Up")
    }
}

#Preview {
    NavigationView {
        CleanUpPage()
            .environmentObject(ModelData())
    }
}
