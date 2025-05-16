//
//  TasksButtons.swift
//  Education tracker
//
//  Created by Иван Кретов on 07.04.2025.
//

import SwiftUI

struct TasksButtons: View {
    @Environment(\.colorScheme) private var colorScheme
    @EnvironmentObject var modelData: ModelData
    
    var todoTasksCount: Int {
        modelData.allTasks.filter { task in
            task.status == StatusOptions.ToDo.rawValue
        }.count
    }
    var inProgressTasksCount: Int {
        modelData.allTasks.filter { task in
            task.status == StatusOptions.InProgress.rawValue
        }.count
    }
    var doneTasksCount: Int {
        modelData.allTasks.filter { task in
            task.status == StatusOptions.Done.rawValue
        }.count
    }
    
    var body: some View {
        HStack {
            Button { } //TODO: Добавить переход на страницу с заданиями
            label: {
                ZStack {
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(lineWidth: 2)
                        .opacity(colorScheme == .light ? 0.2 : 0.4)
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
                        Text("\(todoTasksCount) tasks")
                            .opacity(0.5)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.leading, 32)
                }
                .foregroundColor(.primary)
            }
            
            Button { } //TODO: Добавить переход на страницу с заданиями
            label: {
                ZStack {
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(lineWidth: 2)
                        .opacity(colorScheme == .light ? 0.2 : 0.4)
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
                        Text("\(inProgressTasksCount) tasks")
                            .opacity(0.5)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.leading, 18)
                }
                .foregroundColor(.primary)
            }
        }
        
        Button { } //TODO: Добавить переход на страницу с заданиями
        label: {
            ZStack {
                RoundedRectangle(cornerRadius: 8)
                    .stroke(lineWidth: 2)
                    .opacity(colorScheme == .light ? 0.2 : 0.4)
                    .frame(maxHeight: 130)
                    .frame(width: UIScreen.main.bounds.width / 2 - 23, alignment: .leading)
                    .padding(.leading)
                
                VStack(alignment: .leading) {
                    Image(systemName: "checkmark")
                        .font(.system(size: 24))
                    Text("Completed")
                        .fontWeight(.bold)
                        .font(.system(size: 20))
                        .padding(.top, 10)
                        .padding(.bottom, 1)
                    Text("\(doneTasksCount) tasks") 
                        .opacity(0.5)
                }
                .frame(width: UIScreen.main.bounds.width / 2 - 50, alignment: .leading)
                .padding(.leading)
            }
            .foregroundColor(.primary)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.top, 4)
    }
}

#Preview {
    TasksButtons()
        .environmentObject(ModelData())
}
