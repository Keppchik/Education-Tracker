//
//  ContentView.swift
//  Education tracker
//
//  Created by Иван Кретов on 04.04.2025.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @AppStorage("selectedTheme") private var selectedTheme: themeOptions = .systemDefault
    @EnvironmentObject var modelData: ModelData
    
    var body: some View {
        MainView()
            .environmentObject(modelData)
            .preferredColorScheme(selectedTheme.colorScheme)
    }
}



#Preview {
    ContentView()
        .environmentObject(ModelData())
        .preferredColorScheme(nil) //.light .dark nil для смены темы
}
