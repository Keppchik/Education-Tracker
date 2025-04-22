//
//  BottomBar.swift
//  Education tracker
//
//  Created by Иван Кретов on 05.04.2025.
//


import SwiftUI

enum PageIndex: Int {
    case house
    case tasks
    case settings
}

struct BottomBar: View {
    @Binding var selectedIndex: PageIndex
    var body: some View {
        ZStack {
            Rectangle()
                .stroke(.primary, lineWidth: 1.5)
                .fill(.background)
                .frame(maxWidth: .infinity, maxHeight: 80)
            
            HStack {
                Spacer()
                
                Button { selectedIndex = .house }
                label: {
                    VStack(spacing: 0) {
                        Image(systemName: "house")
                            .font(.system(size: 24))
                            .foregroundStyle(selectedIndex == .house ? Color.primary : Color.gray)
                            .padding(.vertical, 4)
                        Text("Home")
                            .fontWeight(.bold)
                            .foregroundStyle(selectedIndex == .house ? Color.primary : Color.gray)
                            .font(.system(size: 16))
                    }
                }
                
                Spacer()
                
                Button { selectedIndex = .tasks }
                label: {
                    VStack(spacing: 0) {
                        Image(systemName: "list.bullet")
                            .font(.system(size: 24))
                            .foregroundStyle(selectedIndex == .tasks ? Color.primary : Color.gray)
                            .padding(.vertical, 4)
                        Text("Tasks")
                            .fontWeight(.bold)
                            .foregroundStyle(selectedIndex == .tasks ? Color.primary : Color.gray)
                            .font(.system(size: 16))
                    }
                }
                .padding(.horizontal, 20)
                
                Spacer()
                
                Button { selectedIndex = .settings }
                label: {
                    VStack(spacing: 0) {
                        Image(systemName: "gearshape")
                            .font(.system(size: 24))
                            .foregroundStyle(selectedIndex == .settings ? Color.primary : Color.gray)
                            .padding(.vertical, 4)
                        Text("Settings")
                            .fontWeight(.bold)
                            .foregroundStyle(selectedIndex == .settings ? Color.primary : Color.gray)
                            .font(.system(size: 16))
                    }
                }
                Spacer()
            }
            .padding(.bottom, 10)
        }
    }
}

#Preview {
    BottomBar(selectedIndex: .constant(.tasks))
}
