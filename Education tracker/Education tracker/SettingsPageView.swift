//
//  SettingsPageView.swift
//  Education tracker
//
//  Created by Иван Миронов on 11.04.2025.
//


import SwiftUI

struct SettingsView: View {
    @State private var isDeadlineRemindersOn = false
    @State private var selectedTheme = "System default"
    @State private var showThemeOptions = false
    
    let themeOptions = ["System default", "Light", "Dark"]
    
    var body: some View {
        NavigationView {
            ZStack(alignment: .bottom) {
                ScrollView {
                    // ===== APPEARANCE =====
                    VStack(spacing: 0) {
                        VStack(alignment: .leading, spacing: 0) {
                            Text("Appearance")
                                .font(.headline)
                                .fontWeight(.bold)
                                .padding([.leading, .trailing], 16)
                                .padding(.top, 15)
                                .foregroundColor(.black)
                            
                            // Theme selection
                            VStack(spacing: 0) {
                                HStack {
                                    Text("Theme")
                                        .font(.body)
                                        .padding([.top, .leading, .trailing], 16)
                                    Spacer()
                                    HStack(spacing: 4) {
                                        Text(selectedTheme)
                                            .foregroundColor(.gray)
                                        Image(systemName: "chevron.down")
                                            .rotationEffect(.degrees(showThemeOptions ? 180 : 0))
                                            .foregroundColor(.gray)
                                    }
                                    .padding(.trailing, 16)
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
                                    VStack(spacing: 0) {
                                        ForEach(themeOptions.indices, id: \.self) { index in
                                            VStack(spacing: 0) {
                                                
                                                HStack {
                                                    Spacer()
                                                    Text(themeOptions[index])
                                                        .padding(.vertical, 10)
                                                        .foregroundColor(selectedTheme == themeOptions[index] ? .blue : .gray)
                                                    if selectedTheme == themeOptions[index] {
                                                        Image(systemName: "checkmark")
                                                            .foregroundColor(.blue)
                                                    }
                                                }
                                                .padding(.horizontal, 16)
                                                .contentShape(Rectangle())
                                                .onTapGesture {
                                                    withAnimation(.easeInOut(duration: 0.2)) {
                                                        selectedTheme = themeOptions[index]
                                                        showThemeOptions = false
                                                    }
                                                }
                                            }
                                        }
                                    }
                                    .background(Color(.systemBackground))
                                }
                            }
                            .padding(.bottom, 10)
                        }
                        
                        
                        // ===== NOTIFICATIONS =====
                        VStack(alignment: .leading, spacing: 0) {
                            Text("Notifications")
                                .font(.headline)
                                .fontWeight(.bold)
                                .padding([.leading, .trailing], 16)
                                .padding(.top, 15)
                                .foregroundColor(.black)
                            
                            // Deadline reminders toggle
                            HStack {
                                Toggle("Deadline reminders", isOn: $isDeadlineRemindersOn)
                                    .toggleStyle(SwitchToggleStyle(tint: .blue))
                                    .padding(.leading, 16)
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
                                .padding([.top, .leading, .trailing], 16)
                                .foregroundColor(.black)
                            
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
                                .padding(.horizontal, 16)
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
                            .padding(.horizontal, 16)
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
                                .padding([.top, .leading, .trailing], 16)
                                .foregroundColor(.black)
                            
                            NavigationLink(destination: CleanupView()) {
                                HStack {
                                    Text("Cleanup")
                                        .font(.body)
                                        .foregroundColor(.black)
                                        .padding(.top)
                                    Spacer()
                                    Image(systemName: "chevron.right")
                                        .foregroundColor(.gray)
                                }
                                .padding(.horizontal, 16)
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
                                .padding([.leading, .trailing], 16)
                                .padding(.top, 15)
                                .foregroundColor(.black)
                            
                            // Version
                            HStack {
                                Text("Version")
                                    .font(.body)
                                Spacer()
                                Text("1.2.3")
                                    .foregroundColor(.gray)
                            }
                            .padding(.vertical, 12)
                            .padding(.horizontal, 16)
                            
                            // Developers
                            HStack {
                                Text("Developers")
                                    .font(.body)
                                Spacer()
                                Text("ITMO Students")
                                    .foregroundColor(.gray)
                            }
                            .padding(.vertical, 12)
                            .padding(.horizontal, 16)
                        }
                        .padding(.bottom, 20)
                    }
                    .padding(.vertical, 20)
                }
                
               // ===== BottomBar =====
                BottomBar(selectedIndex: .constant(.settings))
            }
            .edgesIgnoringSafeArea(.bottom)
            .navigationTitle(Text("Settings")
                .font(.headline)
                .fontWeight(.bold)
                .foregroundColor(Color.black)
                )
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
