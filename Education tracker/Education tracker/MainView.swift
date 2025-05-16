//
//  MainView.swift
//  Education tracker
//
//  Создан Иваном Кретовым 22.04.2025.
//

import SwiftUI

/// Главная точка входа в пользовательский интерфейс приложения.
///
/// `MainView` содержит три основные секции — Домашняя, Задачи и Настройки —
/// реализованные через `TabView` (стиль `.page` с скрытыми индикаторами).
/// Внизу поверх TabView располагается кастомная `BottomBar`, позволяющая
/// переключаться между страницами и при этом сохранять нативный жест пролистывания.
///
/// - Note: Здесь хранится только UI‑состояние; бизнес‑логика находится в `ModelData`.
struct MainView: View {
    /// Текущая выбранная страница в `TabView`.
    @State var selectedIndex: PageIndex = .house
    
    /// Общая модель, передаваемая из корня дерева представлений.
    @EnvironmentObject var modelData: ModelData
    
    var body: some View {
        NavigationView {
            ZStack(alignment: .bottom) {
                
                // MARK: - Контент страниц
                TabView(selection: $selectedIndex) {
                    HomeView()
                        .environmentObject(modelData)        // Передаём модель вниз по иерархии
                        .padding(.top)                       // Компенсируем safe‑area
                        .tag(PageIndex.house)
                    
                    TasksPageView()
                        .environmentObject(modelData)
                        .padding(.top)
                        .tag(PageIndex.tasks)
                    
                    SettingsView()
                        .padding(.top)
                        .tag(PageIndex.settings)
                }
                .tabViewStyle(.page(indexDisplayMode: .never)) // Скрыть стандартные точки страницы
                
                // MARK: - Нижняя навигационная панель
                BottomBar(selectedIndex: $selectedIndex)
            }
            .edgesIgnoringSafeArea(.bottom) // Позволяем панели тянуться до нижнего края устройства
        }
    }
}

#Preview {
    MainView()
        .environmentObject(ModelData())
}
