//
//  StatusTasksView.swift
//  Education tracker
//
//  Created by Иван Кретов on 16.05.2025.
//

import SwiftUI

struct StatusTasksView: View {
    var status: StatusOptions
    
    @EnvironmentObject var modelData: ModelData
    @State private var tasks: [ClassTask]
    init(status: StatusOptions) {
        _tasks = State(initialValue: [])
        self.status = status
    }
    
    @State private var todayTasks: [ClassTask] = []
    @State private var tomorrowTasks: [ClassTask] = []
    @State private var laterTasks: [ClassTask] = []
    
    private func updateTasks() {
        tasks = modelData.allTasks
        let filteredTasks = tasks.filter { (!$0.isDone || ($0.isDone && $0.status == StatusOptions.Done.rawValue)) && $0.status == status.rawValue }
        
        todayTasks = filteredTasks.filter {  Calendar.current.isDateInToday($0.date)}
        tomorrowTasks = filteredTasks.filter { Calendar.current.isDateInTomorrow($0.date) }
        laterTasks = filteredTasks.filter { !Calendar.current.isDateInToday($0.date) && !Calendar.current.isDateInTomorrow($0.date) }
    }
    
    var body: some View {
        VStack {
            HStack {
                Text(status.name)
                    .font(.title)
                    .fontWeight(.bold)
                    
                Spacer()
                    
                NavigationLink {
                    AddingTaskPageView(selectedStatus: status)
                        .environmentObject(modelData)
                } label: {
                    Image(systemName: "plus")
                        .font(.system(size: 30))
                        .foregroundColor(.primary)
                }
            }
            .padding()
                
            ScrollView {
                if !todayTasks.isEmpty {
                    SectionView(sectionName: "TODAY", tasks: $todayTasks, sectionEnum: .today, updateTasks: updateTasks)
                        .environmentObject(modelData)
                }
                if !tomorrowTasks.isEmpty {
                    SectionView(sectionName: "TOMORROW", tasks: $tomorrowTasks, sectionEnum: .tomorrow, updateTasks: updateTasks)
                        .environmentObject(modelData)
                }
                if !laterTasks.isEmpty {
                    SectionView(sectionName: "LATER", tasks: $laterTasks, sectionEnum: .later, updateTasks: updateTasks)
                        .environmentObject(modelData)
                }
                if todayTasks.isEmpty && tomorrowTasks.isEmpty && laterTasks.isEmpty {
                    Text("You have no \(status.name) tasks")
                        .font(.headline)
                        .frame(maxHeight: .infinity, alignment: .center)
                }
                Color.clear
                    .frame(height: 90)
            }
            .scrollBounceBehavior(.basedOnSize)
        }
        .onAppear {
            updateTasks()
        }
    }
}

#Preview {
    NavigationView {
        StatusTasksView(status: .ToDo)
            .environmentObject(ModelData())
    }
}
