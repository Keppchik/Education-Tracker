import SwiftUI

struct HomeView: View {
    @State private var tasks: [TaskItem] = [
        TaskItem(
            title: "Team meeting",
            date: Date()
        ),
        TaskItem(
            title: "Team meeting",
            date: Date()
        ),
        TaskItem(
            title: "Client presentation",
            date: Calendar.current.date(bySettingHour: 10, minute: 0, second: 0, of: Date().advanced(by: 86400))!
        ),
        TaskItem(
            title: "Project deadline",
            date: Calendar.current.date(bySettingHour: 0, minute: 0, second: 0, of: Date().advanced(by: 86400 * 7))!
        ),
        TaskItem(
            title: "Quarterly review",
            date: Calendar.current.date(bySettingHour: 0, minute: 0, second: 0, of: Date().advanced(by: 86400 * 30))!
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
        ZStack(alignment: .bottom) {
            VStack {
                HStack {
                    Text("Home")
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundColor(.black)
                    
                    Spacer()
                    
                    Button(action: {
                        print("Plus tapped")
                    }) {
                        Image(systemName: "plus")
                            .font(.system(size: 30))
                            .foregroundColor(.black)
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
            .background(Color.white)
            
            BottomBar(selectedIndex: .house)
        }
        .edgesIgnoringSafeArea(.bottom)
    }
}

#Preview {
    HomeView()
}
