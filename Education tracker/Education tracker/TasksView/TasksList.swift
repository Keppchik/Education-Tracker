//
//  TasksList.swift
//  Education tracker
//
//  Created by Иван Кретов on 04.04.2025.
//

import SwiftUI

struct TasksList: View {
    @Binding var myLists: [ClassTaskList]
    @EnvironmentObject var modelData: ModelData
    @State private var showEditingListView: Bool = false
    @State private var editingList: ClassTaskList? = nil
    
    var body: some View {
        VStack {
            Text("My Lists")
                .fontWeight(.bold)
                .frame(maxWidth: .infinity, alignment: .leading)
                .font(.system(size: 28))
            
            ScrollView {
                ForEach($myLists, id: \.id) { $list in
                    ListRow(
                        name: $list.name,
                        items: Binding(
                            get: { list.tasksArray },
                            set: { newTasks in
                                newTasks.forEach { task in
                                    modelData.updateTask(
                                        task,
                                        newList: list
                                    )
                                }
                            }
                        )
                    )
                    .contextMenu {
                        Button(action: { editingList = list }) {
                            Label("Редактировать", systemImage: "pencil")
                        }
                            
                        Button(role: .destructive) {
                            let delList = list
                            myLists.removeAll { $0.id == delList.id }
                            modelData.allLists.removeAll { $0.id == delList.id }
                            modelData.deleteList(delList)
                        } label: {
                            Label("Удалить", systemImage: "trash")
                        }
                    }
                    .sheet(item: $editingList) { list in
                        EditingListView(list: list)
                            .environmentObject(modelData)
                    }
                }
                Color.clear
                    .frame(height: 80)
            }
            .scrollIndicators(.hidden)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.leading)
    }
}

#Preview {
    TasksList(myLists: .constant([]))
        .environmentObject(ModelData())
}
