//
//  TasksPageView.swift
//  Education tracker
//
//  Created by Иван Кретов on 04.04.2025.
//

import SwiftUI

struct MyListModel: Hashable {
    let id: UUID = UUID()
    var name: String
    var items: [String]
}

struct TasksPageView: View {
    @State private var newListSheet = false
    @State private var newListName: String = ""
    @State private var myLists: [MyListModel] = [
        MyListModel(name: "Name1", items: ["Item1", "Item2", "Item3", "Items4", "Items5"]),
        MyListModel(name: "Name2", items: ["Item1", "Item2", "Item3"]),
        MyListModel(name: "Name3", items: ["Item1", "Item2", "Item3"]),
        MyListModel(name: "Name4", items: ["Item1", "Item2", "Item3"]),
        MyListModel(name: "Name5", items: ["Item1", "Item2", "Item3"]),
        MyListModel(name: "Name6", items: ["Item1", "Item2", "Item3"])]
        //TODO: Добавить брать из Core Data
    
    var body: some View {
        VStack {
            Menu {
                Button(action: { newListSheet = true } ) {
                    Label("Create new list", systemImage: "list.bullet")
                }

                Button(action: {}) {
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
            
            Text("Tasks")
                .font(.system(size: 32, weight: .bold))
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.leading)
            
            TasksButtons()
            
            TasksList(myLists: $myLists)
                .padding(.top)
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
                        myLists.append(MyListModel(name: newListName, items: []))
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
                            myLists.append(MyListModel(name: newListName, items: []))
                            newListName = ""
                            newListSheet = false
                        }
                    }
            }
            .padding(.top, 32)
            
            Divider()
                .padding(.horizontal)
            
            Spacer()
        }
    }
}

#Preview {
    TasksPageView()
}
