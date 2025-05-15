//
//  AddingTaskPageView.swift
//  Education tracker
//
//  Created by Иван Миронов on 22.04.2025.
//

import SwiftUI


struct AddingTaskPageView: View {
    @EnvironmentObject var modelData: ModelData
    
    @State var isEdit = false
    @State var task: ClassTask? = nil
    
    //переменные для дочерних элементов
    @State var name: String = ""
    @State var selectedType: TypeOptions = .ToDo
    @State var selectedStatus: StatusOptions = .ToDo
    @State var deadline: Date = Date()
    @State var currentScore: Int16 = 0
    @State var maxScore: Int16 = 0
    @State var description: String = ""
    
    @State private var showNameError = false
    @State private var showMaxScoreError = false
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        NavigationView {
            ScrollView{
                
                //===== Task Name =====
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
                
                //===== Type =====
                TypeTask(selectedType: $selectedType)
                    .padding(.vertical)
                
                //===== Deadline =====
                DeadlineView(selectedDate: $deadline)
                    .padding(.vertical)
                
                //===== Attachment =====
                AttachmentView()  //TODO: добавить функционал добавления файлов и их сохранения
                    .padding(.vertical)
                
                //===== Status =====
                StatusView(selectedStatus: $selectedStatus)
                    .padding(.vertical)
                
                //===== Score =====
                ScoreView(currentScore: $currentScore, maxScore: $maxScore, showMaxScoreError: $showMaxScoreError)
                    .padding(.vertical)
                
                //===== Notes/Describtion =====
                DescribtionView(descriptionText: $description)
                    .padding(.vertical)
                
            }
            .padding(.horizontal)
            .padding(.vertical)
            .scrollIndicators(.hidden)
        }
        .onAppear {
            if let task = task {
                name = task.title
                selectedType = TypeOptions(rawValue: task.type)!
                selectedStatus = StatusOptions(rawValue: task.status)!
                deadline = task.date
                currentScore = task.score
                maxScore = task.maxScore
                description = task.taskDescription
            }
        }
        .navigationTitle("New Task")
        
        Button(action: {
            guard !name.isEmpty else { showNameError = true; return }
            guard maxScore >= currentScore else { showMaxScoreError = true; return }
            if isEdit {
                modelData.updateTask(
                    task!,
                    newTitle: name,
                    isDone: selectedStatus == .Done ? true : false,
                    newDate: deadline,
                    newStatus: selectedStatus,
                    newDescription: description,
                    newType: selectedType,
                    newScore: currentScore,
                    newMaxScore: maxScore
                )
                
                presentationMode.wrappedValue.dismiss()
            } else {
                modelData.createTask(
                    title: name,
                    date: deadline,
                    description: description,
                    type: selectedType,
                    status: selectedStatus,
                    score: currentScore,
                    maxScore: maxScore,
                    isDone: selectedStatus == .Done ? true : false
                )
                presentationMode.wrappedValue.dismiss()
            }
        }) {
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
}


#Preview {
    AddingTaskPageView()
        .environmentObject(ModelData())
}

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
