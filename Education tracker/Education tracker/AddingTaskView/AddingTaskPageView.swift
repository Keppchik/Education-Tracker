//
//  AddingTaskPageView.swift
//  Education tracker
//
//  Создан Иваном Миронов 22.04.2025.
//

import SwiftUI

/// Экран создания / редактирования задачи.
///
/// Содержит набор дочерних компонентов (TypeTask, DeadlineView, AttachmentView,
/// StatusView, ScoreView, DescribtionView) для ввода всех параметров задачи.
/// Поддерживает режим **создания** и **редактирования** (`isEdit`), заполняя
/// поля из переданного `task`.
/// Валидация: название не пустое, `maxScore >= currentScore`. При сохранении
/// вызывает методы `modelData.createTask` или `modelData.updateTask`.
struct AddingTaskPageView: View {
    // MARK: - Зависимости среды
    @EnvironmentObject var modelData: ModelData
    
    // MARK: - Состояние экрана
    @State var isEdit = false          // true — редактирование, false — новая задача
    @State var task: ClassTask? = nil  // Задача для редактирования
    
    // MARK: - Поля ввода
    @State var name: String = ""                      // Название задачи
    @State var selectedType: TypeOptions = .ToDo       // Тип
    @State var selectedStatus: StatusOptions = .ToDo   // Статус
    @State var deadline: Date = Date()                 // Дедлайн
    @State var currentScore: Int16 = 0                 // Набранные баллы
    @State var maxScore: Int16 = 0                     // Максимум баллов
    @State var description: String = ""               // Описание
    
    // MARK: - Флаги ошибок валидации
    @State private var showNameError = false
    @State private var showMaxScoreError = false
    
    @Environment(\.presentationMode) var presentationMode
    
    // MARK: - UI
    var body: some View {
        NavigationView {
            ScrollView {
                // ===== Task Name =====
                VStack(alignment: .leading) {
                    TextField("Task name", text: $name)
                        .padding()
                        .background(.gray.opacity(0.2))
                        .cornerRadius(10)
                    if showNameError && name.isEmpty {
                        Text("Task name cannot be empty")
                            .foregroundColor(.red)
                            .font(.caption)
                            .padding(.leading, 8)
                    }
                }
                .padding(.bottom)
                
                // ===== Type =====
                TypeTask(selectedType: $selectedType)
                    .padding(.vertical)
                
                // ===== Deadline =====
                DeadlineView(selectedDate: $deadline)
                    .padding(.vertical)
                
                // ===== Attachment =====
                AttachmentView() // TODO: добавить функционал загрузки файлов
                    .padding(.vertical)
                
                // ===== Status =====
                StatusView(selectedStatus: $selectedStatus)
                    .padding(.vertical)
                
                // ===== Score =====
                ScoreView(currentScore: $currentScore, maxScore: $maxScore, showMaxScoreError: $showMaxScoreError)
                    .padding(.vertical)
                
                // ===== Description =====
                DescribtionView(descriptionText: $description)
                    .padding(.vertical)
            }
            .padding(.horizontal)
            .padding(.vertical)
            .scrollIndicators(.hidden)
        }
        // Заполняем поля при редактировании
        .onAppear {
            if let task = task {
                name = task.title
                selectedType = TypeOptions(rawValue: task.type) ?? .ToDo
                selectedStatus = StatusOptions(rawValue: task.status) ?? .ToDo
                deadline = task.date
                currentScore = task.score
                maxScore = task.maxScore
                description = task.taskDescription
            }
        }
        .navigationTitle("New Task")
        
        // Кнопка «Save / Update»
        Button(action: saveAction) {
            Text(isEdit ? "Update" : "Save")
                .font(.headline)
                .foregroundColor(.white)
                .frame(maxWidth: .infinity)
                .padding()
                .background(Color.blue)
                .cornerRadius(10)
        }
        .padding(.horizontal)
        .padding(.bottom, 10)
    }
    
    // MARK: - Логика сохранения
    private func saveAction() {
        // Валидация
        guard !name.isEmpty else { showNameError = true; return }
        guard maxScore >= currentScore else { showMaxScoreError = true; return }
        
        if isEdit, let task = task {
            modelData.updateTask(
                task,
                newTitle: name,
                isDone: selectedStatus == .Done,
                newDate: deadline,
                newStatus: selectedStatus,
                newDescription: description,
                newType: selectedType,
                newScore: currentScore,
                newMaxScore: maxScore
            )
        } else {
            modelData.createTask(
                title: name,
                date: deadline,
                description: description,
                type: selectedType,
                status: selectedStatus,
                score: currentScore,
                maxScore: maxScore,
                isDone: selectedStatus == .Done
            )
        }
        presentationMode.wrappedValue.dismiss()
    }
}

// MARK: - Превью (создание)
#Preview {
    AddingTaskPageView()
        .environmentObject(ModelData())
}

// MARK: - Превью (редактирование)
#Preview {
    AddingTaskPageView(
        isEdit: true,
        name: "Test",
        selectedType: .Learn,
        selectedStatus: .InProgress,
        deadline: Date(),
        currentScore: 10,
        maxScore: 10,
        description: "testing"
    )
    .environmentObject(ModelData())
}
