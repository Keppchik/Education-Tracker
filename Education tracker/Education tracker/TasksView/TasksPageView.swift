//
//  TasksPageView.swift
//  Education tracker
//
//  Created by Иван Кретов on 04.04.2025.
//

import SwiftUI

struct TasksPageView: View {
    @EnvironmentObject var modelData: ModelData
    @State private var newListSheet = false
    @State private var newListName: String = ""
    @State private var myLists: [ClassTaskList]
    init() {
        _myLists = State(initialValue: [])
    }
    
    @State private var showAddTaskView = false
    
    private func deleteList(list: ClassTaskList) {
        myLists.removeAll { $0.id == list.id }
    }
    
    var body: some View {        
        VStack {
            Menu {
                Button(action: { newListSheet = true }) {
                    Label("Create new list", systemImage: "list.bullet")
                }
                
                Button(action: { showAddTaskView = true }) {
                    Label("Create new task", systemImage: "square.and.pencil")
                }
            } label: {
                Image(systemName: "plus")
                    .font(.system(size: 32))
                    .foregroundColor(.primary)
            }
            .frame(maxWidth: .infinity, alignment: .trailing)
            .padding(.trailing, 32)
            .padding(.vertical, 8)
            .background(
                NavigationLink(destination: AddingTaskPageView().environmentObject(modelData), isActive: $showAddTaskView) {}
            )
            
            Text("Tasks")
                .font(.system(size: 32, weight: .bold))
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.leading)
            
            TasksButtons()
                .environmentObject(modelData)
            
            TasksList(myLists: $myLists)
                .environmentObject(modelData)
                .padding(.top)
        }
        .onAppear() {
            myLists = modelData.allLists
        }
        .sheet(isPresented: $newListSheet) {
            VStack(alignment: .center, spacing: 16) {
                HStack {
                    Button { newListSheet = false }
                    label: {
                        Text("Cancel")
                    }
                    .padding(.leading)
                    
                    Spacer()
                    
                    Text("New List")
                        .fontWeight(.bold)
                    
                    Spacer()
                    
                    Button {
                        myLists.append(modelData.createList(name: newListName))
                        newListName = ""
                        newListSheet = false
                    }
                    label: {
                        Text("Create")
                    }
                    .disabled(newListName.isEmpty)
                    .padding(.trailing)
                }
                ZStack {
                    if newListName.isEmpty {
                        Text("List Name")
                            .foregroundColor(.gray)
                            .font(.headline)
                            .padding(.top, 32)
                    }
                    TextField("", text: $newListName)
                        .font(.headline)
                        .multilineTextAlignment(.center)
                        .padding(.top, 32)
                        .onSubmit {
                            if newListName.isEmpty {
                                return
                            }
                            myLists.append(modelData.createList(name: newListName))
                            newListName = ""
                            newListSheet = false
                        }
                    }
            }
            .presentationDetents([.fraction(0.3)])
            .padding(.top, 32)
            
            Divider()
                .padding(.horizontal)
            
            Spacer()
        }
    }
}

#Preview {
    TasksPageView()
        .environmentObject(ModelData())
}
