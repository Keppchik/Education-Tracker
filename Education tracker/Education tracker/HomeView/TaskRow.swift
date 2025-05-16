//
//  TaskRow.swift
//  Education tracker
//
//  Created by Иван Кретов on 21.04.2025.
//

import SwiftUI

struct TaskRow: View {
    @Environment(\.colorScheme) private var colorScheme
    @State var task: ClassTask
    @State private var isTapped: Bool = false
    var sectionEnum: SectionEnum
    var onTap: () -> Void
    
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            HStack {
                Image(systemName: isTapped ? "checkmark.circle.fill" : "circle")
                    .font(.title3)
                    .onTapGesture {
                        onTap()
                        isTapped.toggle()
                    }
                
                Text(task.title)
                    .font(.subheadline)
                    .foregroundColor(isTapped ? .gray : .primary)
                
                Spacer()
            }
            if sectionEnum == .today || sectionEnum == .tomorrow {
                Text("\(formatDateHourMin(task.date))")
                    .font(.caption)
                    .foregroundColor(.gray)
            }
            if sectionEnum == .later {
                Text("\(formatDateDayMonth(task.date))")
                    .font(.caption)
                    .foregroundColor(.gray)
            }
            
        }
        .onAppear() {
            isTapped = task.isDone
        }
        .padding()
        .background(RoundedRectangle(cornerRadius: 12).fill(colorScheme == .light ? .white : .white.opacity(0.12)))
        .shadow(color: Color.primary.opacity(0.1), radius: 3, x: 2, y: 2)
        .padding(.horizontal)
    }
}

#Preview {
    let context = CoreDataManager.shared.context
    
    let task1 = ClassTask(context: context)
    task1.id = UUID()
    task1.title = "Test Task 1"
    task1.date = Date()
    task1.type = TypeOptions.ToDo.rawValue
    task1.status = StatusOptions.ToDo.rawValue
    task1.score = 0
    task1.maxScore = 10
    task1.taskDescription = "Test description 1"
    task1.isDone = false
    
    return NavigationView {
        TaskRow(task: task1, sectionEnum: .today, onTap: {})
            .environmentObject(ModelData())
            .environment(\.managedObjectContext, context)
    }
}
