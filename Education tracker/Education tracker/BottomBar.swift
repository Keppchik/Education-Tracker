//
//  BottomBar.swift
//  Education tracker
//
//  Created by Иван Миронов on 11.04.2025.
//


import SwiftUI

enum PageIndex: Int {
    case house
    case tasks
    case settings
}

struct BottomBar: View {
    @Binding var selectedIndex: PageIndex // Changed from @State to @Binding
    
    var body: some View {
        ZStack {
            Rectangle()
                .stroke(.primary, lineWidth: 1.5)
                .fill(.background)
                .frame(maxWidth: .infinity, maxHeight: 90)
            
            HStack {
                Spacer()
                
                Button { selectedIndex = .house }
                label: {
                    VStack {
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
                    VStack {
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
                
                Spacer()
                
                Button { selectedIndex = .settings }
                label: {
                    VStack {
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
            .padding(.bottom, 16)
        }
    }
}



#Preview {
    BottomBar(selectedIndex: .constant(.tasks)) // Use .constant for preview
}
