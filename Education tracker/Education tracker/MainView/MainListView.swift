//
//  MainListView.swift
//  Education tracker
//
//  Created by Иван Кретов on 04.04.2025.
//

import SwiftUI

struct MainListView: View {
    @Binding var myLists: [MyListModel]
    var body: some View {
        VStack {
            Text("My Lists")
                .fontWeight(.bold)
                .frame(maxWidth: .infinity, alignment: .leading)
                .font(.system(size: 28))
            
            ScrollView {
                LazyVStack {
                    ForEach($myLists, id: \.self) { list in
                        ListRow(name: list.name, items: list.items)
                    }
                }
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.leading)
    }
}

#Preview {
    MainListView(myLists: .constant([MyListModel(name: "Name1", items: ["Item1", "Item2", "Item3"]), MyListModel(name: "Name2", items: ["Item1", "Item2", "Item3"]), MyListModel(name: "Name3", items: ["Item1", "Item2", "Item3"]), MyListModel(name: "Name4", items: ["Item1", "Item2", "Item3"]), MyListModel(name: "Name5", items: ["Item1", "Item2", "Item3"]), MyListModel(name: "Name6", items: ["Item1", "Item2", "Item3"]), MyListModel(name: "Name7", items: ["Item1", "Item2", "Item3"]), MyListModel(name: "Name8", items: ["Item1", "Item2", "Item3"]), MyListModel(name: "Name9", items: ["Item1", "Item2", "Item3"]), MyListModel(name: "Name10", items: ["Item1", "Item2", "Item3"]), MyListModel(name: "Name11", items: ["Item1", "Item2", "Item3"]), MyListModel(name: "Name12", items: ["Item1", "Item2", "Item3"]), MyListModel(name: "Name13", items: ["Item1", "Item2", "Item3"])]))
}
