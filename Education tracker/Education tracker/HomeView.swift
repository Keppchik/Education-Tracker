import SwiftUI

struct HomeView: View {
    @State var todayTasks: [TaskItem] = [
    
        TaskItem(title: "Team meeting", date: Calendar.current.date(bySettingHour: 14, minute: 0, second: 0, of: Date())!),
        TaskItem(title: "Submit report", date: Calendar.current.date(bySettingHour: 16, minute: 30, second: 0, of: Date())!)
    ]
    
    @State var tomorrowTasks: [TaskItem] = [
        TaskItem(title: "Client presentation", date: Calendar.current.date(bySettingHour: 10, minute: 0, second: 0, of: Date().advanced(by: 86400))!)
    ]
    
    @State var laterTasks: [TaskItem] = [
        TaskItem(title: "Project deadline", date: Calendar.current.date(bySettingHour: 0, minute: 0, second: 0, of: Date().advanced(by: 86400 * 7))!),
        TaskItem(title: "Quarterly review", date: Calendar.current.date(bySettingHour: 0, minute: 0, second: 0, of: Date().advanced(by: 86400 * 30))!)
    ]
    
    var body: some View {
        VStack {
            HStack {
                Image(systemName: "checklist")
                    .font(.system(size: 24, weight: .bold))
                    .foregroundColor(.black)
                Text("Tasks")
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(.black)
                Spacer()
                Button(action: {
                    print("Plus tapped")
                }) {
                    Image(systemName: "plus")
                        .font(.title2)
                        .foregroundColor(.black)
                }
            }
            .padding()
            
            ScrollView {
                SectionView(sectionName: "TODAY", tasks: $todayTasks)
                SectionView(sectionName: "TOMORROW", tasks: $tomorrowTasks)
                SectionView(sectionName: "LATER", tasks: $laterTasks)
            }
            
            HStack {
                Spacer()
                Button(action: {
                    print("Home tapped")
                }) {
                    VStack {
                        Image(systemName: "house.fill")
                            .font(.title3)
                        Text("Home")
                            .font(.caption)
                    }
                    .foregroundColor(.black)
                    .scaleEffect(1.5)
                }
                Spacer()
                Button(action: {
                    print("Lists tapped")
                }) {
                    VStack {
                        Image(systemName: "list.bullet")
                            .font(.title3)
                        Text("Lists")
                            .font(.caption)
                    }
                    .foregroundColor(.black)
                    .scaleEffect(1.5)
                }
                Spacer()
                Button(action: {
                    print("Settings tapped")
                }) {
                    VStack {
                        Image(systemName: "gearshape.fill")
                            .font(.title3)
                        Text("Settings")
                            .font(.caption)
                    }
                    .foregroundColor(.black)
                    .scaleEffect(1.5)
                }
                Spacer()
            }
            .padding(.horizontal, 0)
            .padding(.vertical, 10)
            .background(Color.white)
        }
        .background(Color.white)
    }
}

struct SectionView: View {
    let sectionName: String
    @Binding var tasks: [TaskItem]
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(sectionName)
                .font(.headline)
                .foregroundColor(.black)
                .padding(.horizontal)
            
            ForEach($tasks.indices, id: \.self) { i in
                TaskRow(task: $tasks[i])
            }
        }
        .padding(.vertical, 8)
        .background(Color.white)
    }
}

struct TaskItem {
    var title: String
    var date: Date
    var isDone: Bool = false
}

struct TaskRow: View {
    @Binding var task: TaskItem
    
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            HStack {
                Image(systemName: task.isDone ? "checkmark.circle.fill" : "circle")
                    .font(.title3)
                    .onTapGesture {
                        task.isDone.toggle()
                    }
                Text(task.title)
                    .font(.subheadline)
                    .foregroundColor(task.isDone ? .gray : .black)
                Spacer()
            }
            Text("\(task.date, style: .time)")
                .font(.caption)
                .foregroundColor(.gray)
        }
        .padding()
        .background(RoundedRectangle(cornerRadius: 12).fill(Color.white))
        .shadow(color: Color.black.opacity(0.05), radius: 3, x: 0, y: 2)
        .padding(.horizontal)
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
