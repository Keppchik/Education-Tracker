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
    
    var body: some View {
        MainView()
            .preferredColorScheme(selectedTheme.colorScheme)
    }
}



#Preview {
    ContentView()
        .preferredColorScheme(nil) //.light .dark nil для смены темы
}
