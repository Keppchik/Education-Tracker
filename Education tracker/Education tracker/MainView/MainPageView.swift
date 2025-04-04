//
//  MainPageView.swift
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

struct MainPageView: View {
    
    @State private var myLists: [MyListModel] = [MyListModel(name: "Name1", items: ["Item1", "Item2", "Item3"]), MyListModel(name: "Name2", items: ["Item1", "Item2", "Item3"]), MyListModel(name: "Name3", items: ["Item1", "Item2", "Item3"]), MyListModel(name: "Name4", items: ["Item1", "Item2", "Item3"]), MyListModel(name: "Name5", items: ["Item1", "Item2", "Item3"]), MyListModel(name: "Name6", items: ["Item1", "Item2", "Item3"]), MyListModel(name: "Name7", items: ["Item1", "Item2", "Item3"]), MyListModel(name: "Name8", items: ["Item1", "Item2", "Item3"]), MyListModel(name: "Name9", items: ["Item1", "Item2", "Item3"]), MyListModel(name: "Name10", items: ["Item1", "Item2", "Item3"]), MyListModel(name: "Name11", items: ["Item1", "Item2", "Item3"]), MyListModel(name: "Name12", items: ["Item1", "Item2", "Item3"]), MyListModel(name: "Name13", items: ["Item1", "Item2", "Item3"])] //TODO: Добавить брать из Core Data
    
    var body: some View {
        VStack {
            Button {
                //TODO: Добавить функционал добавления задачи
            }
            label: {
                Image(systemName: "plus")
                    .font(.system(size: 32))
                    .foregroundColor(.black)
                    .frame(width: 64, height: 64)
                    .frame(maxWidth: .infinity, alignment: .trailing)
                    .padding(.trailing)
                }
            
            
            Text("Tasks")
                .font(.system(size: 32, weight: .bold))
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.leading)
            
            HStack {
                Button { }
                label: {
                    ZStack {
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(style: .init(lineWidth: 2))
                            .opacity(0.2)
                            .frame(maxWidth: .infinity, maxHeight: 130)
                            .padding(.leading)
                            .padding(.trailing, 3)
                        
                        VStack(alignment: .leading) {
                            Image(systemName: "arrow.down")
                                .font(.system(size: 24))
                            Text("Todo")
                                .fontWeight(.bold)
                                .font(.system(size: 20))
                                .padding(.top, 10)
                                .padding(.bottom, 1)
                            Text("4 tasks") //TODO: Писать кол-во таксов из Core Data
                                .opacity(0.5)
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.leading, 32)
                    }
                    .foregroundStyle(.black)
                }
                
                Button { } //TODO: Добавить переход на страницу с заданиями
                label: {
                    ZStack {
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(style: .init(lineWidth: 2))
                            .opacity(0.2)
                            .frame(maxWidth: .infinity, maxHeight: 130)
                            .padding(.trailing)
                            .padding(.leading, 3)
                        
                        VStack(alignment: .leading) {
                            Image(systemName: "arrow.right")
                                .font(.system(size: 24))
                            Text("In Progress")
                                .fontWeight(.bold)
                                .font(.system(size: 20))
                                .padding(.top, 10)
                                .padding(.bottom, 1)
                            Text("2 tasks") //TODO: Писать кол-во таксов из Core Data
                                .opacity(0.5)
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.leading, 18)
                    }
                    .foregroundStyle(.black)
                }
            }
            
            Button { }
            label: {
                ZStack {
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(style: .init(lineWidth: 2))
                        .opacity(0.2)
                        .frame(maxWidth: UIScreen.main.bounds.width / 2 - 23, maxHeight: 130, alignment: .leading)
                        .padding(.leading)
                    
                    VStack(alignment: .leading) {
                        Image(systemName: "checkmark")
                            .font(.system(size: 24))
                        Text("Completed")
                            .fontWeight(.bold)
                            .font(.system(size: 20))
                            .padding(.top, 10)
                            .padding(.bottom, 1)
                        Text("1 tasks") //TODO: Писать кол-во таксов из Core Data
                            .opacity(0.5)
                    }
                    .frame(maxWidth: UIScreen.main.bounds.width / 2 - 50, alignment: .leading)
                    .padding(.leading)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .foregroundStyle(.black)
            }
            
            MainListView(myLists: $myLists)
                .padding(.top)
            
            Spacer()
            
            HStack {
                Button { }
                label: {
                    ZStack {
                        RoundedRectangle(cornerRadius: 12)
                            .fill(Color.blue)
                            .frame(maxHeight: 50)
                        Text("New Reminder")
                            .font(.system(size: 17, weight: .medium))
                            .foregroundStyle(.white)
                    }
                }
                
                Button { }
                label: {
                    ZStack {
                        RoundedRectangle(cornerRadius: 12)
                            .fill(Color.gray)
                            .opacity(0.25)
                            .frame(maxHeight: 50)
                        Text("Create List")
                            .font(.system(size: 17, weight: .medium))
                            .foregroundStyle(.black)
                    }
                }
            }
            .padding(.horizontal)
        }
    }
}

#Preview {
    MainPageView()
}
