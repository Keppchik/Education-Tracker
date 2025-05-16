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
    
    var body: some View {
        VStack {
            Text("My Lists")
                .fontWeight(.bold)
                .frame(maxWidth: .infinity, alignment: .leading)
                .font(.system(size: 28))
            
            ScrollView {
                ForEach(myLists, id: \.id) { list in
                    ListRow(name: list.name, items: list.tasksArray)
                        .contextMenu {
                            Button {
                                //TODO: экран изменения листа
                            } label: {
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
