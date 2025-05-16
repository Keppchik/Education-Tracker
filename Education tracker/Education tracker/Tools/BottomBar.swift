//
//  BottomBar.swift
//  Education tracker
//
//  Создан Иваном Кретовым 05.04.2025.
//

import SwiftUI

/// Индекс текущей страницы приложения.
///
/// Используется для синхронизации выбранной вкладки между `MainView` и `BottomBar`.
enum PageIndex: Int {
    case house   // Домашняя страница
    case tasks   // Страница задач
    case settings // Страница настроек
}

/// Кастомная нижняя панель навигации.
///
/// Состоит из трёх кнопок‑вкладок (Домой, Задачи, Настройки).
/// Каждая кнопка содержит системную иконку и подпись.
/// Активная вкладка подсвечена цветом `Color.primary`, остальные — `Color.gray`.
struct BottomBar: View {
    /// Ссылка на выбранный индекс. При изменении обновляется родительский `TabView`.
    @Binding var selectedIndex: PageIndex
    
    var body: some View {
        ZStack {
            // Фон панели: прямоугольник с обводкой.
            Rectangle()
                .stroke(.primary, lineWidth: 1.5)
                .fill(.background)
                .frame(maxWidth: .infinity, maxHeight: 80)
            
            HStack {
                Spacer()
                
                // MARK: - Кнопка «Домой»
                Button { selectedIndex = .house }
                label: {
                    VStack(spacing: 0) {
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
                
                // MARK: - Кнопка «Задачи»
                Button { selectedIndex = .tasks }
                label: {
                    VStack(spacing: 0) {
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
                .padding(.horizontal, 20)
                
                Spacer()
                
                // MARK: - Кнопка «Настройки»
                Button { selectedIndex = .settings }
                label: {
                    VStack(spacing: 0) {
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
            .padding(.bottom, 10) // Радиус клика и визуальная коррекция
        }
    }
}

#Preview {
    BottomBar(selectedIndex: .constant(.tasks))
}
