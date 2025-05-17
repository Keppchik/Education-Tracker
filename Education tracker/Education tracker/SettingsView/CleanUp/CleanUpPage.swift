//
//  CleanUpPage.swift
//  Education tracker
//
//  Created by Иван Миронов on 16.05.2025.
//

import SwiftUI

struct CleanUpPage: View {
    @State private var taskLists: [ClassTaskList] = []
    @State private var tasks: [ClassTask] = []
    
    @State private var selectedTasks: Set<ClassTask> = []
    @State private var selectedLists: Set<ClassTaskList> = []
    @State private var isAllSelected: Bool = false
    
    @EnvironmentObject var modelData: ModelData
    
    var body: some View {
        NavigationView{
            VStack {
                HStack {
                    Button(action: {
                        if isAllSelected {
                            for list in taskLists {
                                selectedLists.remove(list)
                            }
                            for task in tasks {
                                selectedTasks.remove(task)
                            }
                        } else {
                            for list in taskLists {
                                selectedLists.insert(list)
                            }
                            for task in tasks {
                                selectedTasks.insert(task)
                            }
                        }
                        isAllSelected.toggle()
                    }) {
                        Text(isAllSelected ? "Deselect All" : "Select All")
                            .foregroundColor(.blue)
                            .font(.subheadline)
                    }
                    Spacer()
                    Button(action: {
                        for task in selectedTasks {
                            tasks.removeAll { $0.id == task.id }
                            modelData.allTasks.removeAll { $0.id == task.id }
                            modelData.deleteTask(task)
                        }
                        for list in selectedLists {
                            taskLists.removeAll { $0.id == list.id }
                            modelData.allLists.removeAll { $0.id == list.id }
                            modelData.deleteList(list)
                        }
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
                                        Image(systemName: selectedLists.contains(list) ? "checkmark.circle.fill" : "circle")
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
                                        if selectedLists.contains(list) {
                                            selectedLists.remove(list)
                                        } else {
                                            selectedLists.insert(list)
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
                                        Image(systemName: selectedTasks.contains(task) ? "checkmark.circle.fill" : "circle")
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
                                        if selectedTasks.contains(task) {
                                            selectedTasks.remove(task)
                                        } else {
                                            selectedTasks.insert(task)
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
                taskLists = modelData.allLists
                tasks = modelData.allTasks
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
