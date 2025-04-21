//
//  TaskRow.swift
//  Education tracker
//
//  Created by Иван Кретов on 21.04.2025.
//

import SwiftUI

struct TaskRow: View {
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
                    .foregroundColor(task.isDone ? .gray : .black)
                
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
        .background(RoundedRectangle(cornerRadius: 12).fill(Color.white))
        .shadow(color: Color.black.opacity(0.05), radius: 3, x: 0, y: 2)
        .padding(.horizontal)
    }
}

#Preview {
    TaskRow(task: .constant(
        TaskItem(
            title: "Team meeting",
            date: Date()
        )
    ),sectionEnum: .today, onDelete: {})
}
