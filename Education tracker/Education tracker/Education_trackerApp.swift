//
//  Education_trackerApp.swift
//  Education tracker
//
//  Created by Иван Кретов on 04.04.2025.
//

import SwiftUI

@main
struct EducatorTrackerApp: App {
    @StateObject private var modelData = ModelData()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(modelData)
        }
    }
}
