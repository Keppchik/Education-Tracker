//
//  SettingsPageView.swift
//  Education tracker
//
//  Created by Иван Миронов on 11.04.2025.
//


import SwiftUI

enum themeOptions: Int, Identifiable, CaseIterable {
    case light
    case dark
    case systemDefault
    
    var name: String {
        switch self {
        case .light:
                return "Light"
        case .dark:
                return "Dark"
        case .systemDefault:
                return "System default"
        }
    }
    
    var id: Int { rawValue }
}

struct SettingsView: View {
    @State private var isDeadlineRemindersOn = false
    @State private var selectedTheme: themeOptions = .systemDefault
    @State private var showThemeOptions = false
    
    var body: some View {
        NavigationView {
            ZStack(alignment: .bottom) {
                ScrollView {
                    // ===== APPEARANCE =====
                    VStack(alignment: .leading, spacing: 0) {
                        Text("Appearance")
                            .font(.headline)
                            .fontWeight(.bold)
                            .padding(.top)
                        
                        // Theme selection
                        HStack {
                            Text("Theme")
                                .font(.body)
                                .padding(.top, 10)
                            Spacer()
                            Text(selectedTheme.name)
                                .foregroundColor(.gray)
                                .padding(.trailing)
                        }
                        .padding(.vertical, 10)
                        .contentShape(Rectangle())
                        .onTapGesture {
                            withAnimation(.easeInOut(duration: 0.2)) {
                                showThemeOptions.toggle()
                            }
                        }
                            
                        // Logic for list themeOptions
                        if showThemeOptions {
                            ForEach(themeOptions.allCases) { index in
                                HStack {
                                    Spacer()
                                    Text(index.name)
                                        .padding(.vertical, 10)
                                        .foregroundColor(selectedTheme == index ? .blue : .gray)
                                    if selectedTheme == index {
                                        Image(systemName: "checkmark")
                                            .foregroundColor(.blue)
                                    }
                                }
                                .padding(.trailing, 16)
                                .contentShape(Rectangle())
                                .onTapGesture {
                                    withAnimation(.easeInOut(duration: 0.2)) {
                                        selectedTheme = index
                                        showThemeOptions = false
                                    }
                                }
                            }
                        }
                    }
                    
                
                    // ===== NOTIFICATIONS =====
                    VStack(alignment: .leading, spacing: 0) {
                        Text("Notifications")
                            .font(.headline)
                            .fontWeight(.bold)
                            .padding(.top, 15)
                        
                        // Deadline reminders toggle
                        HStack {
                            Toggle("Deadline reminders", isOn: $isDeadlineRemindersOn)
                                .toggleStyle(SwitchToggleStyle(tint: .blue))
                                .padding(.top, 10)
                            Spacer()
                        }
                    }
                    .padding(.bottom, 10)
                    
                    
                    // ===== Data =====
                    VStack(alignment: .leading, spacing: 0) {
                        Text("Data")
                            .font(.headline)
                            .fontWeight(.bold)
                        
                        // CSV Export
                        Button(action: {}) {
                            HStack {
                                Text("Export")
                                    .foregroundColor(.black)
                                Spacer()
                                Text("CSV")
                                    .foregroundColor(.gray)
                            }
                            .padding(.vertical, 15)
                            .contentShape(Rectangle())
                            .onTapGesture {}
                        }
                        
                        // PDF Export
                        Button(action: {}) {
                            HStack {
                                Text("Export")
                                    .foregroundColor(.black)
                                Spacer()
                                Text("PDF")
                                    .foregroundColor(.gray)
                            }
                        }
                        .padding(.vertical, 15)
                        .contentShape(Rectangle())
                        .onTapGesture {}
                    }
                    .padding(.bottom, 20)
                    .padding(.top, 15)
                    
                    
                    // ===== STORAGE =====
                    VStack(alignment: .leading, spacing: 0) {
                        Text("Storage")
                            .font(.headline)
                            .fontWeight(.bold)
                        
                        NavigationLink(destination: CleanupView()) {
                            HStack {
                                Text("Cleanup")
                                    .padding(.top)
                                Spacer()
                                Image(systemName: "chevron.right")
                                    .foregroundColor(.gray)
                            }
                            .padding(.bottom, 10)
                            .contentShape(Rectangle())
                        }
                        .buttonStyle(PlainButtonStyle())
                    }
                    .padding(.bottom, 20)
                    
                    
                    
                    // ===== ABOUT =====
                    VStack(alignment: .leading, spacing: 0) {
                        Text("About")
                            .font(.headline)
                            .fontWeight(.bold)
                            .padding(.top, 15)
                        
                        // Version
                        HStack {
                            Text("Version")
                            Spacer()
                            Text("1.2.3")
                                .foregroundColor(.gray)
                        }
                        .padding(.vertical)
                        
                        // Developers
                        HStack {
                            Text("Developers")
                            Spacer()
                            Text("ITMO Students")
                                .foregroundColor(.gray)
                        }
                        .padding(.vertical, 12)
                    }
                    .padding(.bottom, 20)
                    Color.clear
                        .frame(height: 70)
                }
                .padding(.horizontal)
                .scrollIndicators(.hidden)
                
            // ===== BottomBar =====
            BottomBar(selectedIndex: .settings)
            }
            .edgesIgnoringSafeArea(.bottom)
            .navigationTitle(Text("Settings"))
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

struct CleanupView: View {
    var body: some View {
        Text("Cleanup Page")
            .navigationTitle("Cleanup")
    }
}

#Preview {
    SettingsView()
}
