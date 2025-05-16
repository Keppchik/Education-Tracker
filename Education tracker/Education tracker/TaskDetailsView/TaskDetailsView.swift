//
//  TaskDetailsView.swift
//  Education tracker
//
//  Создан Иваном Кретовым 16.05.2025.
//

import SwiftUI

/// Экран подробной информации о задаче.
///
/// Позволяет:
/// * просмотреть заголовок, статус, тип, дедлайн, баллы;
/// * открыть вложения (алерт);
/// * отредактировать баллы через `Edit Score`;
/// * перейти к редактированию самой задачи (иконка «pencil» в навбаре);
/// * закрыть экран кнопкой «Done».
///
/// Все изменения передаются в глобальную модель `ModelData`.
struct TaskDetailsView: View {
    // MARK: - Состояние
    /// Текущая задача для отображения.
    @State var task: ClassTask
    /// Временное значение баллов при редактировании.
    @State var editingScore: Int16 = 0
    
    init(task: ClassTask) {
        self.task = task
        // Инициализируем `editingScore` текущим значением баллов
        self._editingScore = State(initialValue: task.score)
    }
    
    // MARK: - Локальное состояние UI
    @State private var showingAttachmentAlert = false
    @State private var selectedAttachment = ""
    @State private var isMarkedDone = false
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var modelData: ModelData
    
    @State private var editScore = false // Флаг показа sheet редактирования баллов
    
    /// Предустановленные типы вложений (не используются напрямую, но можно для расширения).
    let predefinedTypes = ["Meeting", "Documentation", "Design", "Development", "Review"]
    
    /// Форматированный дедлайн для отображения.
    var formattedDeadline: String {
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        return formatter.string(from: task.date)
    }
    
    // MARK: - UI
    var body: some View {
        VStack(spacing: 0) {
            // Основной контент в ScrollView
            ScrollView {
                VStack(alignment: .leading, spacing: 12) {
                    // Заголовок задачи
                    Text("Task: \(task.title)")
                        .font(.title2)
                        .fontWeight(.semibold)
                        .foregroundColor(.primary)
                        .padding(.vertical, 20)
                    
                    // Детали
                    DetailItemView(title: "Current status:", value: StatusOptions(rawValue: task.status)!.name)
                    Divider()
                    DetailItemView(title: "Type", value: TypeOptions(rawValue: task.type)!.name)
                    Divider()
                    DetailItemView(title: "Deadline", value: formattedDeadline)
                    Divider()
                    DetailItemView(title: "Score", value: "\(task.score)/\(task.maxScore)")
                        .padding(.bottom, 20)
                    
                    // Вложения
                    Text("Attachments")
                        .font(.headline)
                        .foregroundColor(.primary)
                    
                    VStack {
                        Button(action: {
                            selectedAttachment = "Client_briefing.pdf"
                            showingAttachmentAlert = true
                        }) {
                            AttachmentItemView(icon: "doc.fill", name: "Client_briefing.pdf")
                        }
                        
                        Button(action: {
                            selectedAttachment = "Client_assets.zip"
                            showingAttachmentAlert = true
                        }) {
                            AttachmentItemView(icon: "folder.fill", name: "Client_assets.zip")
                        }
                    }
                    
                    // Описание
                    Text("Description")
                        .font(.headline)
                        .foregroundColor(.primary)
                        .padding(.top)
                    
                    Text(task.taskDescription.isEmpty ? "No description provided" : task.taskDescription)
                        .font(.system(size: 16))
                        .fontWeight(.medium)
                        .foregroundColor(.primary)
                }
                .padding()
            }
            
            // MARK: - Кнопка редактирования баллов
            Button(action: {
                editScore = true
            }) {
                Text("Edit Score")
                    .font(.headline)
                    .fontWeight(.medium)
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 15)
                    .background(.gray)
                    .cornerRadius(8)
            }
            .padding(.horizontal)
            .padding(.bottom, 8)
            
            // MARK: - Кнопка закрытия
            Button(action: {
                presentationMode.wrappedValue.dismiss()
            }) {
                Text("Done")
                    .font(.headline)
                    .fontWeight(.medium)
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 15)
                    .background(Color.blue)
                    .cornerRadius(8)
            }
            .padding(.horizontal)
            .padding(.bottom, 20)
        }
        // MARK: - Навигация и модальные экраны
        .navigationTitle("Task Details")
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarItems(
            trailing: NavigationLink {
                AddingTaskPageView(isEdit: true, task: task)
                    .environmentObject(modelData)
            } label: {
                Image(systemName: "pencil")
                    .font(.system(size: 20, weight: .bold))
                    .foregroundColor(.primary)
                    .padding(.trailing, 8)
            }
        )
        // Sheet редактирования баллов
        .sheet(isPresented: $editScore) {
            NavigationView {
                Form {
                    Section {
                        Stepper(value: $editingScore, in: 0...task.maxScore) {
                            Text("Score: \(editingScore)/\(task.maxScore)")
                        }
                        .onChange(of: editingScore) {
                            modelData.updateTask(task, newScore: editingScore)
                        }
                    }
                }
                .navigationTitle("Edit Score")
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem(placement: .confirmationAction) {
                        Button("Done") {
                            modelData.updateTask(task, newScore: editingScore)
                            editScore = false
                        }
                    }
                }
            }
            .presentationDetents([.fraction(0.2)])
        }
        // Алерт выбора вложения
        .alert("Attachment Selected", isPresented: $showingAttachmentAlert) {
            Button("OK", role: .cancel) {}
        } message: {
            Text("You selected: \(selectedAttachment)")
        }
    }
}

// MARK: - Превью
struct TaskDetailsView_Previews: PreviewProvider {
    static let context = CoreDataManager.shared.context
    
    static var previews: some View {
        let mockTask = ClassTask(context: context)
        mockTask.id = UUID()
        mockTask.title = "Task test"
        mockTask.type = TypeOptions.ToDo.rawValue
        mockTask.status = StatusOptions.ToDo.rawValue
        mockTask.date = Date()
        mockTask.score = 50
        mockTask.maxScore = 100
        mockTask.taskDescription = "Description test"
        
        return NavigationView {
            TaskDetailsView(task: mockTask)
                .environmentObject(ModelData())
                .environment(\.managedObjectContext, context)
        }
    }
}
