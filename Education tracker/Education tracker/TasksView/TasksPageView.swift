//
//  TasksPageView.swift
//  Education tracker
//
//  Создан Иваном Кретовым 04.04.2025.
//

import SwiftUI

/// Экран управления задачами и списками задач.
///
/// Позволяет:
/// 1. Создавать новые списки задач (через `Menu` → «Create new list»).
/// 2. Создавать отдельные задачи (переход на `AddingTaskPageView`).
/// 3. Просматривать списки и удалять их свайп-жестом.
///
/// Локальное состояние экрана хранится в `@State`, а глобальная информация
/// о задачах — в `ModelData`, доступном через `@EnvironmentObject`.
///
/// > Важно: Логику работы с данными (создание/хранение) выполняет `ModelData`,
///   а `TasksPageView` содержит только отображение и навигацию.
struct TasksPageView: View {
    // MARK: - Инъекции и состояние
    /// Глобальная модель данных приложения.
    @EnvironmentObject var modelData: ModelData
    
    /// Флаг отображения sheet'а создания нового списка.
    @State private var newListSheet = false
    
    /// Название нового списка задач, вводимое пользователем.
    @State private var newListName: String = ""
    
    /// Локальная копия списков задач. Обновляется при `onAppear` и
    /// при создании/удалении списков.
    @State private var myLists: [ClassTaskList]
    init() {
        _myLists = State(initialValue: [])
    }
    
    /// Флаг перехода на экран создания задачи.
    @State private var showAddTaskView = false
    
    // MARK: - Вспомогательные методы
    /// Удаляет переданный список из локального массива.
    private func deleteList(list: ClassTaskList) {
        myLists.removeAll { $0.id == list.id }
    }
    
    // MARK: - Разметка
    var body: some View {
        VStack {
            // Кнопка «плюс» с меню создания
            Menu {
                Button(action: { newListSheet = true }) {
                    Label("Create new list", systemImage: "list.bullet")
                }
                
                Button(action: { showAddTaskView = true }) {
                    Label("Create new task", systemImage: "square.and.pencil")
                }
            } label: {
                Image(systemName: "plus")
                    .font(.system(size: 32))
                    .foregroundColor(.primary)
            }
            .frame(maxWidth: .infinity, alignment: .trailing)
            .padding(.trailing, 32)
            .padding(.vertical, 8)
            // Переход на экран добавления задачи
            .background(
                NavigationLink(destination: AddingTaskPageView().environmentObject(modelData), isActive: $showAddTaskView) {}
            )
            
            // Заголовок
            Text("Tasks")
                .font(.system(size: 32, weight: .bold))
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.leading)
            
            // Кнопки фильтров/сортировки задач
            TasksButtons()
                .environmentObject(modelData)
            
            // Списки задач
            TasksList(myLists: $myLists)
                .environmentObject(modelData)
                .padding(.top)
        }
        // Загружаем списки при появлении экрана
        .onAppear {
            myLists = modelData.allLists
        }
        // Лист создания нового списка
        .sheet(isPresented: $newListSheet) {
            VStack(alignment: .center, spacing: 16) {
                HStack {
                    // Кнопка отмены
                    Button { newListSheet = false } label: {
                        Text("Cancel")
                    }
                    .padding(.leading)
                    
                    Spacer()
                    
                    Text("New List")
                        .fontWeight(.bold)
                    
                    Spacer()
                    
                    // Кнопка создания
                    Button {
                        myLists.append(modelData.createList(name: newListName))
                        newListName = ""
                        newListSheet = false
                    } label: {
                        Text("Create")
                    }
                    .disabled(newListName.isEmpty) // Заблокирована, пока поле пустое
                    .padding(.trailing)
                }
                // Поле ввода названия списка
                ZStack {
                    if newListName.isEmpty {
                        Text("List Name")
                            .foregroundColor(.gray)
                            .font(.headline)
                            .padding(.top, 32)
                    }
                    TextField("", text: $newListName)
                        .font(.headline)
                        .multilineTextAlignment(.center)
                        .padding(.top, 32)
                        // Создаём список прямо из клавиатуры
                        .onSubmit {
                            guard !newListName.isEmpty else { return }
                            myLists.append(modelData.createList(name: newListName))
                            newListName = ""
                            newListSheet = false
                        }
                }
            }
            .presentationDetents([.fraction(0.3)]) // Высота bottom sheet = 30% экрана
            .padding(.top, 32)
            
            Divider()
                .padding(.horizontal)
            
            Spacer()
        }
    }
}

#Preview {
    TasksPageView()
        .environmentObject(ModelData())
}
