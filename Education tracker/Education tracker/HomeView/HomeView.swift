import SwiftUI

struct HomeView: View {
    @EnvironmentObject var modelData: ModelData
    @Binding private var tasks: [ClassTask]
    init(tasks: Binding<[ClassTask]>) {
        self._tasks = tasks
    }
    
    @State private var todayTasks: [ClassTask] = []
    @State private var tomorrowTasks: [ClassTask] = []
    @State private var laterTasks: [ClassTask] = []
    
    private func updateTasks() {
        tasks = modelData.allTasks
        let filteredTasks = tasks.filter { !$0.isDone }
        todayTasks = filteredTasks.filter { Calendar.current.isDateInToday($0.date) }
        tomorrowTasks = filteredTasks.filter { Calendar.current.isDateInTomorrow($0.date) }
        laterTasks = filteredTasks.filter { !Calendar.current.isDateInToday($0.date) && !Calendar.current.isDateInTomorrow($0.date) }
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
                if tasks.filter({ !$0.isDone }).isEmpty {
                    Text("You have no tasks")
                        .font(.headline)
                        .frame(maxHeight: .infinity, alignment: .center)
                }
                Color.clear
                    .frame(height: 90)
            }
            .onAppear {
                updateTasks()
            }
            .scrollBounceBehavior(.basedOnSize)
        }
    }
}

#Preview {
    HomeView(tasks: .constant([]))
        .environmentObject(ModelData())
}
