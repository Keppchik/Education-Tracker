//
//  ListRow.swift
//  Education tracker
//
//  Created by Иван Кретов on 04.04.2025.
//

import SwiftUI

struct ListRow: View {
    @Binding var name: String
    @Binding var items: [String]
    @State var isExpanded = false
    var body: some View {
        Button {
            isExpanded.toggle()
        }
        label: {
            HStack {
                ZStack {
                    RoundedRectangle(cornerRadius: 8)
                        .fill(Color.gray.opacity(0.3))
                        .frame(width: 30, height: 30)
                    Text("☰")
                        .font(.system(size: 24))
                        .padding(.bottom, 5)
                        .rotationEffect(.degrees(isExpanded ? 90 : 0))
                }
                Text(name)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .foregroundStyle(.black)
            .padding(.leading)
        }
        .buttonStyle(PlainButtonStyle())
        
        ForEach(items, id: \.self) { item in
            if isExpanded {
                Button { } //TODO: Добавить переход на изменение задачи
                label: {
                    HStack {
                        Image(systemName: "circle.fill")
                            .font(.system(size: 8))
                        Text(item)
                    }
                    .foregroundStyle(.black)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.leading, 56)
                    .padding(.bottom, 8)
                }
                .contentShape(Rectangle())
                .buttonStyle(DefaultButtonStyle())
            }
        }
    }
}

#Preview {
    ListRow(name: .constant("List name"), items: .constant(["Item1", "Item2", "Item3"]))
}
