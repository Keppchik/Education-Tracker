//
//  TaskRow.swift
//  Education tracker
//
//  Created by Иван Кретов on 21.04.2025.
//

import SwiftUI

struct TaskRow: View {
    @Environment(\.colorScheme) private var colorScheme
    @Binding var task: TaskItem
    var sectionEnum: SectionEnum
    var onDelete: () -> Void
    
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            HStack {
                Image(systemName: task.isDone ? "checkmark.circle.fill" : "circle")
                    .font(.title3)
                    .onTapGesture {
                        task.isDone.toggle()
                        onDelete()
                    }
                
                Text(task.title)
                    .font(.subheadline)
                    .foregroundColor(task.isDone ? .gray : .primary)
                
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
        .padding()
        .background(RoundedRectangle(cornerRadius: 12).fill(colorScheme == .light ? .white : .white.opacity(0.12)))
        .shadow(color: Color.primary.opacity(0.1), radius: 3, x: 2, y: 2)
        .padding(.horizontal)
    }
}

#Preview {
    TaskRow(task: .constant(
        TaskItem(
            title: "Team meeting",
            date: Date(),
            score: 0,
            status: .ToDo,
            type: .Remind
        )
    ),sectionEnum: .today, onDelete: {})
}
