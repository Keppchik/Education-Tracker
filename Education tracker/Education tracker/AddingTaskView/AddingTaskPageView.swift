//
//  AddingTaskPageView.swift
//  Education tracker
//
//  Created by Иван Миронов on 22.04.2025.
//

import SwiftUI


struct AddingTaskPageView: View {
    @State var isEdit = false
    
    //переменные для дочерних элементов
    @State var name: String = ""
    @State var selectedType: TypeOptions = .ToDo
    @State var selectedStatus: StatusOptions = .ToDo
    @State var deadline: Date = Date()
    @State var currentScore: Int = 0
    @State var maxScore: Int = 0
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
        .navigationTitle("New Task")
        
        Button(action: {  //TODO: добавить полноценный функционал кнопки, с схохранением и созданием таска
            guard !name.isEmpty else { showNameError = true; return }
            guard maxScore >= currentScore else { showMaxScoreError = true; return }
            if isEdit {
                presentationMode.wrappedValue.dismiss()
            } else {
                let newTask = TaskItem(title: name, date: deadline, score: currentScore, maxScore: maxScore, status: selectedStatus, type: selectedType, description: description)
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
}
