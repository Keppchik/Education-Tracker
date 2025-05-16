//
//  SettingsPageView.swift
//  Education tracker
//
//  Создан Иваном Миронов 11.04.2025.
//

import SwiftUI

/// Перечисление параметров темы интерфейса.
///
/// Используется для переключения цветовой схемы приложения.
/// `AppStorage("selectedTheme")` сохраняет выбор пользователя между запусками.
enum themeOptions: Int, Identifiable, CaseIterable {
    case light
    case dark
    case systemDefault
    
    /// Читаемое имя опции.
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
    
    /// Соответствующая схема цвета для `ColorScheme`.
    /// `nil` означает использование системной настройки.
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

/// Экран настроек приложения.
///
/// Содержит разделы:
/// * Appearance — выбор темы (Light / Dark / System);
/// * Notifications — переключатель напоминаний о дедлайнах;
/// * Data — экспорт данных (CSV, PDF);
/// * Storage — переход к очистке хранилища;
/// * About — версия и разработчики.
struct SettingsView: View {
    // MARK: - Состояние
    /// Флаг напоминаний о дедлайнах.
    @State private var isDeadlineRemindersOn = false
    /// Выбранная тема (сохраняется через `AppStorage`).
    @AppStorage("selectedTheme") private var selectedTheme: themeOptions = .systemDefault
    /// Флаг отображения списка тем.
    @State private var showThemeOptions = false
    
    // MARK: - UI
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
                    
                    // Выбор темы
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
                        // Показ / скрытие списка опций темы
                        withAnimation(.easeInOut(duration: 0.2)) {
                            showThemeOptions.toggle()
                        }
                    }
                    
                    // Список вариантов темы
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
                    
                    // Тоггл напоминаний о дедлайне
                    HStack {
                        Toggle("Deadline reminders", isOn: $isDeadlineRemindersOn)
                            .toggleStyle(SwitchToggleStyle(tint: .blue))
                            .padding(.top, 10)
                        Spacer()
                    }
                }
                .padding(.bottom, 10)
                
                // ===== DATA =====
                VStack(alignment: .leading, spacing: 0) {
                    Text("Data")
                        .font(.headline)
                        .fontWeight(.bold)
                    
                    // Экспорт CSV
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
                    }
                    
                    // Экспорт PDF
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
                    
                    NavigationLink(destination: CleanupView()) {
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
                    
                    // Версия приложения
                    HStack {
                        Text("Version")
                        Spacer()
                        Text("1.2.3")
                            .foregroundColor(.gray)
                    }
                    .padding(.vertical)
                    
                    // Разработчики
                    HStack {
                        Text("Developers")
                        Spacer()
                        Text("ITMO Students")
                            .foregroundColor(.gray)
                    }
                    .padding(.vertical, 12)
                }
                .padding(.bottom, 20)
                
                // Пустой блок для отступа внизу, чтобы кнопка не пряталась под баром
                Color.clear
                    .frame(height: 70)
            }
            .padding(.horizontal)
            .scrollIndicators(.hidden)
            .scrollBounceBehavior(.basedOnSize)
        }
    }
}

/// Экран очистки данных приложения.
struct CleanupView: View {
    var body: some View {
        Text("Cleanup Page")
            .navigationTitle("Cleanup")
    }
}

#Preview {
    SettingsView()
}
