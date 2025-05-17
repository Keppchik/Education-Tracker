//
//  EditingListView.swift
//  Education tracker
//
//  Created by Иван Кретов on 17.05.2025.
//

import SwiftUI

struct EditingListView: View {
    @State var list: ClassTaskList
    @State private var selectedTasks: Set<ClassTask> = []
    @EnvironmentObject var modelData: ModelData
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        VStack() {
            HStack {
                Button("Cancel", role: .cancel) {
                    presentationMode.wrappedValue.dismiss()
                }
                
                Spacer()
                
                Text("Edit List")
                    .font(.headline)
                
                Spacer()
                
                Button {
                    presentationMode.wrappedValue.dismiss()
                } label: {
                    Text("Done")
                }
            }
            .padding(.horizontal)
            .padding(.top, 24)
            
            ScrollView {
                ForEach(list.tasksArray, id: \.id) { task in
                    HStack {
                        Image(systemName: !selectedTasks.contains(task) ? "circle" : "checkmark.circle.fill")
                            .foregroundColor(.blue)
                        
                        Text(task.title)
                        
                        Spacer()
                    }
                    .padding(.horizontal)
                    .padding(.vertical, 4)
                    .onTapGesture {
                        if selectedTasks.contains(task) {
                            selectedTasks.remove(task)
                        } else {
                            selectedTasks.insert(task)
                        }
                    }
                    
                }
            }
            .padding(.top, 32)
            .scrollBounceBehavior(.basedOnSize)
            
            HStack {
                Menu {
                    Button(role: .destructive) {
                        for task in selectedTasks {
                            modelData.updateTask(task, newList: nil)
                        }
                    }
                    label: {
                        Label("Remove tasks from list", systemImage: "minus.circle")
                    }
                    
                    Button(role: .destructive) {
                        for task in selectedTasks {
                            modelData.allTasks.removeAll { $0.id == task.id }
                            modelData.deleteTask(task)
                        }
                    }
                    label: {
                        Label("Delete tasks", systemImage: "trash.circle")
                            .foregroundColor(.red)
                    }
                } label: {
                    Image(systemName: "trash")
                        .foregroundColor(.red)
                }
                
                Spacer()
                
                Button {
                    if selectedTasks.count == list.tasksArray.count {
                        for task in list.tasksArray {
                            selectedTasks.remove(task)
                        }
                    } else {
                        for task in list.tasksArray {
                            selectedTasks.insert(task)
                        }
                    }
                } label: {
                    Text("Select All")
                        .foregroundColor(.blue)
                }
            }
            .padding(.horizontal, 32)
        }
    }
}

#Preview {
    EditingListView(list: .init())
        .environmentObject(ModelData())
}
