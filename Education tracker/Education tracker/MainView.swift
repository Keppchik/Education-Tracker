//
//  MainView.swift
//  Education tracker
//
//  Created by Иван Кретов on 22.04.2025.
//

import SwiftUI

struct MainView: View {
    @State var selectedIndex: PageIndex = .house
    @EnvironmentObject var modelData: ModelData
    
    var body: some View {
        NavigationView {
            ZStack(alignment: .bottom) {
                TabView(selection: $selectedIndex) {
                    HomeView(tasks: $modelData.allTasks)
                        .environmentObject(modelData)
                        .padding(.top)
                        .tag(PageIndex.house)
                    
                    TasksPageView()
                        .environmentObject(modelData)
                        .padding(.top)
                        .tag(PageIndex.tasks)
                    
                    SettingsView()
                        .padding(.top)
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
        .environmentObject(ModelData())
}
