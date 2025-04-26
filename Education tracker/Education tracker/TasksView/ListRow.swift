//
//  ListRow.swift
//  Education tracker
//
//  Created by Иван Кретов on 04.04.2025.
//

import SwiftUI

struct ListRow: View {
    @Binding var name: String
    @Binding var items: [TaskItem]
    @State var isExpanded = false
    @Environment(\.colorScheme) private var colorScheme
    
    var body: some View {
        Button {
            isExpanded.toggle()
        }
        label: {
            HStack {
                ZStack {
                    RoundedRectangle(cornerRadius: 8)
                        .fill(colorScheme == .light ? Color.gray.opacity(0.3) : Color.gray.opacity(0.7))
                        .frame(width: 30, height: 30)
                    Text("☰")
                        .font(.system(size: 24))
                        .padding(.bottom, 5)
                        .rotationEffect(.degrees(isExpanded ? 90 : 0))
                        .animation(.default, value: isExpanded)
                }
                
                Text(name)
                
                Spacer()
                
                Text(String(items.count))
                    .padding(.trailing)
            }
            .contentShape(Rectangle())
            .frame(maxWidth: .infinity, alignment: .leading)
            .foregroundColor(.primary)
            .padding(.leading)
        }
        
        ForEach(Array(items.enumerated()), id: \.element) { index, item in
            if isExpanded {
                NavigationLink { TaskDetailsView(taskName: item.title, currentScore: item.score, maxScore: item.maxScore, taskType: item.type, taskDeadline: item.date, taskStatus: item.status) } 
                label: {
                    HStack {
                        Image(systemName: "circle.fill")
                            .font(.system(size: 8))
                        
                        Text(item.title)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .foregroundColor(.primary)
                    .padding(.leading, 56)
                    .padding(.bottom, 8)
                }
                .transition(.asymmetric(insertion: .opacity, removal: .identity)
                    .animation(
                        .spring(response: 0.5, dampingFraction: 0.7)
                        .delay(Double(index) * 0.15)
                    )
                )
            }
        }
    }
}

#Preview {
    ListRow(name: .constant("List name"), items: .constant(
        [
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
            )
        ]))
}
