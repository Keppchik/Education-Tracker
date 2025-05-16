//
//  HomeView.swift
//  Education tracker
//
//  Создан Иваном Кретовым 21.04.2025.
//

import SwiftUI

/// Главный экран приложения, показывающий задачи по категориям «Сегодня»,
/// «Завтра» и «Позже».
///
/// При появлении экрана (`onAppear`) выполняется `updateTasks()`, который
/// разделяет все незавершённые задачи на три массива (`todayTasks`,
/// `tomorrowTasks`, `laterTasks`) и отображает их через `SectionView`.
struct HomeView: View {
    // MARK: - Зависимости среды и состояние
    @EnvironmentObject var modelData: ModelData
    
    /// Кеш всех задач (используется для вычислений и проверки «нет задач»).
    @State private var tasks: [ClassTask]
    init() {
        _tasks = State(initialValue: [])
    }
    
    /// Задачи на сегодня.
    @State private var todayTasks: [ClassTask] = []
    /// Задачи на завтра.
    @State private var tomorrowTasks: [ClassTask] = []
    /// Задачи на более позднюю дату.
    @State private var laterTasks: [ClassTask] = []
    
    // MARK: - Обновление списков задач
    /// Загружает все задачи из `modelData`, фильтрует выполненные и распределяет
    /// по массивам в зависимости от даты.
    private func updateTasks() {
        tasks = modelData.allTasks
        let filteredTasks = tasks.filter { !$0.isDone }
        todayTasks = filteredTasks.filter { Calendar.current.isDateInToday($0.date) }
        tomorrowTasks = filteredTasks.filter { Calendar.current.isDateInTomorrow($0.date) }
        laterTasks = filteredTasks.filter {
            !Calendar.current.isDateInToday($0.date) &&
            !Calendar.current.isDateInTomorrow($0.date)
        }
    }
    
    // MARK: - UI
    var body: some View {
        VStack {
            // Заголовок и кнопка добавления задачи
            HStack {
                Text("Home")
                    .font(.title)
                    .fontWeight(.bold)
                
                Spacer()
                
                NavigationLink {
                    AddingTaskPageView()
                        .environmentObject(modelData)
                } label: {
                    Image(systemName: "plus")
                        .font(.system(size: 30))
                        .foregroundColor(.primary)
                }
            }
            .padding()
            
            // Прокручиваемый список секций
            ScrollView {
                if !todayTasks.isEmpty {
                    SectionView(
                        sectionName: "TODAY",
                        tasks: todayTasks,
                        sectionEnum: .today,
                        updateTasks: updateTasks
                    )
                    .environmentObject(modelData)
                }
                if !tomorrowTasks.isEmpty {
                    SectionView(
                        sectionName: "TOMORROW",
                        tasks: tomorrowTasks,
                        sectionEnum: .tomorrow,
                        updateTasks: updateTasks
                    )
                    .environmentObject(modelData)
                }
                if !laterTasks.isEmpty {
                    SectionView(
                        sectionName: "LATER",
                        tasks: laterTasks,
                        sectionEnum: .later,
                        updateTasks: updateTasks
                    )
                    .environmentObject(modelData)
                }
                // Сообщение, если задач нет
                if tasks.filter({ !$0.isDone }).isEmpty {
                    Text("You have no tasks")
                        .font(.headline)
                        .frame(maxHeight: .infinity, alignment: .center)
                }
                // Нижний отступ, чтобы контент не прятался за нижней панелью
                Color.clear
                    .frame(height: 90)
            }
            .onAppear {
                updateTasks()
            }
            .scrollBounceBehavior(.basedOnSize)
        }
    }
}

#Preview {
    HomeView()
        .environmentObject(ModelData())
}
