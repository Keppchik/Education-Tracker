import SwiftUI

struct HomeView: View {
    @State private var tasks: [TaskItem] = [
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
            title: "Client presentation",
            date: Calendar.current.date(bySettingHour: 10, minute: 0, second: 0, of: Date().advanced(by: 86400))!,
            score: 0,
            status: "ToDo",
            type: "Type"
        ),
        TaskItem(
            title: "Project deadline",
            date: Calendar.current.date(bySettingHour: 0, minute: 0, second: 0, of: Date().advanced(by: 86400 * 7))!,
            score: 0,
            status: "ToDo",
            type: "Type"
        ),
        TaskItem(
            title: "Quarterly review",
            date: Calendar.current.date(bySettingHour: 0, minute: 0, second: 0, of: Date().advanced(by: 86400 * 30))!,
            score: 0,
            status: "ToDo",
            type: "Type"
        )
    ]
    
    @State private var todayTasks: [TaskItem] = []
    @State private var tomorrowTasks: [TaskItem] = []
    @State private var laterTasks: [TaskItem] = []
    
    private func updateTasks() {
        todayTasks = tasks.filter { Calendar.current.isDateInToday($0.date) }
        tomorrowTasks = tasks.filter { Calendar.current.isDateInTomorrow($0.date) }
        laterTasks = tasks.filter { !Calendar.current.isDateInToday($0.date) && !Calendar.current.isDateInTomorrow($0.date) }
    }
    
    var body: some View {
        
        VStack {
            HStack {
                Text("Home")
                    .font(.title)
                    .fontWeight(.bold)
                    
                Spacer()
                    
                NavigationLink {
                    AddingTaskPageView()
                } label: {
                    Image(systemName: "plus")
                        .font(.system(size: 30))
                        .foregroundColor(.primary)
                }
            }
            .padding()
                
            ScrollView {
                if !todayTasks.isEmpty {
                    SectionView(sectionName: "TODAY", tasks: $todayTasks, sectionEnum: .today)
                }
                if !tomorrowTasks.isEmpty {
                    SectionView(sectionName: "TOMORROW", tasks: $tomorrowTasks, sectionEnum: .tomorrow)
                }
                if !laterTasks.isEmpty {
                    SectionView(sectionName: "LATER", tasks: $laterTasks, sectionEnum: .later)
                }
                if tasks.isEmpty {
                    Text("You have no tasks")
                        .font(.headline)
                        .frame(maxHeight: .infinity, alignment: .center)
                }
                Color.clear
                    .frame(height: 90)
            }
            .onAppear { updateTasks() }
            .scrollBounceBehavior(.basedOnSize)
        }
    }
}

#Preview {
    HomeView()
}
