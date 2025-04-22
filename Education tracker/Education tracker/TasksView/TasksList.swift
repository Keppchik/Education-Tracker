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
            }
            .scrollIndicators(.hidden)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.leading)
    }
}

#Preview {
    TasksList(myLists: .constant([
        MyListModel(name: "Name1", items: ["Item1", "Item2", "Item3", "Items4", "Items5"]),
        MyListModel(name: "Name2", items: ["Item1", "Item2", "Item3"]),
        MyListModel(name: "Name3", items: ["Item1", "Item2", "Item3"]),
        MyListModel(name: "Name4", items: ["Item1", "Item2", "Item3"]),
        MyListModel(name: "Name5", items: ["Item1", "Item2", "Item3"]),
        MyListModel(name: "Name6", items: ["Item1", "Item2", "Item3"]),
        MyListModel(name: "Name7", items: ["Item1", "Item2", "Item3"]),
        MyListModel(name: "Name8", items: ["Item1", "Item2", "Item3"])]))
}
