//
//  MainView.swift
//  Education tracker
//
//  Created by Иван Кретов on 22.04.2025.
//

import SwiftUI

struct MainView: View {
    @State var selectedIndex: PageIndex = .house
    var body: some View {
        NavigationView {
            VStack {
                TabView(selection: $selectedIndex) {
                    HomeView()
                        .tag(PageIndex.house)
                    
                    TasksPageView()
                        .tag(PageIndex.tasks)
                    
                    SettingsView()
                        .tag(PageIndex.settings)
                }
                .tabViewStyle(.page(indexDisplayMode: .never))
                
                
                BottomBar(selectedIndex: $selectedIndex)
            }
            .edgesIgnoringSafeArea(.bottom)
        }
    }
}

#Preview {
    MainView()
}
