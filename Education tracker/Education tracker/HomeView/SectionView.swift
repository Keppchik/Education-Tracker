//
//  SectionView.swift
//  Education tracker
//
//  Created by Иван Кретов on 21.04.2025.
//

import SwiftUI

struct SectionView: View {
    let sectionName: String
    @State private var pendingDeletionIndices = Set<Int>()
    @State private var deletionTimer: Timer?
    @Binding var tasks: [TaskItem]
    var sectionEnum: SectionEnum
    
    private func tasksDeletion(index: Int) {
        if pendingDeletionIndices.contains(index) {
            pendingDeletionIndices.remove(index)
        } else {
            pendingDeletionIndices.insert(index)
        }
            
        deletionTimer?.invalidate() 
            
        deletionTimer = Timer.scheduledTimer(withTimeInterval: 2.0, repeats: false) { _ in
            let sortedIndices = pendingDeletionIndices.sorted(by: >)
            for index in sortedIndices {
                tasks.remove(at: index)
            }
            pendingDeletionIndices.removeAll()
        }
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(sectionName)
                .font(.headline)
                .padding(.horizontal)
            
            ForEach($tasks.indices, id: \.self) { i in
                TaskRow(task: $tasks[i], sectionEnum: sectionEnum, onDelete: {
                    tasksDeletion(index: i)
                })
            }
        }
        .padding(.vertical, 8)
    }
}



#Preview {
    SectionView(sectionName: "Test", tasks: .constant([
        TaskItem(
            title: "Team meeting",
            date: Calendar.current.date(bySettingHour: 14, minute: 0, second: 0, of: Date())!
        ),
        TaskItem(
            title: "Team meeting",
            date: Calendar.current.date(bySettingHour: 14, minute: 0, second: 0, of: Date())!
        )
    ]), sectionEnum: .today)
}
