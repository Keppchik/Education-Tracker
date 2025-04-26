//
//  TasksList.swift
//  Education tracker
//
//  Created by Иван Кретов on 04.04.2025.
//

import SwiftUI

struct TasksList: View {
    @Binding var myLists: [MyListModel]
    var body: some View {
        VStack {
            Text("My Lists")
                .fontWeight(.bold)
                .frame(maxWidth: .infinity, alignment: .leading)
                .font(.system(size: 28))
            
            ScrollView {
                ForEach($myLists, id: \.self) { list in
                    ListRow(name: list.name, items: list.items)
                        .animation(.default, value: 0)
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
    TasksList(myLists: .constant([
        MyListModel(name: "Name1", items: [
            TaskItem(
                title: "Team meeting",
                date: Date(),
                score: 0,
                status: "ToDo",
                type: "Type"
            ),
            TaskItem(
                title: "Team meeting",
                date: Date(),
                score: 0,
                status: "ToDo",
                type: "Type"
            ),
            TaskItem(
                title: "Team meeting",
                date: Date(),
                score: 0,
                status: "ToDo",
                type: "Type"
            ),
            TaskItem(
                title: "Team meeting",
                date: Date(),
                score: 0,
                status: "ToDo",
                type: "Type"
            )
        ]),
        MyListModel(name: "Name2", items: [
            TaskItem(
                title: "Team meeting",
                date: Date(),
                score: 0,
                status: "ToDo",
                type: "Type"
            ),
            TaskItem(
                title: "Team meeting",
                date: Date(),
                score: 0,
                status: "ToDo",
                type: "Type"
            ),
            TaskItem(
                title: "Team meeting",
                date: Date(),
                score: 0,
                status: "ToDo",
                type: "Type"
            ),
            TaskItem(
                title: "Team meeting",
                date: Date(),
                score: 0,
                status: "ToDo",
                type: "Type"
            )
        ]),
        MyListModel(name: "Name7", items: [
            TaskItem(
                title: "Team meeting",
                date: Date(),
                score: 0,
                status: "ToDo",
                type: "Type"
            ),
            TaskItem(
                title: "Team meeting",
                date: Date(),
                score: 0,
                status: "ToDo",
                type: "Type"
            ),
            TaskItem(
                title: "Team meeting",
                date: Date(),
                score: 0,
                status: "ToDo",
                type: "Type"
            ),
            TaskItem(
                title: "Team meeting",
                date: Date(),
                score: 0,
                status: "ToDo",
                type: "Type"
            )
        ]),
        MyListModel(name: "Name8", items: [
            TaskItem(
                title: "Team meeting",
                date: Date(),
                score: 0,
                status: "ToDo",
                type: "Type"
            ),
            TaskItem(
                title: "Team meeting",
                date: Date(),
                score: 0,
                status: "ToDo",
                type: "Type"
            ),
            TaskItem(
                title: "Team meeting",
                date: Date(),
                score: 0,
                status: "ToDo",
                type: "Type"
            ),
            TaskItem(
                title: "Team meeting",
                date: Date(),
                score: 0,
                status: "ToDo",
                type: "Type"
            )
        ])]))
}
