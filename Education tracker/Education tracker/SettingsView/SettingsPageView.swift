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
        
    var colorScheme: ColorScheme? {
        switch self {
        case .systemDefault:
            return nil
        case .light:
            return .light
        case .dark:
            return .dark
        }
    }
    
    var id: Int { rawValue }
}

struct SettingsView: View {
    @State private var isDeadlineRemindersOn = false
    @AppStorage("selectedTheme") private var selectedTheme: themeOptions = .systemDefault
    @State private var showThemeOptions = false
    
    var body: some View {
        VStack {
            Text("Settings")
                .font(.system(size: 18, weight: .bold))
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
                                .foregroundColor(.primary)
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
                                .foregroundColor(.primary)
                            Spacer()
                            Text("PDF")
                                .foregroundColor(.gray)
                        }
                    }
                    .padding(.vertical, 15)
                    .contentShape(Rectangle())
                }
                .padding(.bottom, 20)
                .padding(.top, 15)
                    
                    
                // ===== STORAGE =====
                VStack(alignment: .leading, spacing: 0) {
                    Text("Storage")
                        .font(.headline)
                        .fontWeight(.bold)
                        
                    NavigationLink(destination: CleanUpPage()) {
                        HStack {
                            Text("Cleanup")
                                .padding(.top)
                            Spacer()
                            Image(systemName: "chevron.right")
                                .foregroundColor(.gray)
                        }
                        .foregroundColor(.primary)
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
                        Text("1.0.0")
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
            .scrollBounceBehavior(.basedOnSize)
        }
    }
}

#Preview {
    NavigationView {
        SettingsView()
    }
}
